module.exports = {

  friendlyName: 'Reset User password',

  description: '',

  inputs: {
    token: { type: 'string', required: true, in: 'query', isUUID: true },
    password: { type: 'string', required: true }
  },

  exits: {
    badRequest: {
      description: 'Invalid token or password',
      responseCode: 400
    }
  },

  fn: async function ({ token, password }, exits) {
    // const user = await User.findOne( {resetPasswordToken: token} );
    // if(!user || user.resetPasswordTokenExpirationDate < new Date())
    //   return this.exits.badRequest('Invalid or expired token');
    const user = await User.updateOne({
      resetPasswordToken: token,
      resetPasswordTokenExpirationDate: { '>': new Date() }
    }).set({
      password,
      resetPasswordToken: '',
      resetPasswordTokenExpirationDate: 0
    })
    if (user) { return exits.success('Password changed') } else { return exits.badRequest('Invalid token or token expired') }
  }

}
