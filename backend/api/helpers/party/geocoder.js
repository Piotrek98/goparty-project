const NodeGeocoder = require('node-geocoder');

const options = {
    provider: 'opencage',
    // fetch: customFetchImplementation,
    apiKey: 'a793fa8dad514f74a214f02c9e7f417d',
    formatter: null
};

const geocoder = NodeGeocoder(options);

module.exports = {
    inputs:{
        address:{type:'string', required:true},
        city:{type:'string', required:true}
    },
    exits:{

    },

    fn: async function({address, city}){
        // const location = address + ' ' + city
        const response = await geocoder.geocode({
            address, city
        })
        return response
    }
}