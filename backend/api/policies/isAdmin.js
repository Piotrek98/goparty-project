module.exports = async function (req, res, proceed) {
    const isAdmin = await sails.helpers.user.isAdmin(req)
    if (isAdmin) {
      return proceed()
    } else {
      return res.forbidden('Not admin')
    }
  }
  