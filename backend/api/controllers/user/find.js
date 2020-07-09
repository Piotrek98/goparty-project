module.exports = {
    fiendlyName: '',
    description: '',

    inputs: {

    },

    exits: {

    },
    //dodac paginacje
    fn: async function({inputs}){
        const users = await User.find({select: ['id', 'firstName', 'lastName']})
                                // .populate('takeAPartInEvent')
                                // .populate('myInterestedEvents')
                                // .populate('followedBy', {select:['firstName', 'lastName']})
                                // .populate('myFollow', {select:['firstName', 'lastName']})
        
        if(users){
            return this.res.ok(users)
        }else return this.res.notFound()
        
    }
}