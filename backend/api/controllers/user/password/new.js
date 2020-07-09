
const uuid = require('uuid/v4')

module.exports = {

  friendlyName: 'New reset password token',

  description: 'Generates password reset token and sends it to provided email address',

  inputs: {
    email: { type: 'string', required: true, isEmail: true, in: 'query' }
  },

  exits: {
    badRequest: { responseCode: 400 }
  },

  fn: async function ({ email }, exits) {
    const data = {
      resetPasswordToken: uuid(),
      resetPasswordTokenExpirationDate: getExpirationDate()
    }
    const user = await User.updateOne({ email }).set(data)
    if (!user) {
      return exits.badRequest('Invalid email')
    } else {
      // await sails.helpers.email.resetPassword(user, data.resetPasswordToken)
      return exits.success()
    }
  }
}

function getExpirationDate () {
  const date = new Date()
  date.setDate(date.getDate() + sails.config.custom.resetPasswordTokenDaysToExpire)
  return date
}
