import 'package:mvvm_flutter/data/remote/model/DataUser.dart';

import '../../utils/constant.dart';
import 'database_helper.dart';

class LocalDataSource {
  final DatabaseHelper _databaseHelper;

  LocalDataSource(this._databaseHelper);

  Future<String> insertFavoriteItem(Data data) async {
    try {
      Map<String, dynamic> mapList = data.toMap();
      await _databaseHelper.insertDataList(mapList, TableRes.menu);
      return 'Berhasil menyimpan favorite Item';
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Data>> getFavoriteItem() async {
    try {
      List<Map<String, dynamic>> result =
          await _databaseHelper.getDataList(TableRes.menu);
      return result.map((e) => Data.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> clearDataBase() async {
    try {
      await _databaseHelper.clearDatabase();
      return succesDeletAllDB;
    } catch (e) {
      rethrow;
    }
  }
}
