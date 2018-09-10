part of dcvsapp;

class TabletModel{
  final String id;
  String name;
  String contacts;
  String games;
  DateTime lastSeen;
  String lastLocation;

  TabletModel({
    @required this.id,
    @required this.name,
    this.contacts,
    this.games,
    this.lastSeen,
    this.lastLocation,
}) : assert(id != null && id.isNotEmpty),
        assert(name != null && name.isNotEmpty),
        assert(lastSeen != null),
        assert(lastLocation != null && lastLocation.isNotEmpty);

  TabletModel.fromMap(Map<String, dynamic> data) :
      this(id: data['id'], name: data['name'], contacts: data['contacts'], games: data['games'], lastSeen: data['lastSeen'], lastLocation : data['lastLocation']);

  Map<String, dynamic> toMap() => {
    'id' : this.id,
    'name' : this.name,
    'contacts' : this.contacts,
    'games' : this.games,
    'lastSeen' : this.lastSeen,
    'lastLocation' : this.lastLocation,
  };
}

class SkypeContact{
  final String id;
  String name;
  String skypeName;

  SkypeContact({
    @required this.id,
    @required this.name,
    @required this.skypeName,
}) : assert(id != null && id.isNotEmpty),
        assert(name != null && name.isNotEmpty),
        assert(skypeName != null && skypeName.isNotEmpty);

  SkypeContact.fromMap(Map<String, dynamic> data) :
      this(id: data['id'], name: data['name'], skypeName : data['skypeName']);

  Map<String, dynamic> toMap() =>{
    'id' : this.id,
    'name' : this.name,
    'skypeName' : this.skypeName,
  };
}

class Game{
  final String id;
  final String name;
  final String url;

  Game({
    @required this.id,
    @required this.name,
    @required this.url,
  }) : assert(id != null && id.isNotEmpty),
      assert(name != null && name.isNotEmpty),
      assert(url != null && url.isNotEmpty);

  Game.fromMap(Map<String, dynamic> data) :
      this(id: data['id'], name: data['name'], url: data['url']);

  Map<String, dynamic> toMap() =>{
    'id' : this.id,
    'name' : this.name,
    'url' : this.url,
  };
}