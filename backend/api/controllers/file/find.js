const path = require('path')

module.exports = {

  friendlyName: 'File download',

  description: 'Open a file in parameter',

  inputs: {
    id: { type: 'string', required: true, in: 'query' }
  },

  exits: {
    badRequest: {
      responseType: 'badRequest',
      description: 'Bad request'
    }
  },

  fn: async function ({ id }, exits) {

        this.res.set({
        'Content-disposition': `inline; filename="${id}"`,
        'Access-Control-Allow-Origin': '*'
        })
        
        const localPath = path.join(sails.config.custom.uploadDirectory, id)
        this.res.sendFile(localPath);
    }
}
