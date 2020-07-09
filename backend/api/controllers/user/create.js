const moment = require('moment')
const path = require('path')
const templatePath = path.join(sails.config.appPath, '/templates/confirmation.ejs')
const ejs = require('ejs')

module.exports = {
  friendlyName: 'Create',

  description: 'Register an user',

  inputs: {
    firstName:{type:'string', required:true},
    lastName:{type:'string', required:true},

    email:{type:'string', required:true, isEmail:true, unique:true},
    accountName:{type:'string', required:true},
 
    password: {
      type:'string',
      required:true,
      custom: function(value){
        return _.isString(value) &&
        value.length >= 6 && value.match(/[a-z]/i) && value.match(/[0-9]/);
      },

      profileImage: {type:'number', required:false}
    },

    // birthDate:{type:'string', required:true},
    // country:{type:'string', required:false},
    // phoneNumber:{
    //   type:'number',
    //   required:false,
    // },
  },

  exits: {
    success: {
      statusCode: 200,
      description: 'Registration success'
    },
  },

  fn: async function(inputs, exits){

    // const user =  await User.find()
    // for(const names of user.accountName){
    //   if(inputs.accountName == names){
    //     return this.res.badRequest('Account name is already in system.')
    //   }
    // }

    inputs.activateCode = await sails.helpers.user.codeGenerate()

    //TODO: wysyłanie kodu sms'em
    //wybrac jedna z opcji, preferowany SMS
    // await sails.helpers.email.sms.sendCodeSms(inputs.phoneNumber, inputs.activateCode)

    const ejsVariables = {
      firstName: inputs.firstName,
      activeCode: inputs.activateCode
    }

    const users = await User.find()

    //TODO: użyc tranzakcji
    for(u of users){
      if(inputs.email == u.email){
        return this.res.badRequest('Email is already taken.')
      }

      const user = await User.create(inputs).fetch()

      //TODO: !!! ODKOMENTOWAC NA ZAKONCZENIE BACKENDU I POPRAWIC TEMPLATKE Z POTWIERDZENIEM REJESTRACJI !!!
      // const html = await ejs.renderFile(templatePath, ejsVariables)
      // const subject = 'EventZone - potwierdzenie rejestracji'
      // const email = inputs.email
      // const res = await sails.helpers.email.send(email, subject, html)
      // if(!res || !html || !user){
      //   return this.res.badRequest('Confirmation email has not been send.')
      // }
      return exits.success(user) 
    }
  }
}
