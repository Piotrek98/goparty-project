/**
 * Policy Mappings
 * (sails.config.policies)
 *
 * Policies are simple functions which run **before** your actions.
 *
 * For more information on configuring policies, check out:
 * https://sailsjs.com/docs/concepts/policies
 */

module.exports.policies = {

  /***************************************************************************
  *                                                                          *
  * Default policy for all controllers and actions, unless overridden.       *
  * (`true` allows public access)                                            *
  *                                                                          *
  ***************************************************************************/



  // '*': true,
  'user/create':true,
  'user/login':true,
  'user/logout':'userLoggedIn',
  'user/current':'userLoggedIn',
  'user/find-one':'isAdmin',
  'user/find':'isAdmin',
  'user/update':['userLoggedIn','isAdmin'],

  'order/create':true,
  'order/destroy':'isAdmin',
  'order/find-one':'isAdmin',
  'order/update':'isAdmin',
  'order/find':'isAdmin',

  'userOrder/add':['isAdmin', 'userLoggedIn'],
  'userOrder/remove':'isAdmin'


};
