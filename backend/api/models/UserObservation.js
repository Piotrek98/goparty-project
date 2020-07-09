module.exports = {
    tableName: 'user_observation',
    attributes: {
      user: { model: 'user', required: true },
      friend: { model: 'user', required: true },
    }
}