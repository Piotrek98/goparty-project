module.exports = {

    friendlyName: 'Remove',
  
    description: 'Remove observation.',
  
    inputs: {
      fid: { type: 'number', isInteger: true, required: true },
      uid: { type: 'number', isInteger: true, required: true }
    },
  
    exits: {
  
    },
  
    fn: async function (inputs, exits) {
      // let user = this.req.session.currentUser
      // if (user) {
      //   user = await sails.helpers.user.findOne(user.id, false, false)
      //   inputs.user = user.id
      // } else return this.res.badRequest('User not logged in')

      const friend = await User.findOne(inputs.fid)
      if (!friend) return this.res.notFound()

      const user = await User.findOne(inputs.uid)
      if (!user) return this.res.notFound()

      await User.removeFromCollection(user.id, 'myFollows').members([inputs.fid])
        
      const followsCount = user.countMyFollows + 1
      await User.updateOne(user.id).set({countMyFollows: followsCount})

      const followedCount = friend.countFollowedBy + 1
      await User.updateOne(friend.id).set({countFollowedBy: followedCount})

      const relation = await UserObservation.destroyOne({ user: user.id, friend: inputs.fid })
      if (relation) return this.res.ok('Observation deleted.')
      else return this.res.notFound()
    }
  }