module.exports = {

  friendlyName: 'Current',

  description: 'Current user.',

  inputs: {

  },

  exits: {

  },

  fn: async function (inputs) {
    let usr = this.req.session.currentUser
    if (usr) {
      usr = await sails.helpers.user.findOne(usr.id, true, true)
      usr = _.omit(usr, sails.helpers.user.omit(true))
      return this.res.ok(usr)
    } else return this.res.badRequest('User not logged in')
  }

}
