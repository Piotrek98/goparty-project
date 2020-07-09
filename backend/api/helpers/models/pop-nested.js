module.exports = {

  friendlyName: 'Populates',

  sync: true,

  description: 'Populates models.',

  inputs: {
    table: { type: 'string', required: true }
  },

  fn: function ({ table }, exits) {
    const populates = {}
    switch (table) {
      case 'user':
      case 'users':
        // populates = {
        //   events: ['location', 'skills'],
        //   ownedGroups: { as: 'group', populate: ['event'] },
        //   groups: ['event']
        //   // skills: []
        // }
        break
      case 'location':

        break
      case 'news':

        break
      case 'event':

        break
      case 'group':
        // populates = {
        //   event: ['documents', 'location', 'skills', 'gallery']
        // }
        // if (userGroup !== sails.config.constants.userType.user) {
        //   populates.members = { as: 'user', populate: ['skills'] }
        // }

        break
      default:
        break
    }
    return exits.success(populates)
  }

}
