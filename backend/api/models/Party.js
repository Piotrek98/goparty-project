module.exports = {
    tableName:'party',
    attributes:{
        title:{type:'string', required:true},

        startDate:{type:'string', required:true},
        startTime:{type:'string', required:true},

        endDate:{type:'string', required:true},
        endTime:{type:'string', required:true},


        interested:{type:'number', required:false, isInteger:true},
        takeAparty:{type:'number', required:false, isInteger:true},

        description:{type:'string', required:true},

        city:{type:'string', required:true},
        address:{type:'string', required:true},
        // country:{type:'string', required:true},

        entryType:{type:'string', isIn:['FREE', 'LIMITED'],required:true},
        // ticketCost:{type:'number', required:false},

        location:{model:'Locations', required:false},
        
        freePlacesCount:{type:'number', required:false, isInteger:true},
        partyAvatar: {model:'Files', required:false},

        organizer:{model:'user', required:true},

        takePartUsers: {collection: 'user', via: 'party', through: 'userparty'},
        interestedUsers: {collection: 'user', via: 'party', through: 'userpartyinterested'},

        // distanceTo:{type:'number', required:false}
    },
}
