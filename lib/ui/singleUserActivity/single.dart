import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_flutter/bloc/GetSingleUser/SingleUserBloc.dart';
import 'package:mvvm_flutter/data/response/SingleUser.dart';
import 'package:mvvm_flutter/ui/multiUserActivity/multiPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../utils/componentUi/card_view.dart';

class SinglePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final Random random = Random();
    SingleUserBloc userViewModel = BlocProvider.of<SingleUserBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("MVVM with BLOC"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const MultiPage(),
          ));
        },
        child: Icon(Icons.supervised_user_circle_rounded),
      ),
      body: Center(
        child: Column(
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
            SizedBox(
              height: 20,
            ),
            BlocConsumer<SingleUserBloc, SingleUserState>(
                listener: (context, state) {
              if (state is SingleUserError) {
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
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
                          child: Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }, builder: (context, state) {
              if (state is SingleUserLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is SingleUserSucces) {
                return UserCard(state.user.data!);
              }

              return Container();
            }),
          ],
        ),
      ),
    );
  }
}

// class snackbar extends StatelessWidget {
//   const snackbar({super.key, required this.message});
//   final String message;
//   @override
//   Widget build(BuildContext context) {
//     final scaffoldMessenger = ScaffoldMessenger.of(context);
//     return Scaffold(
//       body: Expanded(child: scaffoldMessenger.showSnackBar(SnackBar(content: Text("sss"))),)
//     );
//   }
// }
               // SnackBar(
                //   content: Text('Data berhasil disimpan.'),
                //   backgroundColor: Colors.green,
                //   duration: Duration(seconds: 3),
                //   action: SnackBarAction(
                //     label: 'BATAL',
                //     textColor: Colors.white,
                //     onPressed: () {},
                //   ),
                // ),