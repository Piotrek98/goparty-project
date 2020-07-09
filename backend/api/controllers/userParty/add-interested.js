module.exports = {

    friendlyName: 'Add',
  
    description: 'Add user to interested.',
  
    inputs: {
      uid: { type: 'number', required: true },
      pid: { type: 'number', required: true },
    },
  
    exits: {
  
    },
  
    fn: async function (inputs) {
      // let user = this.req.session.currentUser
      // if (user) {
      //   user = await sails.helpers.user.findOne(user.id, false, false)
      // } else return this.res.badRequest('User not logged in.')
  
      const party = await Party.findOne(inputs.pid)
      if (!party) return this.res.notFound()
      
      
      let relation = await UserPartyInterested.findOne({ user: inputs.uid, party: inputs.pid })
      if (relation) return this.res.badRequest('Already exists')
      else {
        relation = await UserPartyInterested.create({
          user: inputs.uid,
          party: inputs.pid,
          ..._.omit(inputs, ['uid', 'pid'])
        }).fetch()
      }

      interested = party.interested + 1;
      const updatepartyCount = await Party.updateOne(inputs.pid).set({interested: interested})

      return this.res.ok(relation)
    }
}
  