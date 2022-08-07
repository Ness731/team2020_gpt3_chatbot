import 'package:flutter/material.dart';
import 'UI/intro.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenAI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0x90a2f0),
          primaryColorLight: Color(0xff987654),
          primaryColorDark: Color(0xff555555),
          secondaryHeaderColor: Color(0xff333333),
          backgroundColor: Color(0xff222222),
          textTheme: const TextTheme(
            bodyText1: TextStyle(color: Color(0xff131313), fontSize: 20),
            bodyText2: TextStyle(color: Color(0xff313131), fontSize: 20),
          ),
          scaffoldBackgroundColor: Colors.white
      ),
      home: Intro(),
    );
  }
}