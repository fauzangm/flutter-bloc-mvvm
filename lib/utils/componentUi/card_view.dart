import 'package:flutter/material.dart';

import '../../data/model/DataUser.dart';
import '../../data/response/SingleUser.dart';

class UserCard extends StatelessWidget {
  final Data user;

  UserCard(this.user);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color(0x55000000), offset: Offset(1, 1), blurRadius: 7)
          ],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.purple)),
      child: Row(
        children: [
          Container(
            height: 75,
            width: 75,
            margin: EdgeInsets.only(right: 10),
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
