const bcrypt = require('bcryptjs')

module.exports = {
    friendlyName: 'Compare password',
    description: 'Compares plain and ahashed password',

    inputs: {
        plain: {type: 'string', required: true},
        hash: {type: 'string', required: true}
    },

    fn: async function({plain, hash}, exits){
        const res = await bcrypt.compare(plain, hash)
        return exits.success(res)
    }
}