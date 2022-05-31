import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungtleproject/states/authen.dart';
import 'package:ungtleproject/states/my_service.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (context) => const Authen(),
  '/myService': (context) => const MyService(),
};

String? firstState;

Future<void> main() async {
  HttpOverrides.global = MyHttpOverride();
  firstState = '/authen';

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var result = sharedPreferences.getStringList('data');
  print('result at main ==> $result');

  if (result != null) {
    firstState = '/myService';
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: map,
      initialRoute: firstState,
    );
  }
}

class MyHttpOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
