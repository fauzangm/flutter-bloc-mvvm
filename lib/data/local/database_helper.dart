import 'package:mvvm_flutter/data/remote/model/DataUser.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as pathdart;

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
        onCreate: _onCreate, version: 2);
    return database;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(Data.createTableQuery());
  }

  Future<void> insertDataList(
      Map<String, dynamic> dataList, String tableName) async {
    final db = await database;
    db.transaction((txn) async {
      txn.insert(tableName, dataList,
          conflictAlgorithm: ConflictAlgorithm.replace);
      // for (Map<String, dynamic> data in dataList) {
      //   txn.insert(tableName, data);
      // }
    });
  }

  Future<void> clearDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = pathdart.join(dbPath, 'your_database.db');
    await deleteDatabase(path);
  }

  Future<List<Map<String, dynamic>>> getDataList(String tableName,
      {List<String>? columns, String? where, List<Object?>? whereArgs}) async {
    Database db = await database;
    return await db.query(
      tableName,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
    );
  }
}
