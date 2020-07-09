module.exports = {
    fiendlyName: '',
    description: '',

    inputs: {

    },

    exits: {

    },
    //doadd pagination
    fn: async function({inputs}){
        const users = await User.find({select: ['id', 'firstName', 'lastName']})

        
        if(users){
            return this.res.ok(users)
        }else return this.res.notFound()
        
    }
}