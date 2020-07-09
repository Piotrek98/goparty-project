module.exports = {
    tableName: 'user_party_interested',
    attributes: {
      user: { model: 'user', required: true },
      party: { model: 'party', required: true },
    }
}