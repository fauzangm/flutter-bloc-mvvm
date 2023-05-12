import 'package:flutter/material.dart';
import 'di/injection.dart' as di;
import 'package:mvvm_flutter/utils/appRoute.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _getMainWidget(),
    );
  }
}

Widget _getMainWidget() => AppRoute.singleUserActivity();
