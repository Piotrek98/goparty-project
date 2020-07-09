module.exports = {
    inputs:{
        maxTicketCost: {type:'number', required:true}
    },
    exits:{

    },

    fn: async function({maxTicketCost}){
        const party = await Party.find({ticketCost:{ '<=':maxTicketCost }})

        if(party){
            return this.res.ok(party)
        }else return this.res.notFound('Not found any event in provided ticket cost range.')
    }
}