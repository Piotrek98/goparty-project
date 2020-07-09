module.exports = {

    friendlyName: 'Add',
  
    description: 'Add user to party.',
  
    inputs: {
      uid: { type: 'number', required: true },
      pid: { type: 'number', required: true },
    },
  
    exits: {
  
    },
  
    fn: async function (inputs) {
  
      const party = await Party.findOne(inputs.pid)
      if (!party) return this.res.notFound()
      
      partyCounts = party.freePlacesCount - 1;
      takeAparty = party.takeAparty + 1;
      const updatepartyCount = await Party.updateOne(inputs.pid).set({freePlacesCount: partyCounts, takeAparty:takeAparty})
      
      if(!updatepartyCount){
        return this.res.badRequest("Bad increase or decrease atributes.")
      }
  
      let relation = await UserParty.findOne({ user: inputs.uid, party: inputs.pid })
      if (relation) return this.res.badRequest('Already exists')
      else {
        relation = await UserParty.create({
          user: inputs.uid,
          party: inputs.pid,
          ..._.omit(inputs, ['uid', 'pid'])
        }).fetch()

        await User.removeFromCollection(inputs.uid, 'myInterestedEvents').members([inputs.pid])

        const content = `Weźmiesz udział w ${party.title}!`

        const notification = await Notification.create({
          title: 'Nowe powiadomienie',
          description: content,
          user: inputs.uid
        }).fetch()
        User.publish([inputs.uid], notification)


      }
    }
}
  