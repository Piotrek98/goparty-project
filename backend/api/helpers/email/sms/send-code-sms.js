// SEND ACTIVE CODE BY SMS
// TO ACTIVE UST BE CREATE ACCOUNT on twilio.com and pay for subscription

const accountSid = 'ACXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
const authToken = 'your_auth_token';
const client = require('twilio')(accountSid, authToken);

module.exports = {
    inputs:{
        number:{type:'number', required:false},
        code:{type:'number', required:false}
    },
    exports:{},

    fn: async function({number, code}){
        const body = `Activate code: ${code}`

        client.messages
            .create({
                body: body,
                //TODO: add number
                from: '+48 ***',
                to: number
            })
            .then(message => console.log(message.sid));
    }
}