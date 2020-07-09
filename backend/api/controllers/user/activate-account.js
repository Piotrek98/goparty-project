module.exports = {
    inputs:{
        uid: {type:'number', isInteger: true, required:true},
        code: {type:'number', isInteger: true, required:true}
    },
    exits:{

    },

    fn: async function(inputs, exits){
        const user = await User.findOne(inputs.uid)

        if(user.activateCode != inputs.code){
            return this.res.badRequest('Incorrect activate code.')
        }

        const accountUpdate = await User.updateOne(inputs.uid).set({ active: true })
        if(accountUpdate){
            return this.res.ok('Account has been activated')
        }else return this.res.badRequest('Account has not been activated')
    }
}