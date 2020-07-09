module.exports = {

    friendlyName: 'Remove',
  
    description: 'Remove user party.',
  
    inputs: {
      uid: { type: 'number', isInteger: true, required: true },
      pid: { type: 'number', isInteger: true, required: true }
    },
  
    exits: {
  
    },
  
    fn: async function (inputs, exits) {
      // let user = this.req.session.currentUser
      // if (user) {
      //   user = await sails.helpers.user.findOne(user.id, false, false)
      // } else return this.res.badRequest('User not logged in.')

      const party = await Party.findOne(inputs.pid)
      if (!party) return this.res.notFound()

      partyCounts = party.freePlacesCount + 1;
      takeAparty = party.takeAparty - 1;
      const updatepartyCount = await Party.updateOne(inputs.pid).set({freePlacesCount: partyCounts, takeAparty:takeAparty})

      const relation = await UserParty.destroyOne({ user: inputs.uid, party: inputs.pid })
      if (relation) return this.res.ok(relation)
      else return this.res.notFound()
    }
  
  }
  