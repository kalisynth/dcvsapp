part of dcvsapp;

class DeviceItem {
  final String id;
  String deviceId;
  String userId;
  String lastSeen;
  String lastLocation;

  DeviceItem({
    @required this.id,
    @required this.userId,
    this.deviceId,
    this.lastSeen,
    this.lastLocation,
  })  : assert(id != null && id.isNotEmpty),
        assert(userId != null && userId.isNotEmpty),
        assert(deviceId != null),
        assert(lastSeen != null),
        assert(lastLocation != null && lastLocation.isNotEmpty);

  DeviceItem.fromMap(Map<String, dynamic> data)
      : this(
            id: data['id'],
            deviceId: data['deviceId'],
            userId: data['userId'],
            lastSeen: data['lastSeen'],
            lastLocation: data['lastLocation']);

  Map<String, dynamic> toMap() => {
        'id': this.id,
        'deviceId': this.deviceId,
        'userId': this.userId,
        'lastSeen': this.lastSeen,
        'lastLocation': this.lastLocation,
      };
}