const moment = require('moment')

module.exports = {
    inputs:{
        id:{type:'number', required:true},
        title:{type:'string', required:false},

        startDate:{type:'string', required:false},
        startTime:{type:'string', required:false},

        endDate:{type:'string', required:false},
        endTime:{type:'string', required:false},

        description:{type:'string', required:false},
        
        city:{type:'string', required:false},
        address:{type:'string', required:false},
        country:{type:'string', required:false},
        zipCode:{type:'string', required:false},

        
        entryType:{type:'string', isIn:['FREE', 'TICKET'],required:false},
        ticketCost:{type:'number', required:false},
        
        partyAvatar:{type:'number', required:false}
    },
    exits:{
        badRequest:{
            statusCode: 400,
            description: 'Wrong time intervals given.'
        }
    },

    fn: async function(inputs, exits){

        //TODO walidacja czasu 

        if(inputs.address || inputs.country || inputs.zipCode){
            const locate = await sails.helpers.party.geocoder(inputs.address, inputs.country, inputs.zipCode)
            if(!locate){
                return this.res.badRequest('Geocoder does not return data.')
            }

            const location = await Locations.create({
                latitude: locate[0].latitude,
                longitude: locate[0].longitude,
            }).fetch()
            const party = await Party.updateOne(inputs.id).set({inputs, location: location.id})

            if(party) return this.res.ok(party)  
            else return this.res.badRequest("Bad request")
        }

        const party = await Party.updateOne(inputs.id).set(inputs)

        if(party){
            return this.res.ok(party)
        }else return this.res.badRequest("Bad request")
    }
}