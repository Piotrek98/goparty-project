module.exports = {
    inputs:{
        pid: {type:'number', required:true, isInteger:true}
    },
    exits:{

    },

    fn: async function(inputs, exits){
        let user = this.req.session.currentUser
        if (user) {
          user = await sails.helpers.user.findOne(user.id, false, false)
        } else return this.res.badRequest('User not logged in.')

        console.log(user.latitude)
        console.log(user.longitude)

        const party = await Party.findOne(inputs.pid)
        if(!party) return this.res.notFound('Party not found')

        const location = await Locations.findOne(party.location)
        console.log(location.latitude)
        console.log(location.longitude)


        const distanceBetween = await sails.helpers.user.getDistance(
            user.latitude, user.longitude,
            location.latitude, location.longitude
        )

        return this.res.ok(distanceBetween/1000)
    }
}