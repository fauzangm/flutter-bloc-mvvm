import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_flutter/data/remote/model/DataUser.dart';
import 'package:mvvm_flutter/ui/bloc/CreateUser/CreateUserBloc.dart';
import 'package:mvvm_flutter/ui/bloc/FavoriteItem/FavoriteBloc.dart';
import 'package:mvvm_flutter/ui/bloc/LoginUser/LoginUserBloc.dart';
import 'package:mvvm_flutter/ui/bloc/MultiUser/MultiUserBloc.dart';
import 'package:mvvm_flutter/ui/page/addUser/addUserPage.dart';
import 'package:mvvm_flutter/ui/page/loginActivity/loginPage.dart';
import 'package:mvvm_flutter/ui/page/multiUserActivity/multiPage.dart';
import 'package:mvvm_flutter/utils/componentUi/card_view.dart';
import '../di/injection.dart' as di;
import '../ui/bloc/SingleUser/SingleUserBloc.dart';
import '../ui/page/singleUserActivity/single.dart';

class AppRoute {
  static Widget singleUserActivity() {
    Widget nextScreen = MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<SingleUserBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<FavoriteUserBloc>(),
        ),
      ],
      child: SinglePage(),
    );

    return nextScreen;
  }

  static Widget multiUserActivity() {
    Widget nextScreen = MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<MultiUserBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<FavoriteUserBloc>(),
        ),
      ],
      child: MultiPage(),
    );

    return nextScreen;
  }

  static Widget addUserActivity() {
    Widget nextScreen = BlocProvider(
        create: (context) => di.locator<CreateUserBloc>(),
        child: const AddUserPage());
    return nextScreen;
  }

  // static Widget favoriteWidget() {
  //   Widget nextScreen = BlocProvider(
  //     create: (context) => di.locator<FavoriteUserBloc>(),
  //     child: const SinglePage(),
  //   );
  //   return nextScreen;
  // }

  // static Widget favoriteWidgetMultiPage() {
  //   Widget nextScreen = BlocProvider(
  //     create: (context) => di.locator<FavoriteUserBloc>(),
  //     child: const MultiPage(),
  //   );
  //   return nextScreen;
  // }

  // static Widget userCard() {
  //   Widget nextScreen = BlocProvider(
  //       create: (context) => di.locator<FavoriteBloc>(),
  //       child: UserCard(Data as Data));
  //   return nextScreen;
  // }

  static Widget loginActivity() {
    Widget nextScreen = BlocProvider(
        create: (context) => di.locator<LoginUserBloc>(),
        child: const LoginPage());
    return nextScreen;
  }
}
