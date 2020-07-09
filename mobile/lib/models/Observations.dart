class Observations {
  final int id;
  final String firstName;
  final String lastName;
  final String accountName;
 
  Observations({this.id, this.firstName, this.lastName, this.accountName});
 
  factory Observations.fromJson(Map<String, dynamic> parsedJson) {
    return Observations(
      id: parsedJson['id'], 
      firstName: parsedJson['firstName'],
      lastName: parsedJson['lastName'],
      accountName: parsedJson['accountName'],
      );
  }
}