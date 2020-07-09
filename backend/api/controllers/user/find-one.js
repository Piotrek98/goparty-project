const nestedPop = require('nested-pop')

module.exports = {
    friendlyName: 'Find one',
    description: 'Find one user',

    inputs: {
        id: {type: 'number', required: true}
    },
    exits:{

    },

    fn: async function(inputs){
        const user = await User.findOne({ where: {id: inputs.id}})
                               .populate('myEvents')
                               .populate('getInvolvedEvents')
                               .populate('myInterestedEvents')
                               .populate('myFollow')
                               .populate('followedBy')
                               .populate('profileImage')

        return this.res.ok(user)
    }
}       