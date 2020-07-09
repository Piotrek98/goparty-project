/**
 * Custom configuration
 * (sails.config.custom)
 *
 * One-off settings specific to your application.
 *
 * For more information on custom configuration, visit:
 * https://sailsjs.com/config/custom
 */

// import { version } from './package.json'
const process = require('process')

module.exports.custom = {

  /***************************************************************************
  *                                                                          *
  * Any other custom config this Sails app should use during development.    *
  *                                                                          *
  ***************************************************************************/

  uploadedFileMaxSize: 10485760, // 10MB
  uploadDirectory: `${process.cwd()}/uploadedFiles`,
  uploadAllowedMimeTypes: ['image/jpeg', 'image/png', 'image/gif',
    /*'application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'*/],

  resetPasswordTokenDaysToExpire: 1,
  passwordEncryptionRounds: 10,
  rememberMeCookieMaxAge: 30 * 24 * 60 * 60 * 1000, // 30 days

  vacationHoursPerDay: 8,

  email: {
    host: 'smtp.gmail.com',
    port: 587,
    secure: false,
    requireTLS: true,
    // service: 'Gmail',
    auth: {
      user: '...', pass: '...'
    }
  },

  baseUrl: 'http://localhost:80/',

  version: require('../package.json').version

}
