/**
 * Route Mappings
 * (sails.config.routes)
 *
 * Your routes tell Sails what to do each time it receives a request.
 *
 * For more information on configuring custom routes, check out:
 * https://sailsjs.com/anatomy/config/routes-js
 */

module.exports.routes = {

  // USER
  'POST /user': {
    action: 'user/create',
    swagger: {
      summary: 'Create new user'
    }
  },
  'PATCH /user/:id': {
    action: 'user/update',
    swagger: {
      summary: 'Update user by ID',
    }
  },

  'POST /user/login': {
    action: 'user/login',
    swagger: {
      summary: 'User login.'
    }
  },

  'GET /user/current': {
    action: 'user/current',
    swagger: {
      summary: 'Get current user.'
    }
  },
  'POST /user/logout': {
    action: 'user/logout',
    swagger: {
      summary: 'Logout user.'
    }
  },

  // 'DELETE /user/:id':{
  //   action: 'user/block-account',
  //   swagger: {
  //     summary: 'Disactivate account by ID'
  //   }
  // },

  'GET /user': {
    action: 'user/find',
    swagger: {
      summary: 'Find users'
    }
  },

  'DELETE /user/:id':{
    action: 'user/delete-account',
    swagger:{
      summary: 'Delete user by ID'
    }
  },

  'POST /user/account/:uid':{
    action:'user/activate-account',
    swagger: {
      summary: 'Activate account by code.'
    }
  },

  //OBSERVATION

  'PUT /user/observation/:uid/:fid': {
    action: 'user/observation/add-observation',
    swagger: {
      summary: 'Add user to observation.'
    }
  },

  'DELETE /user/observation/:uid/:fid':{
    action: 'user/observation/remove-observation',
    swagger:{
      summary: 'Remove user from observation.'
    }
  },

  //DISTANCE
  'GET /user/distance/:uid/:pid':{
    action:'user/get-distance',
    swagger: {
      summary: 'Get distance between user and party'
    }
  },



  //PARTY
  'POST /party':{
    action: 'party/create',
    swagger:{
      summary: 'Create party'
    }
  },

  'GET /party':{
    action: 'party/find',
    swagger:{
      summary: 'Get all party'
    }
  },

  'GET /party/:id':{
    action: 'party/find-one',
    swagger:{
      summary: 'Get party by ID'
    }
  },

  'PUT /party/:id':{
    action: 'party/update',
    swagger:{
      summary: 'Update party by ID'
    }
  },

  'DELETE /party/:id':{
    action: 'party/destroy',
    swagger:{
      summary: 'Delete party by ID'
    }
  },

  'GET /party/date':{
    action: 'filtres/find-by-date',
    swagger:{
      summary: 'Find party in time range.'
    }
  },

  'GET /party/cost':{
    action: 'filtres/find-by-ticket-cost',
    swagger:{
      summary: 'Find party by ticket cost range.'
    }
  },

  'GET /party/city':{
    action: 'filtres/find-by-city',
    swagger:{
      summary: 'Find party by city'
    }
  },


  //USER PARTY
  'PUT /user/party/:uid/:pid':{
    action: 'userParty/add',
    swagger:{
      summary: 'Add user to party'
    }
  },

  'DELETE /user/party/:uid/:pid':{
    action:'userParty/remove',
    swagger:{
      summary: 'Remove user from party'
    }
  },

  'PUT /user/party/interested/:uid/:pid':{
    action:'userParty/add-interested',
    swagger:{
      summary: 'Add user to party interested'
    }
  },

  'DELETE /user/party/interested/:uid/:pid':{
    action:'userParty/remove-interested',
    swagger:{
      summary: 'Remove user from party interested'
    }
  },

  //FILE
  'POST /file/create': {
    action: 'file/create',
    swagger: {
      summary: 'Upload file'
    }
  },

  'DELETE /file/:id': {
    action: 'file/destroy',
    swagger: {
      summary: 'Delete file'
    }
  },

  'GET /file/:id': {
    action: 'file/find',
    skipAssets: false,
  },

  'GET /file/find/:id': {
    action: 'file/find-one',
    swagger: {
      summary: 'Find file by ID'
    }
  },





};
