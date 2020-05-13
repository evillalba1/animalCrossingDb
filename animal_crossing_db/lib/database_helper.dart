import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'object_class.dart';

class DatabaseHelper {
  static final _fishTbl = new FishTbl();
  static final _insectTbl = new InsectTbl();
  static final _fossilTbl = new FossilTbl();
  static final _villagerTbl = new VillagerTbl();

  static final _dbName = 'animalCrossing.db';
  static final _dbVersion = 1;
  static final idColumn = 'number';

  //Create singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initiateDatabase();
    return _database;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) {
    db.execute(''' 
       
        CREATE TABLE ${_fishTbl.table} (
      ${_fishTbl.number} INTEGER PRIMARY KEY,
      ${_fishTbl.name} TEXT NOT NULL,
      ${_fishTbl.location} TEXT NOT NULL,
      ${_fishTbl.shadowSize} TEXT NOT NULL,
      ${_fishTbl.value} TEXT NOT NULL,
      ${_fishTbl.time} TEXT NOT NULL,
      ${_fishTbl.month} TEXT NOT NULL,
      ${_fishTbl.donated} INTEGER NOT NULL,
      ${_fishTbl.quantity} INTEGER NOT NULL,
       )
       
      CREATE TABLE ${_insectTbl.table} (
      ${_insectTbl.number} INTEGER PRIMARY KEY,
      ${_insectTbl.name} TEXT NOT NULL,
      ${_insectTbl.location} TEXT NOT NULL,
      ${_insectTbl.value} TEXT NOT NULL,
      ${_insectTbl.time} TEXT NOT NULL,
      ${_insectTbl.month} TEXT NOT NULL,
      ${_insectTbl.donated} INTEGER NOT NULL,
      ${_insectTbl.quantity} INTEGER NOT NULL,
       )
       
       CREATE TABLE ${_fossilTbl.table} (
       number INTEGER AUTOINCREMENT PRIMARY KEY,
      ${_fossilTbl.name} TEXT NOT NULL,
      ${_fossilTbl.price} TEXT NOT NULL,
      ${_fossilTbl.donated} INTEGER NOT NULL,
      ${_fossilTbl.quantity} INTEGER NOT NULL,
       )
       
       CREATE TABLE ${_villagerTbl.table} (
      ${_villagerTbl.number} INTEGER AUTOINCREMENT PRIMARY KEY,
      ${_villagerTbl.name} TEXT NOT NULL,
      ${_villagerTbl.personality} TEXT NOT NULL,
      ${_villagerTbl.species} TEXT NOT NULL,
      ${_villagerTbl.birthday} TEXT NOT NULL,
      ${_villagerTbl.cathphrase} TEXT NOT NULL,
      ${_villagerTbl.imageUrl} TEXT NOT NULL,
      ${_villagerTbl.resident} INTEGER NOT NULL,
       )
       
      ''');
  }

  Future<int> insert(Map<String, dynamic> row, String tableName) async {
    Database db = await instance.database;
    return await db.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll(String tableName) async {
    Database db = await instance.database;
    return await db.query(tableName);
  }

  Future<int> update(Map<String, dynamic> row, String tableName) async {
    Database db = await instance.database;
    int id = row[idColumn];
    return await db
        .update(tableName, row, where: '$idColumn = ?', whereArgs: [id]);
  }

  Future<int> delete(int id, String tableName) async {
    Database db = await instance.database;
    return await db.delete(tableName, where: '$idColumn = ?', whereArgs: [id]);
  }
}
