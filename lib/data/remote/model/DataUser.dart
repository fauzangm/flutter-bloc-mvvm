import '../../../utils/constant.dart';

class Data {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  Data({this.id, this.email, this.firstName, this.lastName, this.avatar});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json[FieldRes.firstName];
    lastName = json[FieldRes.lastName];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data[FieldRes.firstName] = this.firstName;
    data[FieldRes.lastName] = this.lastName;
    data['avatar'] = this.avatar;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      FieldRes.firstName: firstName,
      FieldRes.lastName: lastName,
      'avatar': avatar,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) => Data(
        id: map[FieldRes.id],
        email: map[FieldRes.email],
        firstName: map[FieldRes.firstName],
        lastName: map[FieldRes.lastName],
        avatar: map[FieldRes.avatar],
      );

  static String createTableQuery() => '''CREATE TABLE ${TableRes.menu} (
      ${FieldRes.id} TEXT PRIMARY KEY,
      ${FieldRes.avatar} TEXT,
       ${FieldRes.email} TEXT,
      ${FieldRes.firstName} TEXT,
      ${FieldRes.lastName} TEXT
      )
      ''';

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
