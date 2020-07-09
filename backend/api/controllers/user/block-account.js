module.exports = {
    inputs:{
        id:{type:'number', required:true, isInteger:true}
    },
    exits:{},

    fn: async function(inputs, exits){
        const user = await User.findOne(inputs.id)
        if(user){
            if(!user.active){
                return this.res.badRequest('The user is already disactivated.')
            }
        }else return this.res.notFound('User not found')

        const accountUpdate = await User.updateOne(inputs.uid).set({ active: false })
        if(accountUpdate.active){
            return this.res.badRequest('User has not been disactivated.')
        }else return this.res.ok('User has been disactivated.')
    }
}