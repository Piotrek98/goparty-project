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

      const party = await Party.findOne(inputs.pid)
      if (!party) return this.res.notFound()
        
      
      interested = party.interested - 1;
      const updatepartyCount = await Party.updateOne(inputs.pid).set({interested: interested})

      const relation = await UserPartyInterested.destroyOne({ user: inputs.uid, party: inputs.pid })
      if (relation) return this.res.ok(relation)
      else return this.res.notFound()
    }
  }
  