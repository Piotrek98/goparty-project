const nestedPop = require('nested-pop')

module.exports = {

  friendlyName: 'Get current user',

  description: 'Returns curren',

  inputs: {
    where: { type: 'ref', description: 'Where statement' },
    populates: { type: 'boolean' },
    popNested: { type: 'boolean' }
  },

  fn: async function ({ where, populates = true, popNested = true }) {
    if (!populates) {
      populates = {}
    } else {
      populates = sails.helpers.models.populates('user')
    }

    let usr = await User.findOne(where, populates)

    return usr
  }

}
