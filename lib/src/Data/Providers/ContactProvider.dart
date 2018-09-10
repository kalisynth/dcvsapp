part of dcvsapp;

class ContactProvider{
  Database db;

  Future open(String path) async{
    db = await openDatabase(path, version: 1,
    onCreate: (Database db, int version) async {
      await db.execute('''
          create table $tableContact(
            $columnId integer primary key autoincrement,
            $columnName text not null
            $columnSkypeName text not null)
          ''');
    });
  }

  Future<Contact> insertContact(Contact contact) async{
    contact.id = await db.insert(tableContact, contact.toMap());
    return contact;
  }

  Future<Contact> getContact(int id)async{
    List<Map> maps = await db.query(tableContact,
    columns: [columnId, columnName, columnSkypeName],
    where: "$columnId = ?",
    whereArgs: [id]);
    if(maps.length > 0){
      return new Contact.fromMap(maps.first);
    }
    return null;
  }

  Future<int> deleteContact(int id) async{
    return await db.delete(tableContact, where:"columnId = ?", whereArgs: [id]);
  }

  Future<int> updateContact(Contact contact) async{
    return await db.update(tableContact, contact.toMap(),
    where: "columnId = ?", whereArgs: [contact.id]);
  }

  Future close() async => db.close();
}