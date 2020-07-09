module.exports = {
    inputs:{
        id:{type:'number', required:true, isInteger:true}
    },
    exits:{},

    fn: async function(inputs, exits){
        const file = await Files.findOne(inputs.id);

        if(file){
            return this.res.ok(file)
        }else return this.res.notFound()
    }
}