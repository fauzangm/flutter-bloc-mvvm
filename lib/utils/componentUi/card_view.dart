import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_flutter/common/color.dart';
import 'package:mvvm_flutter/ui/bloc/FavoriteItem/FavoriteBloc.dart';

import '../../data/remote/model/DataUser.dart';

class UserCard extends StatelessWidget {
  final Data user;
  bool isFavorite = false;
  UserCard(this.user);
  @override
  Widget build(BuildContext context) {
    // final favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    return BlocConsumer<FavoriteUserBloc, FavoriteItemState>(
        listener: _onSaveFavoriteListener,
        builder: (context, state) {
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: colorPrimaryDark,
                      offset: Offset(1, 1),
                      blurRadius: 7)
                ],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: colorPrimaryLight)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FavoriteWidget(
                      isFavorite: isFavorite,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 75,
                      width: 75,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: NetworkImage("${user.avatar}"))),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("ID : ${user.id}"),
                        Text("Nama : ${user.firstName} ${user.lastName}"),
                        Text("Email : ${user.email}"),
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }

  Future<void> _onSaveFavoriteListener(
      BuildContext context, FavoriteItemState state) async {
    if (state is FavoriteStateClicked) {
      if (isFavorite == false) {
        BlocProvider.of<FavoriteUserBloc>(context)
            .add(InsertFavoriteEvent(user));
        isFavorite = true;
      } else {
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
                    "Kamu telah menyukai personal ini",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
    /** STATE SUCCES SUDAH DI DEKLARASI DI SINGLE PAGE  */
    // else if (state is FavoriteSucces) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       backgroundColor: colorPrimary,
    //       duration: const Duration(seconds: 5),
    //       //behavior mengatur jenis snackbar
    //       behavior: SnackBarBehavior.fixed,
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(20),
    //       ),
    //       content: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           const Icon(Icons.info_outline),
    //           Container(
    //             padding: const EdgeInsets.all(10),
    //             width: 280,
    //             child: const Text(
    //               'Berhasil',
    //               maxLines: 2,
    //               overflow: TextOverflow.ellipsis,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }
  }
}

class FavoriteWidget extends StatelessWidget {
  final bool isFavorite;
  // final Function() toggleFavorite;

  FavoriteWidget({required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    // if (state is FavoriteStateClicked) {
    //   isFavorite = true;
    // }
    return Transform.translate(
      offset: Offset(0.0, -10.0),
      child: Container(
        height: 20,
        child: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : null,
          ),
          onPressed: () {
            print("onclick");
            BlocProvider.of<FavoriteUserBloc>(context)
                .add(FavoriteEventClick());
          },
        ),
      ),
    );
  }
}
