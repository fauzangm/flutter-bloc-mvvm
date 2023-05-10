import 'package:flutter/material.dart';

import '../../model/SingleUser.dart';

class UserCard extends StatelessWidget {
  final SingleUser user;

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
                image: DecorationImage(
                    image: NetworkImage("${user.data?.avatar}"))),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("ID : ${user.data?.id}"),
              Text("Nama : ${user.data?.firstName} ${user.data?.lastName}"),
              Text("ID : ${user.data?.email}"),
            ],
          )
        ],
      ),
    );
  }
}
