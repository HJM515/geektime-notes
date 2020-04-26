import 'package:flutter/material.dart';
import './page1.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter lifecycle demo',
      theme: ThemeData(  // 保存Material组件库的主题数据，在子组件中，我们可以通过Theme.of方法来获取当前的ThemeData。
        primarySwatch: Colors.blue // primarySwatch 主题颜色样本
      ),
      home: Page1()
    );
  }
}