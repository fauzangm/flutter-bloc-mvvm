import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_flutter/bloc/MultiUser/MultiUserBloc.dart';
import 'package:mvvm_flutter/ui/loginActivity/loginPage.dart';
import 'package:mvvm_flutter/ui/multiUserActivity/multiPage.dart';
import '../di/injection.dart' as di;
import '../bloc/SingleUser/SingleUserBloc.dart';
import '../ui/singleUserActivity/single.dart';

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

  static Widget authActivity() {
    Widget nextScreen = const LoginPage();
    // BlocProvider(
    //     create: (context) => di.locator<MultiUserBloc>(),
    //     child: const MultiPage());
    return nextScreen;
  }
}
