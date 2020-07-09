module.exports = {
    inputs:{
        city:{type:'string', required:true}
    },
    exits:{

    },

    fn: async function({city}){
        const party = await Party.find({where: {city: city}})

        if(party){
            return this.res.ok(party)
        }else return this.res.notFound('Not found any events in this destination.')
    }
}