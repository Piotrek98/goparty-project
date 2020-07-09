// /**
//  * Seed Function
//  * (sails.config.bootstrap)
//  *
//  * A function that runs just before your Sails app gets lifted.
//  * > Need more flexibility?  You can also create a hook.
//  *
//  * For more information on seeding your app with fake data, check out:
//  * https://sailsjs.com/config/bootstrap
//  */

module.exports.bootstrap = async function() {
  await User.findOrCreate({email:'admin@admin.pl'},{
    firstName:'admin',
    lastName:'admin',
    accountName:'Kot filemon',
    email:'admin@admin.pl',
    password:'Test1234',
    admin:true,
    profileImage:null,
    activateCode: 000000,
    latitude:53.471970,
    longitude:15.334050,
    countFollowedBy: 0,
    countMyFollows: 0,
    active: true
  });  
};
