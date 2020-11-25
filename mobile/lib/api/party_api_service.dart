import 'package:http/http.dart' show Client;
import 'package:prod_name/models/Event.dart';
import 'package:prod_name/constants/Constants.dart' as Constant;

class PartyApiService {
  Client client = Client();

  Future<List<Event>> getEvents() async {
      final response = await client.get('${Constant.baseURL}/party');
      if(response.statusCode == 200){
        return eventsFromJson(response.body);
      }else return null;
  }

  Future<Event> getEvent(int id) async {
      final response = await client.get('${Constant.baseURL}/party/$id');
      if(response.statusCode == 200){
        return eventFromJson(response.body);
      }else return null;
  }

  Future<bool> deleteEvent(int id) async {
    final response = await client.delete('${Constant.baseURL}/party/$id');
    if(response.statusCode == 200) return true;
    else return false;
  }

  Future<bool> addUserToEventInterested(int uid, int pid) async {
    final response = await client.put('${Constant.baseURL}/user/party/interested/$uid/$pid');
    if(response.statusCode == 200) return true;
    else return false;
  }

  Future<bool> removeUserFromEventInterested(int uid, int pid) async {
    final response = await client.delete('${Constant.baseURL}/user/party/interested/$uid/$pid');
    if(response.statusCode == 200) return true;
    else return false;
  }

  Future<bool> addUserToEvent(int uid, int pid) async {
    final response = await client.put('${Constant.baseURL}/user/party/$uid/$pid');
    if(response.statusCode == 200) return true;
    else return false;
  }

  Future<bool> removeUserFromEvent(int uid, int pid) async {
    final response = await client.delete('${Constant.baseURL}/user/party/$uid/$pid');
    if(response.statusCode == 200) return true;
    else return false;
  }

  // Future<bool> updateUser(String data, int id) async{
  //   final response = await client.put(
  //     '$baseUrl/party/${id}',
  //       headers: {"content-type":"application/json"},
  //       body: eventFromJson(data),
  //   );
  //   if(response.statusCode == 200){
  //     return true;
  //   }else return false;
  // }
}