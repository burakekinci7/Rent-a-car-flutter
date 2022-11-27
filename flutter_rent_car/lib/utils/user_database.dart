import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/user.dart';

class UserdataBase {
  static const _databaseName = "userdb.db";
  static const _databaseVersion = 1;
  static const table = "user_table";
  static const nameColumn = "name";
  static const surNameColumn = "surname";
  static const phoneNumberColumn = "phoneNumber";

  //Constructor - nesne olusturucu
  UserdataBase._privateConstructorUser();
  static final UserdataBase instanceUser =
      UserdataBase._privateConstructorUser();
  static Database? _database;

  Future<Database?> get userdataBaseGet async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDatabase();
    return null;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $table (
      $nameColumn TEXT,
      $surNameColumn TEXT,
      $phoneNumberColumn INTEGER
    )
    ''');
  }

  Future insterUser(User user) async {
    Database? database = await instanceUser.userdataBaseGet;
    if (database != null) {
      return await database.insert(table, {
        "name": nameColumn,
        "surname": surNameColumn,
        "phoneNumber": phoneNumberColumn,
      });
    }
  }
}
