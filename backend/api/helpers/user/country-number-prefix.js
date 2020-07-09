module.exports = {
    inputs:{
        country:{type:'string', required:true}
    },
    exits:{

    },

    fn: async function({country}){
        switch(country){

            //44 country
        
            //EUROPEAN UNION
            case 'Austria':
                return 43;
            case 'Belgium':
                return 32;
            case 'Bulgaria':
                return 359;
            case 'Croatia':
                return 385;
            case 'Cyprus':
                return 357;
            case 'Czech Republic':
                return 420;
            case 'Denmark':
                return 45;
            case 'Estonia':
                return 372;
            case 'Finland':
                return 358;
            case 'France':
                return 33;
            case 'Gibraltar':
                return 350;
            case 'Germany':
                return 49;
            case 'Greece':
                return 30;
            case 'Hungary':
                return 36;
            case 'Iceland':
                return 354;
            case 'Ireland':
                return 353;
            case 'Italy':
                return 39;
            case 'Latvia':
                return 371;
            case 'Liechtenstein':
                return 423;
            case 'Lithuania':
                return 370;
            case 'Luxembourg':
                return 352;
            case 'Malta':
                return 356;
            case 'Netherlands':
                return 31;
            case 'Norway':
                return 47;
            case 'Poland':
                return 48;
            case 'Portugal':
                return 351;
            case 'Romania':
                return 40;
            case 'Slovakia':
                return 421;
            case 'Slovenia':
                return 386;
            case 'Spain':
                return 34;
            case 'Sweden':
                return 46;

            //OTHER EUROPEAN
            case 'Russia':
                return 7;
            case 'Monaco':
                return 377;
            case 'Serbia':
                return 381;
            case 'Switzerland':
                return 41;
            case 'Turkey':
                return 90;
            case 'United Kingdom':
                return 44;
            case 'Ukraine':
                return 380;

            //OTHER WORLD
            case 'Canada' || 'USA':
                return 1;
            case 'Australia':
                return 61;
            case 'Brazil':
                return 55;
            case 'China':
                return 86;
            case 'Colombia':
                return 57;
            case 'Japan':
                return 81;
            

        }
    }
}