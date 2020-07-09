module.exports = {

  friendlyName: 'Logout',

  description: 'Logout user.',

  inputs: {
  },

  exits: {
    success: {
      statusCode: 200,
      description: 'Logged out'
    }
  },

  fn: async function (inputs, exits) {
    this.req.session.destroy(error => {
      if (!error) { return exits.success() } else return exits.error(error)
    })
  }

}
