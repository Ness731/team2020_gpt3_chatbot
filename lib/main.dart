import 'package:flutter/material.dart';
import 'UI/intro.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPT3 ChatBot',
      theme: ThemeData.light(),
      home: Intro(),
    );
  }
}