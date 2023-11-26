

/*
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../constants/app_assets.dart';

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

  void _createDatabase(Database _db, int version) async {
    await _db.execute('CREATE TABLE my_table ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'name TEXT,'
        'imagePath TEXT)');
  }

  Future<int> insertData(MyData data) async {
    Database? _db = await database;
    return await _db!.insert('my_table', data.toMap());
  }

  Future<List<MyData>> getDataList() async {
    Database? _db = await database;
    List<Map<String, dynamic>> maps = await _db!.query('my_table');
    return maps.map((map) => MyData.fromMap(map)).toList();
  }
}

class ImageStorage extends StatefulWidget {
  const ImageStorage({Key? key}) : super(key: key);

  @override
  _ImageStorageState createState() => _ImageStorageState();
}

class _ImageStorageState extends State<ImageStorage> {
  MyData? imageData;

  @override
  void initState() {
    super.initState();
    fetchDataImage();
  }

  Future<void> fetchDataImage() async {
    List<MyData> data = await DatabaseHelper().getDataList();
    if (data.isNotEmpty) {
      setState(() {
        imageData = data.first;
      });
    }
  }

  Future<void> saveImageFile(String imagePath) async {
    File imageFile = File(imagePath);

    MyData data = MyData(name: 'Image Name', imagePath: imagePath);
    await DatabaseHelper().insertData(data);

    fetchDataImage(); // Refresh the screen with the updated data
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (imageData?.imagePath != null)
          InkWell(
            onTap: () {
              _pickImage();
            },
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 125,
                height: 125,
                margin: const EdgeInsets.only(bottom: 35),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.file(
                    File(imageData!.imagePath!),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          )
        else
          InkWell(
            onTap: () {
              _pickImage();
            },
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 125,
                height: 125,
                margin: const EdgeInsets.only(bottom: 35),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    AppAssets.personDbURI,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );


    if (result != null) {
      String? imagePath = result.files.single.path;
      if (imagePath != null) {
        saveImageFile(imagePath);
      }
    }
  }
}
*/


/*
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../constants/app_assets.dart';

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

  void _createDatabase(Database _db, int version) async {
    await _db.execute('CREATE TABLE my_table ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'name TEXT,'
        'imagePath TEXT)');
  }

  Future<int> insertData(MyData data) async {
    Database? _db = await database;
    return await _db!.insert('my_table', data.toMap());
  }

  Future<List<MyData>> getDataList() async {
    Database? _db = await database;
    List<Map<String, dynamic>> maps = await _db!.query('my_table');
    return maps.map((map) => MyData.fromMap(map)).toList();
  }
}

class ImageStorage extends StatefulWidget {
  const ImageStorage({Key? key}) : super(key: key);

  @override
  _ImageStorageState createState() => _ImageStorageState();
}

class _ImageStorageState extends State<ImageStorage> {
  MyData? imageData;

  @override
  void initState() {
    super.initState();
    fetchDataImage();
  }

  Future<void> fetchDataImage() async {
    List<MyData> data = await DatabaseHelper().getDataList();
    if (data.isNotEmpty) {
      setState(() {
        imageData = data.first;
      });
    }
  }

  Future<void> saveImageFile(String imagePath) async {
    File imageFile = File(imagePath);

    MyData data = MyData(name: 'Image Name', imagePath: imagePath);
    await DatabaseHelper().insertData(data);

    fetchDataImage();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (imageData?.imagePath != null)
          InkWell(
            onTap: () {
              _pickImage();
            },
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 125,
                height: 125,
                margin: const EdgeInsets.only(bottom: 35),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.file(
                    File(imageData!.imagePath!),
                    fit: BoxFit.fill,
                  ),//1159
                ),
              ),
            ),
          )
        else
          InkWell(
            onTap: () {
              _pickImage();
            },
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 125,
                height: 125,
                margin: const EdgeInsets.only(bottom: 35),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    AppAssets.personDbURI,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      String? imagePath = result.files.single.path;
      if (imagePath != null) {
        saveImageFile(imagePath);
      }
    }
  }
}

*/


import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../constants/app_assets.dart';

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

class ImageStorage extends StatefulWidget {
  const ImageStorage({Key? key}) : super(key: key);

  @override
  _ImageStorageState createState() => _ImageStorageState();
}

class _ImageStorageState extends State<ImageStorage> {
  MyData? imageData;

  @override
  void initState() {
    super.initState();
    fetchDataImage();
  }

  Future<void> fetchDataImage() async {
    List<MyData> data = await DatabaseHelper().getDataList();
    if (data.isNotEmpty) {
      setState(() {
        imageData = data.first;
      });
    }
  }

  Future<void> saveImageFile(String imagePath) async {
    File imageFile = File(imagePath);

    MyData data = MyData(name: 'Image Name', imagePath: imagePath);
    await DatabaseHelper().insertData(data);

    setState(() {
      imageData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (imageData?.imagePath != null)
          InkWell(
            onTap: () {
              _pickImage();
            },
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 125,
                height: 125,
                margin: const EdgeInsets.only(bottom: 35),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.file(
                    File(imageData!.imagePath!),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          )
        else
          InkWell(
            onTap: () {
              _pickImage();
            },
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 125,
                height: 125,
                margin: const EdgeInsets.only(bottom: 35),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    AppAssets.personDbURI,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      String? imagePath = result.files.single.path;
      if (imagePath != null) {
        saveImageFile(imagePath);
      }
    }
  }
}
