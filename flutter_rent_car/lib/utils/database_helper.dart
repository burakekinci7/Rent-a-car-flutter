import 'dart:async';

import 'package:flutter_rent_car/models/cars.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static const _dataBaseName = "carsdb.db";
  static const _dataBaseVersion = 1;
  static const table = "cars_table";
  static const columnlisance = "licence";
  static const columnModel = "licence";
  static const columnstatus = "status";
  static const columnhp = "hp";
  static const columngear = "gear";
  static const columnpeopleNum = "peopleNum";
  static const columnpricing = "pricing";

  DataBaseHelper._privateConstructor();
  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();
  static Database? _database;

  //database tablosu varsa kullanmak, yoksa oluşturmak icin kullanilir
  //if there is use to a database, create for database table
  Future<Database?> get dataBaseFuture async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDatabase();
    return null;
  }

  //bir database olusturmak icin kullanılan func
  //func used to created a database
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _dataBaseName);
    return await openDatabase(path,
        version: _dataBaseVersion, onCreate: _onCreate);
  }

  //database işlemleri "async" olmalıdır
  //database operations are async
  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $table (
      $columnlisance TEXT PRIMARY KEY,
      $columnModel TEXT NOT NULL,
      $columnstatus BOOLEAN NOT NULL,
      $columnhp INTEGER NOT NULL,
      $columngear BOOLEAN NOT NULL,
      $columnpeopleNum INTEGER NOT NULL,
      $columnpricing INTEGER NOT NULL
    )
    ''');
  }

  //database tabloların kayıt yapmak için kullanılır
  Future insert(Cars cars) async {
    Database? db = await instance.dataBaseFuture;
    if (db != null) {
      return await db.insert(table, {
        "licence": cars.licence,
        "model": cars.model,
        "status": cars.status,
        "gear": cars.gear,
        "hp": cars.hp,
        "peopleNum": cars.peopleNum,
        "pricing": cars.pricing,
      });
    }
  }

  //tabloyu döndermek için kullanıcaz
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.dataBaseFuture;
    if (db != null) {
      return await db.query(table);
    }
    return [];
  }
}
