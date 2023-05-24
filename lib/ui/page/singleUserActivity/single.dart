import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_flutter/ui/bloc/FavoriteItem/FavoriteBloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/local/local_data_source.dart';
import '../../bloc/SingleUser/SingleUserBloc.dart';
import 'package:mvvm_flutter/common/color.dart';
import 'package:mvvm_flutter/ui/page/loginActivity/loginPage.dart';
import 'package:mvvm_flutter/ui/page/multiUserActivity/multiPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../utils/appRoute.dart';
import '../../../utils/componentUi/card_view.dart';

class SinglePage extends StatelessWidget {
  const SinglePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<SingleUserBloc>(
        create: (BuildContext context) =>
            BlocProvider.of<SingleUserBloc>(context),
      ),
      BlocProvider<FavoriteUserBloc>(
        create: (BuildContext context) =>
            BlocProvider.of<FavoriteUserBloc>(context),
      ),
    ], child: const _SingleUserPage());
  }
}

class _SingleUserPage extends StatefulWidget {
  const _SingleUserPage({super.key});

  @override
  State<_SingleUserPage> createState() => __SingleUserPageState();
}

class __SingleUserPageState extends State<_SingleUserPage> {
  Future<bool?> getIsLogin() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? isLogin = prefs.getBool('isLogin');
    return isLogin;
  }

  void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLogin');
    await prefs.remove('isToken');
  }

  // void initState() {
  //   super.initState();
  //   clearDbFavorite(); // Panggil fungsi di sini
  // }

  // void clearDbFavorite() {
  //   FavoriteUserBloc favoriteViewModel =
  //       BlocProvider.of<FavoriteUserBloc>(context);
  //   favoriteViewModel.add(ClearDbFavoriteEvent());
  // }

  @override
  Widget build(BuildContext context) {
    final Random random = Random();
    late bool islogin;

    return
        // MultiBlocListener(
        //   listeners: const [
        //     BlocListener<FavoriteUserBloc, FavoriteItemState>(
        //         listener: _onFavoriteListener)
        //   ],
        //   child:
        Scaffold(
      appBar: AppBar(
          backgroundColor: colorPrimary,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          title: const Text("Single User"),
          actions: [
            FutureBuilder(
              future: getIsLogin(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  islogin = false;
                } else {
                  islogin = snapshot.data!;
                }
                return Container(
                  child: islogin
                      ? IconButton(
                          onPressed: () {
                            logout();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AppRoute.loginActivity()),
                                (route) => true);
                          },
                          icon: const Icon(Icons.logout))
                      : Container(),
                );
              },
            ),
            IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AppRoute.myFavoritePage()),
                    (route) => true,
                  );
                },
                icon: const Icon(Icons.favorite)),
            FutureBuilder(
              future: getIsLogin(),
              builder: (context, snapshot) => Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                    onPressed: () {
                      if (snapshot.data == null) {
                        islogin = false;
                      } else {
                        islogin = snapshot.data!;
                      }
                      print(islogin);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => islogin
                                ? AppRoute.addUserActivity()
                                : AppRoute.loginActivity()),
                      );
                    },
                    icon: const Icon(Icons.person_add_outlined)),
              ),
            )
          ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorPrimary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AppRoute.multiUserActivity()),
          );
        },
        child: const Icon(Icons.supervised_user_circle_rounded),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  SingleUserBloc userViewModel =
                      BlocProvider.of<SingleUserBloc>(context);
                  userViewModel
                      .add(GetSingleUserEvent(idUser: random.nextInt(10) + 1));
                },
                child: Text("Pick Random User"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<SingleUserBloc, SingleUserState>(
                listener: (context, state) {
              if (state is SingleUserError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: colorPrimary,
                    duration: const Duration(seconds: 5),
                    //behavior mengatur jenis snackbar
                    behavior: SnackBarBehavior.fixed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.info_outline),
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: 280,
                          child: const Text(
                            "Gagal Menghubungi Server, Harap Periksa Koneksi Internet Kamu",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        //   },
                        //   child: const Icon(Icons.close),
                        // ),
                      ],
                    ),
                  ),
                );
                print(state.message);
              }
            }, builder: (context, state) {
              if (state is SingleUserLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is SingleUserSucces) {
                print("succes");
                FavoriteUserBloc favoriteViewModel =
                    BlocProvider.of<FavoriteUserBloc>(context);
                return UserCard(state.user.data!);
              }

              return Container();
            }),
          ],
        ),
      ),
    );
    // );
  }
}

// Future<void> _onFavoriteListener(
//     BuildContext context, FavoriteItemState state) async {
//   if (state is FavoriteSucces) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         backgroundColor: colorPrimary,
//         duration: const Duration(seconds: 5),
//         //behavior mengatur jenis snackbar
//         behavior: SnackBarBehavior.fixed,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         content: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Icon(Icons.info_outline),
//             Container(
//               padding: const EdgeInsets.all(10),
//               width: 280,
//               child: Text(
//                 state.succes,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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