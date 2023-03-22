import 'dart:io';
import 'package:database_crud/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDatabase{
  Future<Database> initDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'log.db');
    return await openDatabase(
      databasePath,
      version: 2,
    );
  }

  Future<void> copyPasteAssetFileToRoot() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "log.db");

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data =
      await rootBundle.load(join('assets/database', 'log.db'));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
    }
  }

  Future<List<Map<String,Object?>>> getDataFromUserTable() async{
    Database db = await initDatabase();
    List<Map<String,Object?>> data = await db.rawQuery('select * from Mst_User');
    print("user list length is ${data.length}");
    return data;
  }

  Future<void> deleteUser(int id) async {
    // Get a reference to the database.
    Database db = await initDatabase();

    // Remove the Dog from the database.
    await db.delete(
      'Mst_User',
      where: 'UserId = $id',
    );
    print('deleted user');
  }

  // Define a function that inserts dogs into the database
  Future<void> insertUser(User user) async {
    // Get a reference to the database.
    final db = await initDatabase();

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'Mst_User',
      user.toMap(),
      // conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateUser(User user,int id) async {
    // Get a reference to the database.
    final db = await initDatabase();

    // Update the given Dog.
    await db.update(
      'Mst_User',
      user.toMap(),
      where: 'UserId = $id',
    );
  }
}