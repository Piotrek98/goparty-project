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

      partyCounts = party.freePlacesCount + 1;
      takeAparty = party.takeAparty - 1;
      const updatepartyCount = await Party.updateOne(inputs.pid).set({freePlacesCount: partyCounts, takeAparty:takeAparty})

      const relation = await UserParty.destroyOne({ user: inputs.uid, party: inputs.pid })
      if (relation) return this.res.ok(relation)
      else return this.res.notFound()
    }
  
  }
  