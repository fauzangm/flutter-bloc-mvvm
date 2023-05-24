import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_flutter/common/color.dart';
import 'package:mvvm_flutter/data/remote/api_service.dart';
import 'package:mvvm_flutter/ui/bloc/FavoriteItem/FavoriteBloc.dart';

import '../../data/remote/model/DataUser.dart';

class UserCard extends StatelessWidget {
  final Data data;
  bool isSameData = false;
  UserCard(this.data);

  @override
  Widget build(BuildContext context) {
    print("build UserCard");
    Future<void> _onSaveFavoriteListener(
        BuildContext context, FavoriteItemState state) async {
      if (state is FavoriteStateClicked) {
        if (data.isFavorite == false && isSameData == false) {
          BlocProvider.of<FavoriteUserBloc>(context)
              .add(InsertFavoriteEvent(data));
          data.isFavorite = true;
          print("favorite onclick ${data.isFavorite}");
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
      } else if (state is FavoriteSucces) {
        print("favorite succes ${data.isFavorite}");
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
                  child: Text(
                    state.succes,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      } else if (state is GetFavoriteSucces) {
        print("succes GetFavorite");
        state.data.forEach((element) {
          print("ketika foreach $element dan $data");
          if (data.email == element.email) {
            isSameData = true;
            print("result true $isSameData");
          }
          print("result false $isSameData");
        });
        BlocProvider.of<FavoriteUserBloc>(context).add(GetFavoriteEvent());
      }
    }

    // final favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    return BlocConsumer<FavoriteUserBloc, FavoriteItemState>(
        listener: _onSaveFavoriteListener,
        builder: (context, state) {
          print("build bloc");
          BlocProvider.of<FavoriteUserBloc>(context).add(GetFavoriteEvent());
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
                    Transform.translate(
                      offset: const Offset(0.0, -10.0),
                      child: SizedBox(
                        height: 20,
                        child: IconButton(
                          icon: Icon(
                            isSameData
                                ? Icons.favorite
                                : data.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                            color: isSameData
                                ? Colors.red
                                : data.isFavorite
                                    ? Colors.red
                                    : null,
                          ),
                          onPressed: () {
                            print(
                                "lenght ${data.toString()} ${data.isFavorite}");

                            BlocProvider.of<FavoriteUserBloc>(context)
                                .add(FavoriteEventClick());
                          },
                        ),
                      ),
                    )
                    // FavoriteWidget(
                    //   user: user,
                    // ),
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
                              image: NetworkImage("${data.avatar}"))),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("ID : ${data.id}"),
                        Text("Nama : ${data.first_name} ${data.lastName}"),
                        Text("Email : ${data.email}"),
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }
}


// class FavoriteWidget extends StatelessWidget {
//   final Data user;
//   // final Function() toggleFavorite;

//   FavoriteWidget({required this.user});

//   @override
//   Widget build(BuildContext context) {
//     // if (state is FavoriteStateClicked) {
//     //   isFavorite = true;
//     // }
//     print("data ${user.isFavorite}");
//     return Transform.translate(
//       offset: Offset(0.0, -10.0),
//       child: Container(
//         height: 20,
//         child: IconButton(
//           icon: Icon(
//             user.isFavorite ? Icons.favorite : Icons.favorite_border,
//             color: user.isFavorite ? Colors.red : null,
//           ),
//           onPressed: () {
//             print("lenght ${user.toString()}");

//             BlocProvider.of<FavoriteUserBloc>(context)
//                 .add(FavoriteEventClick());
//           },
//         ),
//       ),
//     );
//   }
// }
