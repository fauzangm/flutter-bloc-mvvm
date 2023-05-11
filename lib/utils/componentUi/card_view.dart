import 'package:flutter/material.dart';
import 'package:mvvm_flutter/common/color.dart';

import '../../data/remote/model/DataUser.dart';
import '../../data/remote/response/SingleUser.dart';

class UserCard extends StatelessWidget {
  final Data user;

  UserCard(this.user);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: colorPrimaryDark, offset: Offset(1, 1), blurRadius: 7)
          ],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: colorPrimaryLight)),
      child: Row(
        children: [
          Container(
            height: 75,
            width: 75,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(image: NetworkImage("${user.avatar}"))),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("ID : ${user.id}"),
              Text("Nama : ${user.firstName} ${user.lastName}"),
              Text("ID : ${user.email}"),
            ],
          )
        ],
      ),
    );
  }
}
