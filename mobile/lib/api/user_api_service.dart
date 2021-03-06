import 'dart:async';
import 'dart:core';
import 'package:http/http.dart' show Client;
import 'package:prod_name/models/User.dart';
import 'package:prod_name/constants/Constants.dart' as Constant;

class UserApiService {
  
  Client client = Client();
  Future<List<User>> getUsers() async{
      final response = await client.get('${Constant.baseURL}/user');
      if(response.statusCode == 200){
        return usersFromJson(response.body);
      }else return null;
  }

  Future<User> getUser(int id) async{
    final response = await client.get('${Constant.baseURL}/user/$id');
    if(response.statusCode == 200){
      return userFromJson(response.body);
    }else return null;
  }

  Future<bool> createUser(User data) async{
    final response = await client.post(
      '${Constant.baseURL}/user',
      headers: {"content-type":"application/json"},
      body: userToJson(data),
    );
    if(response.statusCode == 201){
      return true;
    }else return false;
  }

  Future<bool> updateUser(User data) async{
    final response = await client.put(
      '${Constant.baseURL}/user/${data.id}',
        headers: {"content-type":"application/json"},
        body: userToJson(data),
    );
    if(response.statusCode == 200){
      return true;
    }else return false;
  }

  Future<bool> logoutUser() async{
      final response = await client.post('${Constant.baseURL}/user/logout');
      if(response.statusCode == 200){
        return true;
      }else return false;
  }

  Future<bool> activateAccount(int id, int code) async{
      final body = {"code": '$code'};

      final response = await client.post(
        '${Constant.baseURL}/user/account/$id',
        body: body
      );
      // if(response.statusCode == 200){
      //   return true;
      // }else return false;
      return response.statusCode == 200;
  }

  Future<bool> deleteAccount(int id) async {
    final response = await client.delete('${Constant.baseURL}/user/$id');
    if(response.statusCode == 200){
      return true;
    }else return false;
  }

  Future<bool> addUserToObservation(int uid, int pid) async{
      final response = await client.put('${Constant.baseURL}/user/observation/$uid/$pid');
      if(response.statusCode == 200){
        return true;
      }else return false;
  }

  Future<bool> removeUserFromObservation(int uid, int pid) async{
      final response = await client.delete('${Constant.baseURL}/user/observation/$uid/$pid');
      if(response.statusCode == 200){
        return true;
      }else return false;
  }
}