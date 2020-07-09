module.exports = {

  friendlyName: 'Is admin',

  description: '',

  inputs: {
    req: { type: 'ref', required: true }
  },

  exits: {

    success: {
      description: 'All done.'
    }

  },

  fn: async function ({ req }) {
    if (req.session.currentUser) {
      const user = await sails.helpers.user.findOne(req.session.currentUser.id, false, false)
      return user && user.admin === true
    }
    return false
  }

}
