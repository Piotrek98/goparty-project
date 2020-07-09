
module.exports = {

  friendlyName: 'Login',

  description: 'Login user.',

  inputs: {
    email: { type: 'string', required: true },
    password: { type: 'string', required: true },
    remember: { type: 'boolean' }
  },

  exits: {
    success: {
      statusCode: 200,
      description: 'Return User object and session cookie'
    },
    wrongCredentials: {
      statusCode: 404,
      description: 'Wrong password or User does not exists'
    },
    badRequest: {
      statusCode: 400
    }
  },

  fn: async function (inputs, exits) {
    sails.log('SessionID: ' + this.req.sessionID)

    let user = await regularLogin(inputs)

    if (!user) { 
      return exits.wrongCredentials('Wrong password or User does not exists')
    }
    // !!! TODO: TO UNCOMMENT !!!
    // if(!user.active){
    //   return this.res.badRequest('Account is not active.')
    // }

    if (inputs.remember === true) {
      this.req.session.cookie.expires = sails.config.custom.rememberMeCookieMaxAge
    }

    user = _.omit(user, sails.helpers.user.omit())
    this.req.session.currentUser = _.clone(user)

    const loggedInUser = await User.findOne(user.id).populate('profileImage')
    console.log(`USER WITH #${user.id} ID HAS LOGGED IN `)

    return exits.success(loggedInUser)
  }

}

async function regularLogin (inputs) {
  const user = await getUserObject({ email: inputs.email })
  if (!user || !await checkPassword(inputs.password, user.password)) {
    return undefined
  }

  return user
}

async function getUserObject (where) {
  return User.findOne(where)
}

async function checkPassword (plain, hash) {
  return sails.helpers.password.compare(plain, hash)
}
