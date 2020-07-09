const bcrypt = require('bcryptjs')

module.exports = {
    friendlyName: 'Password encrypt',
    description: 'Encrypt password',

    inputs: {
        password: {type: 'string', required: true}
    },

    fn: async function({password}, exits){
        const salt = await bcrypt.genSalt(sails.config.custom.passwordEncryptionRounds)
        const hash = await bcrypt.hash(password, salt)
        if(hash){
            return exits.success(hash)
        }else{
            return exits.error()
        }
    }
}