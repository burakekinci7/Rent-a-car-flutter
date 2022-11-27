import 'dart:async';

import 'package:flutter_rent_car/models/cars.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static const _dataBaseName = "carsimagedb.db";
  static const _dataBaseVersion = 1;
  static const table = "cars_table";
  static const columnlisance = "licence";
  static const columnModel = "model";
  static const columnstatus = "status";
  static const columnhp = "hp";
  static const columngear = "gear";
  static const columnpeopleNum = "peopleNum";
  static const columnpricing = "pricing";
  static const columnPath = "path";

  //Constructor - nesne olusturucu
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
      $columnstatus BOOLEAN,
      $columnhp INTEGER NOT NULL,
      $columngear BOOLEAN,
      $columnpeopleNum INTEGER NOT NULL,
      $columnpricing INTEGER NOT NULL,
      $columnPath TEXT
    )
    ''');
  }

  //database tabloların kayıt yapmak için kullanılır -
  Future insert(Cars cars) async {
    Database? db = await instance.dataBaseFuture;
    if (db != null) {
      return await db.insert(
        table,
        {
          "licence": cars.licence,
          "model": cars.model,
          "status": cars.status,
          "hp": cars.hp,
          "gear": cars.gear,
          "peopleNum": cars.peopleNum,
          "pricing": cars.pricing,
          "path": cars.path,
        },
        //plakalar arbaya özel olduğu için aynı plakadan sadecebir tane olabilir
        //alttaki komut ise aynı plakadan araba çağrırırsa update yapar
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  //tabloyu döndermek için kullanıcaz - tüm listedi elemanlar
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.dataBaseFuture;
    if (db != null) {
      return await db.query(table);
    }
    return [];
  }

  //plakası verilen bir aracın silinmesi - elemet delete in list
  Future delete(String licance) async {
    Database? db = await instance.dataBaseFuture;
    if (db != null) {
      return db
          .delete(table, where: "$columnlisance = ?", whereArgs: [licance]);
    } else {
      return "";
    }
  }

  Future update(Cars cars) async {
    Database? db = await instance.dataBaseFuture;
    String licanceUpdate = cars.toJMap()["licence"];
    if (db != null) {
      return await db.update(
        table,
        cars.toJMap(),
        where: "$columnlisance = ?",
        whereArgs: [licanceUpdate],
      );
    }
  }
}
