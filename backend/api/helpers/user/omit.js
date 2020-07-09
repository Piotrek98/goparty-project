module.exports = {

  friendlyName: 'Omit sensitive data',

  sync: true,

  description: 'Returns fields to omit',

  inputs: {
    isAdmin: { type: 'boolean', required: false }
  },
  exits: {

    success: {
      description: 'All done.'
    }

  },

  fn: function ({ isAdmin = false }) {
    const res = ['password', 'resetPasswordToken',
      'resetPasswordTokenExpirationDate', 'confirmationToken']
    return res
  }

}
