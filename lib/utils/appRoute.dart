import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_flutter/data/remote/model/DataUser.dart';
import 'package:mvvm_flutter/ui/bloc/FavoriteItem/Favorite_bloc.dart';
import 'package:mvvm_flutter/ui/bloc/MultiUser/MultiUserBloc.dart';
import 'package:mvvm_flutter/ui/page/loginActivity/loginPage.dart';
import 'package:mvvm_flutter/ui/page/multiUserActivity/multiPage.dart';
import 'package:mvvm_flutter/utils/componentUi/card_view.dart';
import '../di/injection.dart' as di;
import '../ui/bloc/SingleUser/SingleUserBloc.dart';
import '../ui/page/singleUserActivity/single.dart';

class AppRoute {
  static Widget singleUserActivity() {
    Widget nextScreen = BlocProvider(
        create: (context) => di.locator<SingleUserBloc>(),
        child: const SinglePage());
    return nextScreen;
  }

  static Widget multiUserActivity() {
    Widget nextScreen = BlocProvider(
        create: (context) => di.locator<MultiUserBloc>(),
        child: const MultiPage());
    return nextScreen;
  }

  // static Widget userCard() {
  //   Widget nextScreen = BlocProvider(
  //       create: (context) => di.locator<FavoriteBloc>(),
  //       child: UserCard(Data as Data));
  //   return nextScreen;
  // }

  static Widget authActivity() {
    Widget nextScreen = const LoginPage();
    // BlocProvider(
    //     create: (context) => di.locator<MultiUserBloc>(),
    //     child: const MultiPage());
    return nextScreen;
  }
}
