module.exports = {
    friendlyName: '',
    description: '',
  
    inputs: {},
    exits: {},
  
    fn: async function (inputs, exits) {

      // const party = await Party.find()
      // for(const p of party){
      //   let user = this.req.session.currentUser
      //   if(user){
      //     user = await sails.helpers.user.findOne(user.id, false, false)
      //     const location = await Locations.findOne(p.location)
      //     const distanceBetween = await sails.helpers.user.getDistance(
      //         user.latitude, user.longitude,
      //         location.latitude, location.longitude 
      //     )
      //     distanceTo = distanceBetween/1000;
      //     const updatePartyDistanceTo = await Party.updateOne(p.id).set({distanceTo: distanceTo})
      //     if(!updatePartyDistanceTo) return this.res.badRequest('Location has not been updated.')
      //   }
      // }
      const updatedParty = await Party.find()
      if(updatedParty){
        return this.res.ok(updatedParty)
      }else return this.res.notFound('Not found any events')
    }
  }
  