import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_flutter/common/color.dart';
import 'package:mvvm_flutter/ui/bloc/FavoriteItem/FavoriteBloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyFavoritePage extends StatefulWidget {
  const MyFavoritePage({super.key});

  @override
  State<MyFavoritePage> createState() => _MyFavoritePageState();
}

class _MyFavoritePageState extends State<MyFavoritePage> {
  void initState() {
    super.initState();
    getDbFavorite(); // Panggil fungsi di sini
  }

  void getDbFavorite() {
    FavoriteUserBloc favoriteViewModel =
        BlocProvider.of<FavoriteUserBloc>(context);
    favoriteViewModel.add(GetFavoriteEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: const Text("My Favorite Person"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {
                  print("OnClick");
                  FavoriteUserBloc favoriteViewModel =
                      BlocProvider.of<FavoriteUserBloc>(context);
                  favoriteViewModel.add(ClearDbFavoriteEvent());
                },
                icon: const Icon(Icons.delete)),
          )
        ],
      ),
      body: BlocConsumer<FavoriteUserBloc, FavoriteItemState>(
        builder: (context, state) {
          if (state is FavoriteSucces) {
            //   Future.delayed(Duration(seconds: 2), () {
            //     // Widget yang ingin ditampilkan setelah penundaan
            //     return
            //  });
            WidgetsBinding.instance.addPostFrameCallback((_) {
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
            });
          }
          if (state is GetFavoriteSucces) {
            return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                var imgVariable = AssetImage("assets/image/profiledefault.png");
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
                        children: [
                          Container(
                            height: 75,
                            width: 75,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: imgVariable,
                                )),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text("ID : ${state.data[index].id.toString()}"),
                              Text(
                                  "Nama : ${state.data[index].first_name.toString()} ${state.data[index].lastName.toString()}"),
                              Text(
                                  "Email : ${state.data[index].email.toString()}"),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return Container(
              // child: ListView.builder(
              //   itemCount: state.,
              //   itemBuilder: (context, index) {
              //     return UserCard(state.user.data![index]);
              //     //   ElevatedButton(
              //     //       onPressed: () {},
              //     //       child:
              //     //           Text("${state.user.data![index].firstName}"));
              //   },
              // ),
              );
        },
        listener: (context, state) {
          if (state is FavoriteError) {
            print(state.message);
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
                        state.message,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

// Future<void> _getFavoriteListener(
//     BuildContext context, FavoriteItemState state) async {
//   if (state is GetFavoriteSucces) {
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
