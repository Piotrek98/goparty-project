/* eslint-disable linebreak-style */
module.exports = {
  tableName:'user',
  attributes:{
    firstName:{type:'string', required:true},
    lastName:{type:'string', required:true},

    accountName:{type:'string', required:true},

    email:{type:'string', required:true, isEmail:true, unique:true},
    password:{type:'string', required:true, minLength:6, maxLength:128},

    // birthDate:{type:'string', required:true},
    // country:{type:'string', required:false},
    // phoneNumber:{type:'number', required:false},

    confirmationToken:{type:'string', isUUID:true},
    resetPasswordToken:{type:'string', isUUID:true},
    resetPasswordTokenExpirationDate: {type:'number', isInteger:true},

    profileImage:{model:'Files', required:false},

    active: {type: 'boolean', defaultsTo: false},
    activateCode: {type:'number', required:false},

    myEvents: {collection: 'party'},

    getInvolvedEvents: {collection: 'party', via: 'user', through: 'userparty'},
    myInterestedEvents: {collection:'party', via:'user', through: 'userpartyinterested'},

    countFollowedBy: {type:'number', required:false},
    followedBy: {collection:'user', via:'friend', through: 'userobservation'},
    
    countMyFollows: {type:'number', required:false},
    myFollows: {collection:'user'},

    notifications: { collection: 'notification', via: 'user' },

    admin:{type:'boolean', required:false},

    latitude:{type:'number', required:false},
    longitude:{type:'number', required:false}

  },

  beforeCreate: async(valuesToSet, proceed) => {
    await encryptPassword(valuesToSet);
    proceed();
  },

  beforeUpdate: async(valuesToSet, proceed) => {
    await encryptPassword(valuesToSet);
    proceed();
  },

  customToJSON: function(){
    return _.omit(this, ['updatedAt', 'createdAt', 'password', 'confirmationToken', 'resetPasswordToken', 'resetPasswordTokenExpirationDate', 'activateCode']);
  }
};

async function encryptPassword (params) {
  if(!params.password) {
    return;
  }
  const encryptedPassword = await sails.helpers.password.encrypt(params.password);
  params.password = encryptedPassword;

}
