

// class LocalDataSource {
//   final DatabaseHelper _databaseHelper;

//   LocalDataSource(this._databaseHelper);


//   Future<String> insertMenuList(List<MenuResponse> menus) async {
//     try {
//       List<Map<String, dynamic>> mapList = menus.map(
//               (data) => data.toMap()
//       ).toList();
//       await _databaseHelper.insertDataList(mapList, TableRes.menu);
//       return 'Insert all menu succeeded';
//     } catch (e) {
//       rethrow;
//     }
//   }

// }