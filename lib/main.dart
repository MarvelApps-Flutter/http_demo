import 'package:flutter/material.dart';
import 'package:http_movies_app/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter HTTP Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: const Color.fromRGBO(2, 34, 60, 1)),
        home: HomePage());
  }
}
