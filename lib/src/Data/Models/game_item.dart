part of dcvsapp;

class GameItem{
  final String id;
  String gameName;
  String gameUri;

  GameItem({
    @required this.id,
    @required this.gameName,
    @required this.gameUri,
}) : assert(id != null && id.isNotEmpty),
  assert(gameName != null && gameName.isNotEmpty),
  assert(gameUri != null && gameUri.isNotEmpty);

  GameItem.fromMap(Map<String, dynamic> data)
  : this(
    id: data['id'],
    gameName: data['gameName'],
    gameUri: data['gameUri']
  );

  Map<String, dynamic> toMap() => {
    'id': this.id,
    'gameName' : this.gameName,
    'gameUri' : this.gameUri,
  };
}