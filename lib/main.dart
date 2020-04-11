import 'package:covidtrack/screens/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid-19 Tracker',
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 0,
          ),
          textTheme: TextTheme().apply(
            bodyColor: Colors.black,
          ),
          scaffoldBackgroundColor: Color(0xffE3F2FD)),
      home: HomePage(),
    );
  }
}
