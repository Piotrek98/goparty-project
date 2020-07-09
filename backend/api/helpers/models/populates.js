module.exports = {

  friendlyName: 'Populates',

  sync: true,

  description: 'Populates models.',

  inputs: {
    table: { type: 'string', required: true }
  },

  fn: function ({ table }, exits) {
    let populates = {}
    switch (table) {
      case 'user':
      case 'users':
        populates = {
          // companies: {}
        }
        //   type: {},
        //   address: {},
        //   notifications: { limit: 5, sort: 'createdAt DESC' },
        //   // events: {},
        //   groups: {},
        //   ownedGroups: {},
        //   skills: {},
        //   origin: {}

        // }
        break
      default:
        break
    }
    return exits.success(populates)
  }

}
