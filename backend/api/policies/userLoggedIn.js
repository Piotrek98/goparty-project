module.exports = async function (req, res, proceed) {
    if (req.session.currentUser) { return proceed() } else { return res.forbidden() }
  }
  