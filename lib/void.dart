// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
//
// class MyData {
//   int? id;
//   String? name;
//   String? imagePath;
//
//   MyData({this.id, this.name, this.imagePath});
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'imagePath': imagePath,
//     };
//   }
//
//   factory MyData.fromMap(Map<String, dynamic> map) {
//     return MyData(
//       id: map['id'],
//       name: map['name'],
//       imagePath: map['imagePath'],
//     );
//   }
// }
//
// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper._();
//   static Database? _database;
//
//   DatabaseHelper._();
//
//   factory DatabaseHelper() {
//     return _instance;
//   }
//
//   Future<Database?> get database async {
//     if (_database != null) {
//       return _database;
//     }
//     _database = await initializeDatabase();
//     return _database;
//   }
//
//   Future<Database> initializeDatabase() async {
//     Directory directory = await getApplicationDocumentsDirectory();
//     String path = directory.path + '/my_database.db';
//     return await openDatabase(path, version: 1, onCreate: _createDatabase);
//   }
//
//   void _createDatabase(Database db, int version) async {
//     await db.execute('CREATE TABLE my_table ('
//         'id INTEGER PRIMARY KEY AUTOINCREMENT,'
//         'name TEXT,'
//         'imagePath TEXT)');
//   }
//
//   Future<int> insertData(MyData data) async {
//     Database? db = await database;
//     return await db!.insert('my_table', data.toMap());
//   }
//
//   Future<List<MyData>> getDataList() async {
//     Database? db = await database;
//     List<Map<String, dynamic>> maps = await db!.query('my_table');
//     return maps.map((map) => MyData.fromMap(map)).toList();
//   }
// }
//
// class ImageStorageScreen extends StatefulWidget {
//   @override
//   _ImageStorageScreenState createState() => _ImageStorageScreenState();
// }
//
// class _ImageStorageScreenState extends State<ImageStorageScreen> {
//   List<MyData> dataList = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }
//
//   Future<void> fetchData() async {
//     List<MyData> data = await DatabaseHelper().getDataList();
//     setState(() {
//       dataList = data;
//     });
//   }
//
//   Future<void> saveImageFile(String imagePath) async {
//     File imageFile = File(imagePath);
//
//     MyData data = MyData(name: 'Image Name', imagePath: imagePath);
//     await DatabaseHelper().insertData(data);
//
//     fetchData(); // Refresh the screen with the updated data
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Storage'),
//       ),
//       body: ListView.builder(
//         itemCount: dataList.length,
//         itemBuilder: (context, index) {
//           MyData data = dataList[index];
//           return ListTile(
//             title: Text(data.name!),
//             leading: Image.file(File(data.imagePath!)),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _pickImage();
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
//
//   Future<void> _pickImage() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//     );
//
//     if (result != null) {
//       String? imagePath = result.files.single.path;
//       if (imagePath != null) {
//         saveImageFile(imagePath);
//       }
//     }
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     home: ImageStorageScreen(),
//   ));
// }