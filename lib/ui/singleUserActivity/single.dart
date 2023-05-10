import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_flutter/bloc/GetSingleUser/SingleUserBloc.dart';
import 'package:mvvm_flutter/model/SingleUser.dart';

import '../../utils/componentUi/card_view.dart';

class SinglePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Random random = Random();
    SingleUserBloc userViewModel = BlocProvider.of<SingleUserBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("MVVM with BLOC"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.supervised_user_circle_rounded),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                userViewModel
                    .add(GetSingleUserEvent(idUser: random.nextInt(10) + 1));
              },
              child: Text("Pick Random User"),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              )),
          BlocBuilder<SingleUserBloc, SingleUserState>(
              builder: (context, state) {
            if (state is SingleUserLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is SingleUserSucces) {
              return UserCard(state.user);
            }
            return Container();
          }),
        ],
      ),
    );
  }
}
