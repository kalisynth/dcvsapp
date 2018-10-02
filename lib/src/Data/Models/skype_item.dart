part of dcvsapp;

class SkypeItem {
  final String id;
  String skypeName;
  String skypeId;
  bool serviceProvider;

  SkypeItem({
    @required this.id,
    @required this.skypeId,
    this.serviceProvider = false,
    this.skypeName,
  })  : assert(id != null && id.isNotEmpty),
        assert(serviceProvider != null),
        assert(skypeId != null && skypeId.isNotEmpty);

  SkypeItem.fromMap(Map<String, dynamic> data)
      : this(
            id: data['id'],
            skypeId: data['skypeId'],
            skypeName: data['skypeName'],
            serviceProvider: data['service'] ?? false);

  Map<String, dynamic> toMap() => {
        'id': this.id,
        'skypeId': this.skypeId,
        'skypeName': this.skypeName,
    'serviceProvider' : this.serviceProvider,
      };
}
