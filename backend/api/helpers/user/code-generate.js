//Generate 6 random digit code to activate account.

module.exports = {
    inputs:{},
    exits:{},

    fn: async function(){
        return Math.floor(1000 + Math.random() * 9000);
    }
}