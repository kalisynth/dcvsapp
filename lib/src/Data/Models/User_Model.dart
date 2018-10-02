part of dcvsapp;

class UserItem {
  final String id;
  String userId;
  String deviceId;

  UserItem({
    @required this.id,
    @required this.userId,
    @required this.deviceId,
  })  : assert(id != null && id.isNotEmpty),
        assert(userId != null && userId.isNotEmpty),
        assert(deviceId != null && deviceId.isNotEmpty);

  UserItem.fromMap(Map<String, dynamic> data)
      : this(
            id: data['id'], userId: data['userId'], deviceId: data['deviceId']);

  Map<String, dynamic> toMap() =>
      {'id': this.id, 'userId': this.userId, 'deviceId': this.deviceId};
}
