module.exports = {
    
    friendlyName: 'Add',
  
    description: 'Add user to observations.',

    inputs: {
        uid:{type:'number', isInteger:true, required:true},
        fid:{type:'number', isInteger:true, required:true}
    },
    exits:{
        badRequest:{
            statusCode: 400,
            description: 'User is already in your observations.'
        }
    },

    fn: async function (inputs, exits) {

        // let user = this.req.session.currentUser
        // if (user) {
        //   user = await sails.helpers.user.findOne(user.id, false, false)
        //   inputs.user = user.id
        // } else return this.res.badRequest('User not logged in')
        const user = await User.findOne(inputs.uid)
        if (!user) return this.res.notFound()

        const friend = await User.findOne(inputs.fid)
        if (!friend) return this.res.notFound()

        if(inputs.fid == inputs.uid) return this.res.badRequest("You can't add yourself to friends.")

        //add to myFollow
        await User.addToCollection(inputs.uid, 'myFollows').members([inputs.fid])
        
        const followsCount = user.countMyFollows + 1
        await User.updateOne(inputs.uid).set({countMyFollows: followsCount})

        const followedCount = friend.countFollowedBy + 1
        await User.updateOne(friend.id).set({countFollowedBy: followedCount})
        
        let relation = await UserObservation.findOne({ user: inputs.uid, friend: inputs.fid })
        if (relation) return this.res.badRequest('User is already in your observations.')
        else {
          relation = await UserObservation.create({
            user: inputs.uid,
            friend: inputs.fid,
            ..._.omit(inputs, ['uid', 'fid'])
          }).fetch()
        }

        return this.res.ok('User was added to observation.')
      }
}