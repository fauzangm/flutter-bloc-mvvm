import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_flutter/bloc/GetMultiUser/MultiUserBloc.dart';
import 'package:mvvm_flutter/data/api_service.dart';
import 'package:mvvm_flutter/utils/componentUi/card_view.dart';
import 'package:http/http.dart' as http;

class MultiPage extends StatelessWidget {
  const MultiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Random random = Random();
    return BlocProvider(
        create: (context) => MultiUserBloc(ApiService(client: http.Client()))
          ..add(GetMultiUserEvent(idpage: random.nextInt(3))),
        child: ListMultiUserPage());
  }
}

class ListMultiUserPage extends StatelessWidget {
  const ListMultiUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Random random = Random();
    MultiUserBloc multiUserViewModel = BlocProvider.of<MultiUserBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Multi User")),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  multiUserViewModel
                      .add(GetMultiUserEvent(idpage: random.nextInt(3)));
                },
                child: Text("Pick Random Multi User"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            BlocConsumer<MultiUserBloc, MultiUserState>(
              listener: (context, state) {
                if (state is MultiUserError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.blueAccent,
                      duration: Duration(seconds: 5),
                      //behavior mengatur jenis snackbar
                      behavior: SnackBarBehavior.fixed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.info_outline),
                          Text(state.message),
                          GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                            },
                            child: Icon(Icons.close),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is MultiUserLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is MultiUserSucces) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.user.data?.length,
                      itemBuilder: (context, index) {
                        return UserCard(state.user.data![index]);
                        //   ElevatedButton(
                        //       onPressed: () {},
                        //       child:
                        //           Text("${state.user.data![index].firstName}"));
                      },
                    ),
                  );
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
