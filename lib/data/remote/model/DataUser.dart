import 'dart:math';

import 'package:equatable/equatable.dart';

import '../../../utils/constant.dart';

class Data extends Equatable {
  int? id;
  String? email;
  String? first_name;
  String? lastName;
  String? avatar;
  bool isFavorite = false;

  Data({this.id = 0, this.email, this.first_name, this.lastName, this.avatar});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    first_name = json[FieldRes.firstName];
    lastName = json[FieldRes.lastName];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data[FieldRes.firstName] = this.first_name;
    data[FieldRes.lastName] = this.lastName;
    data['avatar'] = this.avatar;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      FieldRes.firstName: first_name,
      FieldRes.lastName: lastName,
      'avatar': avatar,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) => Data(
        // id: map[FieldRes.id] ?? Random().nextInt(10),
        email: map[FieldRes.email],
        first_name: map[FieldRes.firstName],
        lastName: map[FieldRes.lastName],
        avatar: map[FieldRes.avatar],
      );

  static String createTableQuery() => '''CREATE TABLE ${TableRes.menu} (
      ${FieldRes.id} INTEGER PRIMARY KEY,
      ${FieldRes.avatar} TEXT,
       ${FieldRes.email} TEXT,
      ${FieldRes.firstName} TEXT,
      ${FieldRes.lastName} TEXT
      )
      ''';

  @override
  // TODO: implement props
  List<Object?> get props => [id, avatar, email, first_name, lastName];
  //         @override
  // List<Object?> get props => [
  //   amount, id, image, name, note, price, storeId, totalPrice, unit
  // ];

//       final String createTableQuery = '''
//   CREATE TABLE favorite (
//     id TEXT PRIMARY KEY,
//     avatar TEXT,
//     email TEXT,
//     firstName TEXT,
//     lastName TEXT
//   )
// ''';
}
