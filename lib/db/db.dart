import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'model.dart';

class DatabaseService {
  static DatabaseService instance = DatabaseService._();

  DatabaseService._();

  static Database _db;

  Future<Database> get db async {
    _db ??= await _openDb();
    return _db;
  }

  Future<Database> _openDb() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = dir.path + '/contacts_list.db';
    final contactListDb = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $contactsTable (
            ${ContactFields.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${ContactFields.colFirstName} TEXT ,
            ${ContactFields.colLastName} TEXT,
            ${ContactFields.colPhone} TEXT,
            ${ContactFields.colEmail} TEXT,
            ${ContactFields.colAddress} TEXT,
            ${ContactFields.colGender} TEXT,
            ${ContactFields.colImage} TEXT,
            ${ContactFields.colSelected} BOOLEAN
          )
        ''');
      },
    );
    return contactListDb;
  }

  Future<Contact> insert(Contact contact) async {
    final db = await this.db;
    final id = await db.insert(contactsTable, contact.toMap());
    final contactsWithId = contact.copyWith(id: id);
    return contactsWithId;
  }

  Future<List<Contact>> getAllContacts() async {
    final db = await this.db;
    final orderBy = '${ContactFields.colFirstName} ASC';
    final contactsData = await db.query(contactsTable, orderBy: orderBy);
    return contactsData.map((e) => Contact.fromMap(e)).toList();
  }

  Future<int> update(Contact contact) async {
    final db = await this.db;
    return await db.update(
      contactsTable,
      contact.toMap(),
      where: '${ContactFields.colId} = ?',
      whereArgs: [contact.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await this.db;
    return await db.delete(
      contactsTable,
      where: '${ContactFields.colId} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.db;
    db.close();
  }
}
