part of dcvsapp;

final Firestore db = Firestore.instance;

final CollectionReference deviceCollection = db.collection('devices');
final CollectionReference userCollection = db.collection('users');
final CollectionReference skypeCollection = db.collection('contacts');
final CollectionReference gameCollection = db.collection('games');

class GeneralStorage{
  String TAG = "GENERALSTORE";

  Stream<QuerySnapshot> generateListFromCollection(CollectionReference collection, {int offset, int limit}){
    Stream<QuerySnapshot> snapshots = collection.snapshots();
    if(offset != null){
      snapshots = snapshots.skip(offset);
    }
    if(limit != null){
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Stream<QuerySnapshot> generateListFromCollectionWithQuery(CollectionReference collection, String field, String match, {int offset, int limit}){
    Stream<QuerySnapshot> snapshots = collection.where(field, isEqualTo: match).snapshots();
    if(offset != null){
      snapshots = snapshots.skip(offset);
    }
    if(limit != null){
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Future<bool> deleteFromCollection(CollectionReference collection, String docId) async{
    final TransactionHandler deleteTransaction = (Transaction tx) async{
      final DocumentSnapshot doc = await tx.get(collection.document(docId));

      await tx.delete(doc.reference);
      return {'result' : true};
    };

    return Firestore.instance.runTransaction(deleteTransaction).then((r) => r['result']).catchError((e){
      print("$TAG : ERROR: $e");
      return false;
    });
  }
}

class DeviceStore{
  final FirebaseUser user;
  String TAG = "Device Storage";

  DeviceStore.forUser({
    @required this.user
}) : assert(user != null);

  static DeviceItem fromDocument(DocumentSnapshot document) => _fromMap(document.data);

  static DeviceItem _fromMap(Map<String, dynamic> data) => new DeviceItem.fromMap(data);

  Map<String, dynamic> _toMap(DeviceItem item, [Map<String, dynamic> other]){
    final Map<String, dynamic> result = {};

    if(other != null){
      result.addAll(other);
    }
    result.addAll(item.toMap());

    return result;
  }

  Stream<QuerySnapshot> deviceList(){
    return GeneralStorage().generateListFromCollectionWithQuery(deviceCollection, 'userId', this.user.uid);
  }

  Future<DeviceItem> createDevice(String deviceId, String userId, DateTime lastSeen, String lastLocation) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot newDoc = await tx.get(deviceCollection.document());
      final DeviceItem newItem = new DeviceItem(
          id: newDoc.documentID,
          deviceId: deviceId,
          userId: userId,
          lastSeen: lastSeen.toUtc().toIso8601String(),
          lastLocation: lastLocation);
      final Map<String, dynamic> data = _toMap(newItem, {
        'created': new DateTime.now().toUtc().toIso8601String(),
      });
      await tx.set(newDoc.reference, data);

      return data;
    };

    return db.runTransaction(createTransaction)
        .then(_fromMap)
        .catchError((e){
      print('dart error: $e');
      return null;
    });
  }

  Future<bool> deleteDevice(String Id) async{
    return GeneralStorage().deleteFromCollection(deviceCollection, Id);
  }

  Future<bool> updateDevice(DeviceItem item) async{
    final TransactionHandler updateTransaction = (Transaction tx) async{
      final DocumentSnapshot doc = await tx.get(deviceCollection.document(item.id));

      await tx.update(doc.reference, _toMap(item));

      return {'result' : true};
    };

    return Firestore.instance.runTransaction(updateTransaction).then((r){
      return r['result'] = true;
    }).catchError((e){
      print('[$TAG : ERROR] $e');
      return false;
    });
  }

  Future<bool> deviceCheck(String deviceId) async{
    bool isInDB = false;

    final QuerySnapshot result = await db
        .collection('devices')
        .where('deviceId', isEqualTo: deviceId)
        .getDocuments();

    final List<DocumentSnapshot> docs = result.documents;

    if(docs.length == 0){
      isInDB = false;
    } else {
      isInDB = true;
    }

    return isInDB;
  }

  Future<DeviceItem> getDevice(String deviceId) async{
    final QuerySnapshot result = await db
        .collection('devices')
        .where('deviceId', isEqualTo: deviceId)
        .limit(1)
        .getDocuments();

    final List<DocumentSnapshot> docs = result.documents;

    return fromDocument(docs[0]);
  }
}

class UserStore{
  final FirebaseUser user;

  String TAG = 'USERSTORE';

  UserStore.forUser({
    @required this.user
}) : assert(user != null);

  static UserItem fromDocument(DocumentSnapshot document) => _fromMap(document.data);

  static UserItem _fromMap(Map<String, dynamic> data) => new UserItem.fromMap(data);

  Map<String, dynamic> _toMap(UserItem item, [Map<String, dynamic> other]){
    final Map<String, dynamic> result = {};

    if(other != null){
      result.addAll(other);
    }
    result.addAll(item.toMap());

    return result;
  }

  Stream<QuerySnapshot> userList(){
    return GeneralStorage().generateListFromCollectionWithQuery(userCollection, 'userId', this.user.uid);
  }

  Future<UserItem> createUser(String userId, String deviceId) async{
    final TransactionHandler createTransaction = (Transaction tx) async{
      final DocumentSnapshot newDoc = await tx.get(userCollection.document());
      final UserItem newUser = new UserItem(
        id: newDoc.documentID,
        userId: userId,
        deviceId: deviceId
      );
      final Map<String, dynamic> data = _toMap(newUser, {
        'created' : new DateTime.now().toUtc().toString()
      });
      await tx.set(newDoc.reference, data);

      return data;
    };

    return db.runTransaction(createTransaction)
        .then(_fromMap)
        .catchError((e){
      print('dart error: $e');
      return null;
    });
  }

  Future<bool> deleteUser(String Id) async{
    return GeneralStorage().deleteFromCollection(deviceCollection, Id);
  }

  Future<bool> updateUser(UserItem item) async{
    final TransactionHandler updateTransaction = (Transaction tx) async{
      final DocumentSnapshot doc = await tx.get(userCollection.document(item.id));

      await tx.update(doc.reference, _toMap(item));

      return {'result' : true};
    };

    return Firestore.instance.runTransaction(updateTransaction).then((r){
      return r['result'] = true;
    }).catchError((e){
      print('[$TAG : ERROR] $e');
      return false;
    });
  }

  Future<bool> userCheck(String userId) async{
    bool isInDB = false;

    final QuerySnapshot result = await db
        .collection('users')
        .where('userId', isEqualTo: userId)
        .getDocuments();

    final List<DocumentSnapshot> docs = result.documents;

    if(docs.length == 0){
      isInDB = false;
    } else {
      isInDB = true;
    }

    return isInDB;

  }
}

class ContactStore{
  final FirebaseUser user;

  String TAG = "CONTACTSTORE";

  ContactStore.forUser({
    @required this.user
}) : assert(user != null);

  static SkypeItem fromDocument(DocumentSnapshot document) => _fromMap(document.data);

  static SkypeItem _fromMap(Map<String, dynamic> data) => new SkypeItem.fromMap(data);

  Map<String, dynamic> _toMap(SkypeItem item, [Map<String, dynamic> other]){
    final Map<String, dynamic> result = {};

    if(other != null){
      result.addAll(other);
    }
    result.addAll(item.toMap());

    return result;
  }

  Stream<QuerySnapshot> skypeList(){
    return GeneralStorage().generateListFromCollectionWithQuery(skypeCollection, 'userId', this.user.uid);
  }

  Future<SkypeItem> createSkype(String skypeName, String skypeId, bool isSp, String spName) async{
    final TransactionHandler createTransaction = (Transaction tx) async{
      final DocumentSnapshot newDoc = await tx.get(skypeCollection.document());
      final SkypeItem newContact = new SkypeItem(
        id: newDoc.documentID,
        skypeName: skypeName,
        skypeId: skypeId,
        serviceProvider: isSp,
        serviceProviderName: spName,
      );
      final Map<String, dynamic> data = _toMap(newContact, {
        'userId' : this.user.uid,
        'created' : new DateTime.now().toUtc().toString()
      });
      await tx.set(newDoc.reference, data);

      return data;
    };

    return db.runTransaction(createTransaction)
        .then(_fromMap)
        .catchError((e){
      print('dart error: $e');
      return null;
    });
  }

  Future<bool> deleteContact(String Id) async{
    return GeneralStorage().deleteFromCollection(deviceCollection, Id);
  }

  Future<bool> updateContact(SkypeItem item) async{
    final TransactionHandler updateTransaction = (Transaction tx) async{
      final DocumentSnapshot doc = await tx.get(userCollection.document(item.id));

      await tx.update(doc.reference, _toMap(item));

      return {'result' : true};
    };

    return Firestore.instance.runTransaction(updateTransaction).then((r){
      return r['result'] = true;
    }).catchError((e){
      print('[$TAG : ERROR] $e');
      return false;
    });
  }
}

class GameStore{
  final FirebaseUser user;

  String TAG = "GAMESTORE";

  GameStore.forUser({
    @required this.user
}) : assert(user != null);

  static GameItem fromDocument(DocumentSnapshot document) => _fromMap(document.data);

  static GameItem _fromMap(Map<String, dynamic> data) => new GameItem.fromMap(data);

  Map<String, dynamic> _toMap(GameItem item, [Map<String, dynamic> other]){
    final Map<String, dynamic> result = {};

    if(other != null){
      result.addAll(other);
    }
    result.addAll(item.toMap());

    return result;
  }

  Future<QuerySnapshot> gamesList(){
    return GeneralStorage().generatelistFromCollection()
  }
}