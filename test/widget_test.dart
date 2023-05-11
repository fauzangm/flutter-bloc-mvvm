// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm_flutter/data/remote/response/MultiUser.dart';
import 'package:mvvm_flutter/data/remote/response/SingleUser.dart';
import 'dart:convert';
import 'package:mvvm_flutter/main.dart';

void main() async {
  /** Get MULTI USER  */
  Future<MultiUser> getMultiUserFromApi(int id) async {
    Uri apiURL = Uri.parse("https://reqres.in/api/users?page=" + id.toString());
    var apiResult = await http.get(apiURL);
    Map<String, dynamic> jsonObject = json.decode(apiResult.body);
    var fakeData = MultiUser.fromJson(jsonObject);
    print('${fakeData.data?[0].firstName}');
    return fakeData;
  }

  await getMultiUserFromApi(2);

/** Get SINGLE USER */
  // Future<SingleUser> getSingleUserFromApi(int id) async {
  //   Uri apiURL = Uri.parse("https://reqres.in/api/users/" + id.toString());

  //   var apiResult = await http.get(apiURL);
  //   var jsonObject = json.decode(apiResult.body);
  //   Map<String, dynamic> data =
  //       (json.decode(apiResult.body) as Map<String, dynamic>);

  //   var fakeData = SingleUser.fromJson(data);
  //   print('${fakeData.data?.lastName}');
  //   return SingleUser.fromJson(data);
  // }

  // await getSingleUserFromApi(1);
}
