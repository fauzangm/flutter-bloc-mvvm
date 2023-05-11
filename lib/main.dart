import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_flutter/data/remote/api_service.dart';
import 'package:mvvm_flutter/data/repository/user/UserRepository.dart';
import 'package:mvvm_flutter/ui/singleUserActivity/single.dart';
import 'package:http/http.dart' as http;
import 'bloc/SingleUser/SingleUserBloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        child: SinglePage(),
        create: (context) => SingleUserBloc(UserRepository(http.Client())),
      ),
    );
  }
}
