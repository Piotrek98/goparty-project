module.exports = {
    inputs:{
        from:{type:'string', required:true},
        to:{type:'string', required:true}
    },
    exits:{

    },

    fn: async function({from, to}){
        const party = await Party.find({startDate:{'>=':from, '<=':to}})

        if(party){
            return this.res.ok(party)
        }else return this.res.notFound('Not found any events in provided time range.')
    }
}