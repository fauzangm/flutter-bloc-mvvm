import 'package:mvvm_flutter/data/remote/model/DataUser.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database> get database async => _database ??= await initializeDb();

  Future<Database> initializeDb() async {
    String path = await getDatabasesPath();
    Database database = await openDatabase('$path/favorite.db',
        onCreate: _onCreate, version: 1);
    return database;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(Data.createTableQuery());
  }

  Future<void> insertDataList(
      List<Map<String, dynamic>> dataList, String tableName) async {
    final db = await database;
    db.transaction((txn) async {
      for (Map<String, dynamic> data in dataList) {
        txn.insert(tableName, data);
      }
    });
  }
}
