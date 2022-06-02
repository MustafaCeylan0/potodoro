// ignore_for_file: unrelated_type_equality_checks
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '/home.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PoTO-Doro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(220, 231, 242, 1.0),
        primaryColorDark: const Color.fromRGBO(47, 69, 105, 1.0),
        backgroundColor: const Color.fromRGBO(216, 129, 146, 0.6),
      ),
      home:  MyHomePage(todo: null,),
    );
  }
}