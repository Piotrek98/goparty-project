module.exports = {
    inputs: {
      id: { type: 'number', required: true }
    },
    exits: {
  
    },
  
    fn: async function ({ id }) {
      const party = await Party.findOne({ id })
                               .populate('takePartUsers')
                               .populate('organizer')
                               .populate('interestedUsers')
                               .populate('partyAvatar')
                               .populate('location')
  
      if (party) {
        return this.res.ok(party)
      } else return this.res.notFound()
    }
  }
  