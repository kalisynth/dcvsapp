part of dcvsapp;

final String tableContact = "contact";
final String columnId = "_id";
final String columnName = "name";
final String columnSkypeName = "skype";

class Contact{
  int id;
  String name;
  String skypeName;

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
    columnName: name,
    columnSkypeName: skypeName
    };
    if(id != null){
      map[columnId] = id;
    }
    return map;
  }

  Contact();

  Contact.fromMap(Map<String, dynamic> map){
    id = map[columnId];
    name = map[columnName];
    skypeName = map[columnSkypeName];
  }
}