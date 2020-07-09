module.exports = {
    tableName: 'notification',
  
    attributes: {
  
      title: { type: 'string', required: true, maxLength: 30, columnType: 'varchar(30)' },
      description: { type: 'string', required: true, maxLength: 100, columnType: 'varchar(100)' },
    //   displayed: { type: 'boolean', defaultsTo: false },
  
      user: { model: 'user', required: true }
    }
  }