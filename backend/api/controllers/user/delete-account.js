module.exports = {
    friendlyName: 'Delete',
  
    description: 'Delete account',
  
    inputs: {
      id: { type: 'number', required: true }
    },
  
    exits: {
      success: {
        statusCode: 200,
        description: 'Account deleted successfully.'
      },
      error: {
        statusCode: 400
      }
  
    },
  
    fn: async function (inputs, exits) {
      const res = await User.destroy(inputs.id)

      if (res) {
        return this.res.notFound()
      } else return this.res.ok()
    }
  }
  