part of dcvsapp;

class SkypeItem {
  final String id;
  String skypeName;
  String skypeId;
  bool serviceProvider;
  String serviceProviderName;

  SkypeItem({
    @required this.id,
    @required this.skypeId,
    this.serviceProvider = false,
    this.skypeName,
    this.serviceProviderName,
  })  : assert(id != null && id.isNotEmpty),
        assert(serviceProvider != null),
        assert(skypeId != null && skypeId.isNotEmpty);

  SkypeItem.fromMap(Map<String, dynamic> data)
      : this(
            id: data['id'],
            skypeId: data['skypeId'],
            skypeName: data['skypeName'],
            serviceProviderName: data['serviceProviderName'],
            serviceProvider: data['service'] ?? false);

  Map<String, dynamic> toMap() => {
        'id': this.id,
        'skypeId': this.skypeId,
        'skypeName': this.skypeName,
        'serviceProvider': this.serviceProvider,
        'serviceProviderName': this.serviceProviderName,
      };
}
