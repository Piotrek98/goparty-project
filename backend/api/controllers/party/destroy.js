module.exports = {
    friendlyName: 'Destroy',
  
    description: 'Destroy party',
  
    inputs: {
      id: { type: 'number', required: true }
    },
  
    exits: {
      success: {
        statusCode: 200,
        description: 'Party deleted successfully.'
      },
      error: {
        statusCode: 400
      }
  
    },
  
    fn: async function (inputs, exits) {
      const res = await Party.destroy(inputs.id)

      if (res) {
        return this.res.notFound()
      } else return this.res.ok()
    }
  }
  