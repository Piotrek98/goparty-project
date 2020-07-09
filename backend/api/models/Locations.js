module.exports = {
    tableName:'Locations',
    attributes:{
        createdAt: false,
        updatedAt:false,
        
        latitude:{type:'number'},
        longitude:{type:'number'},

        // country:{type:'string'},
        // city:{type:'string'},

        // state:{type:'string'},
        // zipcode:{type:'string'},

        // streetName:{type:'string'},
        // streetNumber:{type:'string'},

        // countryCode:{type:'string'},
        // county:{type:'string'},
    }
}