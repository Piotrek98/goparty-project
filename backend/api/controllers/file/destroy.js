const fs = require('fs')
const path = require('path')

module.exports = {

  friendlyName: 'File download',

  description: 'Downloads a file in parameter',

  inputs: {
    id: { type: 'number', required: true}
  },

  exits: {
  },

  fn: async function (inputs, exits) {
    const attach = await Attachment.findOne(inputs.id)

    const localPath = path.join(sails.config.custom.uploadDirectory, attach.fileId)

    fs.unlink(localPath, (err) => {
      if (err) return exits.error(err)
    })

    const att = await Files.destroy(inputs.id)
    if(att){
      return this.res.notFound()
    }else return this.res.ok()
  }
}
