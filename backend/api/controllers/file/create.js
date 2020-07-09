const path = require('path')

module.exports = {

  friendlyName: 'File upload',

  description: 'Uploads a file in parameter',

  inputs: {

  },

  exits: {
    badRequest: {
      responseType: 'badRequest',
      description: 'Bad request'
    }
  },

  fn: async function (inputs, exits) {
    const file = this.req.file('file')

    if (!file || file._files.length !== 1 ||
      !_.includes(sails.config.custom.uploadAllowedMimeTypes, file._files[0].stream.headers['content-type'])) {
      file.upload({ noop: true }) // prevent server from crash
      return exits.badRequest()
    }

    file.upload({
      maxBytes: sails.config.custom.uploadedFileMaxSize,
      dirname: sails.config.custom.uploadDirectory
    }, async (err, uploadedFiles) => {
      if (err) { return exits.error(err) }
      if (uploadedFiles.length === 0) { return exits.badRequest('No file was uploaded') }

      const baseUrl = sails.config.custom.baseUrl
      
      const fileId = path.basename(uploadedFiles[0].fd)
      const content = `${baseUrl}/file/${fileId}`;
      
      const file = await Files.create({fileId: fileId, content: content}).fetch()
      if(file){
        return this.res.ok(file)
      }else return this.res.badRequest()

    })
  }
}
