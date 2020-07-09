const transporter = require('nodemailer').createTransport(sails.config.custom.email)

module.exports = {
    inputs:{
        to: { type:'string', required:true },
        subject: { type:'string', required:true},
        html: {type:'string', required:true}
    },
    exits:{
        success: {
            description: 'All done.'
          }
    },

    fn: async function (inputs, exits) {
        const options = {
          from: sails.config.custom.email.auth.user,
          to: inputs.to,
          subject: inputs.subject,
          html: inputs.html
    
        }
        transporter.sendMail(options, (err, info) => {
          if (err) {
            return exits.error(err)
          } else {
            return exits.success(info.response)
          }
        })
      }
}