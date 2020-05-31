import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'object_class.dart';
import 'package:flutter/foundation.dart';

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

  Future _onCreate(Database db, int version) async {
    debugPrint("Creating DB");
    await db.execute(''' 
      
        CREATE TABLE ${_fishTbl.table} (
      ${_fishTbl.number} INTEGER PRIMARY KEY,
      ${_fishTbl.name} TEXT NOT NULL,
      ${_fishTbl.location} TEXT NOT NULL,
      ${_fishTbl.shadowSize} TEXT NOT NULL,
      ${_fishTbl.value} TEXT NOT NULL,
      ${_fishTbl.time} TEXT NOT NULL,
      ${_fishTbl.month} TEXT NOT NULL,
      ${_fishTbl.donated} INTEGER NOT NULL,
      ${_fishTbl.quantity} INTEGER NOT NULL
      ) 
      ''');

    await db.execute(''' 
      
      CREATE TABLE ${_insectTbl.table} (
      ${_insectTbl.number} INTEGER PRIMARY KEY,
      ${_insectTbl.name} TEXT NOT NULL,
      ${_insectTbl.location} TEXT NOT NULL,
      ${_insectTbl.value} TEXT NOT NULL,
      ${_insectTbl.time} TEXT NOT NULL,
      ${_insectTbl.month} TEXT NOT NULL,
      ${_insectTbl.donated} INTEGER NOT NULL,
      ${_insectTbl.quantity} INTEGER NOT NULL
      )
      ''');

    await db.execute(''' 
      
      CREATE TABLE ${_fossilTbl.table} (
      number INTEGER PRIMARY KEY AUTOINCREMENT ,
      ${_fossilTbl.name} TEXT NOT NULL,
      ${_fossilTbl.price} TEXT NOT NULL,
      ${_fossilTbl.donated} INTEGER NOT NULL,
      ${_fossilTbl.quantity} INTEGER NOT NULL
      )
      ''');

    await db.execute(''' 
      CREATE TABLE ${_villagerTbl.table} (
      ${_villagerTbl.number} INTEGER PRIMARY KEY AUTOINCREMENT ,
      ${_villagerTbl.name} TEXT NOT NULL,
      ${_villagerTbl.personality} TEXT NOT NULL,
      ${_villagerTbl.species} TEXT NOT NULL,
      ${_villagerTbl.birthday} TEXT NOT NULL,
      ${_villagerTbl.catchphrase} TEXT NOT NULL,
      ${_villagerTbl.imageUrl} TEXT NOT NULL,
      ${_villagerTbl.resident} INTEGER NOT NULL
      )
      ''');
  }


  Future<void> insertAllFossil() async {
    debugPrint("insertAllFossil");
    final Database db = await instance.database;
    Batch batch = db.batch();
    String fossilsJson = await rootBundle.loadString('assets/fossils.json');
    List fossilsList = json.decode(fossilsJson);
      fossilsList.forEach((val) {
        Fossil fossil = new Fossil();
        fossil.name = val["name"];
        fossil.price = val ["price"];
        fossil.donated = val["donated"];
        fossil.quantity = val["quantity"];
        batch.insert(_fossilTbl.table, fossil.toMap());
      });
      batch.commit();
  }

  Future<void> insertAllVillagers() async {
    debugPrint("insertAllVillagers");
    final Database db = await instance.database;
    String villalgersJson = await rootBundle.loadString('assets/villagers.json');
    List villagersList = json.decode(villalgersJson);
      villagersList.forEach((val) async {
        Villager villager = new Villager();
        villager.name = val["name"];
        villager.personality = val ["personality"];
        villager.species = val["species"];
        villager.birthday = val["birthday"];
        villager.catchphrase = val["catchphrase"];
        villager.imageUrl = val["imageUrl"];
        villager.resident = val["resident"];
        await db.insert(_villagerTbl.table, villager.toMap(), conflictAlgorithm: ConflictAlgorithm.replace,);
      });

  }

  Future<void> insertAllFishes() async {
    debugPrint("insertAllFishes");
    final Database db = await instance.database;
    Batch batch = db.batch();
    String fishesJson = await rootBundle.loadString('assets/fish.json');
    List fishesList = json.decode(fishesJson);
      fishesList.forEach((val) {
        Fish fish = new Fish();
        fish.number = val["number"];
        fish.name = val["name"];
        fish.location = val ["location"];
        fish.shadowSize = val["shadowSize"];
        fish.value = val["value"];
        fish.time = val["time"];
        fish.month = val["month"];
        fish.donated = val["donated"];
        fish.quantity = val["quantity"];
        batch.insert(_fishTbl.table, fish.toMap());
      });
      batch.commit();
  }

  Future<void> insertAllInsects() async {
    debugPrint("insertAllInsects");
    final Database db = await instance.database;
    Batch batch = db.batch();
    String insectsJson = await rootBundle.loadString('assets/insects.json');
    List insectsList = json.decode(insectsJson);
      insectsList.forEach((val) {
        Insect insect = new Insect();
        insect.number = val["number"];
        insect.name = val["name"];
        insect.location = val ["location"];
        insect.value = val["value"];
        insect.time = val["time"];
        insect.month = val["month"];
        insect.donated = val["donated"];
        insect.quantity = val["quantity"];
        batch.insert(_insectTbl.table, insect.toMap());
      });
      batch.commit();
  }

  Future<void> createDB() async {
    Database db = await instance.database;
  }

  Future<int> insert(Map<String, dynamic> row, String tableName) async {
    Database db = await instance.database;
    return await db.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll(String tableName) async {
    Database db = await instance.database;
    return await db.query(tableName);
  }

  //-------------------------Fossil-------------------------------
  Future<int> updateDonatedFossil(int index, String donated) async {
    Database db = await instance.database;
    int updateCount = await db.rawUpdate('''
    UPDATE ${ _fossilTbl.table} 
    SET ${ _fossilTbl.donated} = ?
    WHERE ${ _fossilTbl.number} = ?
    ''',
        [donated, index.toString()]);
    return updateCount;
  }

  Future<int> updateQuantityFossil(int index, int quantity) async {
    Database db = await instance.database;
    int updateCount = await db.rawUpdate('''
    UPDATE ${ _fossilTbl.table} 
    SET ${ _fossilTbl.quantity} = ?
    WHERE ${ _fossilTbl.number} = ?
    ''',
        [quantity.toString(), index.toString()]);
    return updateCount;
  }
  //-------------------------------------------------------------

  //-------------------------Insect-------------------------------
  Future<int> updateDonatedInsect(int index, String donated) async {
    Database db = await instance.database;
    int updateCount = await db.rawUpdate('''
    UPDATE ${ _insectTbl.table} 
    SET ${ _insectTbl.donated} = ?
    WHERE ${ _insectTbl.number} = ?
    ''',
        [donated, index.toString()]);
    return updateCount;
  }

  Future<int> updateQuantityInsect(int index, int quantity) async {
    Database db = await instance.database;
    int updateCount = await db.rawUpdate('''
    UPDATE ${ _insectTbl.table} 
    SET ${ _insectTbl.quantity} = ?
    WHERE ${ _insectTbl.number} = ?
    ''',
        [quantity.toString(), index.toString()]);
    return updateCount;
  }
  //-------------------------------------------------------------

  //-------------------------Fish-------------------------------
  Future<int> updateDonatedFish(int index, String donated) async {
    Database db = await instance.database;
    int updateCount = await db.rawUpdate('''
    UPDATE ${ _fishTbl.table} 
    SET ${ _fishTbl.donated} = ?
    WHERE ${ _fishTbl.number} = ?
    ''',
        [donated, index.toString()]);
    return updateCount;
  }

  Future<int> updateQuantityFish(int index, int quantity) async {
    Database db = await instance.database;
    int updateCount = await db.rawUpdate('''
    UPDATE ${ _fishTbl.table} 
    SET ${ _fishTbl.quantity} = ?
    WHERE ${ _fishTbl.number} = ?
    ''',
        [quantity.toString(), index.toString()]);
    return updateCount;
  }
  //-------------------------------------------------------------

  //-------------------------Villager-------------------------------
  Future<int> updateResidentVillager(int index, String resident) async {
    Database db = await instance.database;
    int updateCount = await db.rawUpdate('''
    UPDATE ${ _villagerTbl.table} 
    SET ${ _villagerTbl.resident} = ?
    WHERE ${ _villagerTbl.number} = ?
    ''',
        [resident, index.toString()]);
    return updateCount;
  }
  //-------------------------------------------------------------

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
