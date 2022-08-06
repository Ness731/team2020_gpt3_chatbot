import 'package:flutter/material.dart';
import 'lib/UI/intro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPT3 ChatBot',
      theme: ThemeData.light(),
      home: Intro(),
    );
  }
}