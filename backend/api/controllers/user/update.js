const transaction = sails.getDatastore().transaction

module.exports = {

  friendlyName: 'Update',

  description: 'Update user.',

  inputs: {
    id: { type: 'number', required: true },

    firstName:{type:'string', required:false},
    lastName:{type:'string', required:false},
    accountName:{type:'string', required:false},


    email:{type:'string', required:false, isEmail:true, unique:true},

    profileImage:{type:'number', required:false},

    latitude:{type:'number', required:false},
    longitude:{type:'number', required:false}
  },

  exits: {
    badRequest: { statusCode: 400 }
  },

  fn: async function (inputs, exits) {
    // if (!await sails.helpers.user.isAdmin(this.req)) {
    //   if (inputs.id !== this.req.session.currentUser.id || _.has(inputs, 'active')) {
    //     return this.res.forbidden()
    //   }
    // }

    await transaction(async (db) => {
      const user = await User.updateOne(
        inputs.id
      ).set(inputs).usingConnection(db)
      if (user) { return exits.success('User updated') } else { return exits.badRequest('Invalid User id') }
    }).intercept('E_INVALID_ADDRESS', 'badRequest')
  }

}
