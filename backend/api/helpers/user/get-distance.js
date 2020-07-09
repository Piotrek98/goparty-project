const geolib = require('geolib')

module.exports = {
    inputs:{
        latitudeOne:{type:'number', require:true},
        longitudeOne:{type:'number', require:true},

        latitudeTwo:{type:'number', require:true},
        longitudeTwo:{type:'number', require:true}
    },
    exits:{

    },

    fn: async function({latitudeOne, latitudeTwo, longitudeOne, longitudeTwo}){
        return geolib.getDistance(
            {latitude: latitudeOne, longitude: longitudeOne},
            {latitude: latitudeTwo, longitude: longitudeTwo}
        )
    }
}