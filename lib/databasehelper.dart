import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'contact.dart';

class DatabaseHelper {
  static final _databaseName = "contatos.db";
  static final _databaseVersion = 1;
  static final _table = 'contatos';

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnPhone = 'phone';
  static final columnEmail = 'email';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _databaseName);

    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnName TEXT,
        $columnPhone TEXT,
        $columnEmail TEXT
      )
      ''');
  }

  Future<int> insertContact(Contact contact) async {
    Database db = await instance.database;
    var result = await db.insert(_table, contact.toMap());
    return result;
  }

  Future<List<Contact>> getContacts() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(_table);

    return List.generate(maps.length, (i) {
      return Contact(
        id: maps[i][columnId],
        name: maps[i][columnName],
        phone: maps[i][columnPhone],
        email: maps[i][columnEmail],
      );
    });
  }

  Future<Contact> getContact(int id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps =
      await db.query(_table, where: '$columnId = ?', whereArgs: [id]);

    return Contact.fromMap(maps.first);
  }

  Future<int> updateContact(Contact contact) async {
    Database db = await instance.database;
    return await db.update(_table, contact.toMap(), where: '$columnId = ?', whereArgs: [contact.id]);
  }

  Future<int> deleteContact(int id) async {
    Database db = await instance.database;
    return await db.delete(_table, where: '$columnId = ?', whereArgs: [id]);
  }
}