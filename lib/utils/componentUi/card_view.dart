import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_flutter/common/color.dart';

import '../../data/remote/model/DataUser.dart';
import '../../ui/bloc/FavoriteItem/FavoriteEvent.dart';
import '../../ui/bloc/FavoriteItem/FavoriteState.dart';
import '../../ui/bloc/FavoriteItem/Favorite_bloc.dart';

class UserCard extends StatelessWidget {
  final Data user;

  UserCard(this.user);
  @override
  Widget build(BuildContext context) {
    // final favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    return BlocProvider<FavoriteBloc>(
      create: (BuildContext context) => FavoriteBloc(),
      child: Container(
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlocBuilder<FavoriteBloc, FavoriteState>(
                  builder: (context, state) {
                    return FavoriteWidget(
                      isFavorite: state.isFavorite,
                      toggleFavorite: (isFavorite) =>
                          BlocProvider.of<FavoriteBloc>(context)
                              .add(ToggleFavoriteEvent(isFavorite)),
                    );
                  },
                )
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
                    Text("ID : ${user.email}"),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteWidget extends StatelessWidget {
  final bool isFavorite;
  final Function(bool) toggleFavorite;

  FavoriteWidget({required this.isFavorite, required this.toggleFavorite});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0.0, -10.0),
      child: Container(
        height: 20,
        child: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : null,
          ),
          onPressed: () => toggleFavorite(!isFavorite),
        ),
      ),
    );
  }
}
