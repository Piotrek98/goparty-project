const moment = require('moment')

module.exports = {
    inputs:{
        title:{type:'string', required:true},

        startDate:{type:'string', required:true},
        startTime:{type:'string', required:true},

        endDate:{type:'string', required:true},
        endTime:{type:'string', required:true},

        description:{type:'string', required:true},
        
        city:{type:'string', required:true},
        address:{type:'string', required:true},

        entryType:{type:'string', isIn:['FREE', 'LIMITED'],required:true},
        freePlacesCount:{type:'string', required:true},

        partyAvatar:{type:'number', required:false},

        organizer:{type:'string', required:false}
    },
    exits:{
        badRequest:{
            statusCode: 400,
            description: 'Wrong time intervals given.'
        }
    },

    fn: async function(inputs, exits){

        if(!moment(moment(inputs.startDate, 'DD/MM/YYYY').format('YYYY-MM-DD') + 'T' + moment(inputs.startTime, 'HH:mm').format('HH:mm') + 'Z')
            .isBefore(moment(inputs.endDate, 'DD/MM/YYYY').format('YYYY-MM-DD') + 'T' + moment(inputs.endTime, 'HH:mm').format('HH:mm') + 'Z')){
                    return this.res.badRequest('Wrong time range provided')
        }

        frePlacesCount = parseInt(inputs.freePlacesCount)
        organizer = parseInt(inputs.organizer)

        // let user = this.req.session.currentUser
        // if (user) {
        //   user = await sails.helpers.user.findOne(user.id, false, false)
        //   inputs.organizer = user.id
        // } else return this.res.badRequest('User not logged in.')
        

        const locate = await sails.helpers.party.geocoder(inputs.address, inputs.city)
        if(!locate){
            return this.res.badRequest('Geocoder does not return data.')
        }

        const location = await Locations.create({
            latitude: locate[0].latitude,
            longitude: locate[0].longitude,
        }).fetch()

        const party = await Party.create({freePlacesCount: frePlacesCount, location: location.id, ...inputs}).fetch()

        if(!party){
            return this.res.badRequest("Party was not created.");
        }

        await User.addToCollection(organizer, 'myEvents').members([party.id])
        await User.addToCollection(organizer, 'getInvolvedEvents').members([party.id])

        return this.res.ok(party)
    }
}
