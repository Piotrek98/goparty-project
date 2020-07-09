module.exports = {

  friendlyName: 'Changes User password',

  description: '',

  inputs: {
    oldPassword: { type: 'string', required: true },
    newPassword: {
      type:'string',
      required:true,
      custom: function(value){
        return _.isString(value) &&
        value.length >= 6 && value.match(/[a-z]/i) && value.match(/[0-9]/);
      }
    }
  },

  exits: {
    badRequest: {
      description: 'Invalid token or password',
      responseCode: 400
    }
  },

  fn: async function ({ oldPassword, newPassword }, exits) {
    let user = this.req.session.currentUser
    if (user) {
      user = await User.findOne(user.id)
      if (await checkPassword(oldPassword, user.password) && oldPassword !== newPassword) {
        user = await User.updateOne({
          id: user.id
        }).set({
          password: newPassword
        })
        if (user) { return exits.success('Password changed') } else { return exits.badRequest('Invalid token or password') }
      } else return exits.badRequest('Wrong password')
    } else return exits.badRequest('Not logged in')
  }

}

async function checkPassword (plain, hash) {
  return sails.helpers.password.compare(plain, hash)
}
