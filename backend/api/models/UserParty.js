module.exports = {
    tableName: 'user_party',
    attributes: {
      user: { model: 'user', required: true },
      party: { model: 'party', required: true },
    }
}