import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteDataBase {
  static Database? _db;

  Future<Database?> get db async {
    /* if (_db == null) {*/
    _db = await initialDb();
    return _db;
    /* } else {
      return _db;
    }*/
  }

  initialDb() async {
    String path = join(await getDatabasesPath(), 'tasks.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('================database has been upgrade==================');
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE "tasks" (
      "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "fullName" TEXT NOT NULL,
      "emailAddress" TEXT NOT NULL,
      "phoneNumber" INTEGER NOT NULL 
    )
  ''');
    print('================database has been create==================');
  }




  /*_onCreate(Database db, int version) async {

    Batch batch =db.batch();

    batch.execute('''
    CREATE TABLE "tasks" (
      "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "fullName" TEXT NOT NULL,
      "emailAddress" TEXT NOT NULL,
      "phoneNumber" INTEGER NOT NULL
    )
  ''');
    await batch.commit();
    print('================database has been create==================');
  }*/



  readDatabase(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    print('================database has been read==================');
    return response;
  }

  insertDatabase(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    print('================database has been insert==================');
    return response;
  }

  updateDatabase(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    print('================database has been update==================');
    return response;
  }

  deleteMyDatabase(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    print('================database has been delete==================');
    return response;
  }

  deleteAllDatabase() async {
    print('================database has been all deleted==================');
    String path = join(await getDatabasesPath(), 'tasks.db');
    await deleteDatabase(path);
  }

  closeDatabase() async {
    print('================database has been closed==================');
    await _db!.close();
  }
}

class MyData {
  int? id;
  String? name;
  String? imagePath;

  MyData({this.id, this.name, this.imagePath});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imagePath': imagePath,
    };
  }

  factory MyData.fromMap(Map<String, dynamic> map) {
    return MyData(
      id: map['id'],
      name: map['name'],
      imagePath: map['imagePath'],
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/my_database.db';
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  void _createDatabase(Database db, int version) async {
    await db.execute('CREATE TABLE my_table ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'name TEXT,'
        'imagePath TEXT)');
  }

  Future<int> insertData(MyData data) async {
    Database? db = await database;
    return await db!.insert('my_table', data.toMap());
  }

  Future<List<MyData>> getDataList() async {
    Database? db = await database;
    List<Map<String, dynamic>> maps = await db!.query('my_table');
    return maps.map((map) => MyData.fromMap(map)).toList();
  }
}