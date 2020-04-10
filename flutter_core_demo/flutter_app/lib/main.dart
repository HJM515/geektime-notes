import 'package:flutter/material.dart';
import './page1.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter lifecycle demo',
      theme: ThemeData(
        primarySwatch: Color.blue
      ),
      home: Page1()
    )
  }
}