import 'package:flutter/material.dart';
import 'package:neurostore/utils/constants.dart';
import 'package:neurostore/view/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NeuroStore',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.black,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
              .copyWith(secondary: Colors.black),
          fontFamily: 'Roboto',
          textTheme: const TextTheme(
            titleLarge: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black87,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          scaffoldBackgroundColor: backgroundColor),
      home: HomePage(),
    );
  }
}
