import 'package:flutter/material.dart';
import 'package:machine_test/view/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Public APIs',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.black,
        ),
        primaryColor: Colors.black,
        primarySwatch: Colors.grey,
        colorScheme: ColorScheme.fromSwatch(
          accentColor: Colors.transparent,
        ),
      ),
      home: const Home(),
    );
  }
}
