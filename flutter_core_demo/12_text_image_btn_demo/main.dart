import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  debugPaintLayerBordersEnabled=true;
  debugPaintBaselinesEnabled=true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter lifecycle demo',
      theme: ThemeData(
        primaryColor: Colors.lightBlue[800],
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  
TextStyle blackStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20, color: Colors.black); //黑色样式

TextStyle redStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red); //红色样式

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('common component'),),
      body: Column(
        children: <Widget>[
          Text(
            '文本是视图系统中的常见控件，用来显示一段特定样式的字符串文本是视图系统中的常见控件，用来显示一段特定样式的字符串',
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.green),
          ),
          Text.rich(
              TextSpan(
                  children: <TextSpan>[
                    TextSpan(text:'文本是视图系统中常见的控件，它用来显示一段特定样式的字符串，类似', style: redStyle), //第1个片段，红色样式 
                    TextSpan(text:'Android', style: blackStyle), //第1个片段，黑色样式 
                    TextSpan(text:'中的', style:redStyle), //第1个片段，红色样式 
                    TextSpan(text:'TextView', style: blackStyle) //第1个片段，黑色样式 
                  ]),
            textAlign: TextAlign.right,
          ),
          FloatingActionButton(onPressed: () => print('FloatingActionButton pressed'),child: Text('Btn'),),
          FlatButton(onPressed: () => print('FlatButton pressed'),child: Text('Btn'),),
          RaisedButton(onPressed: () => print('RaisedButton pressed'),child: Text('Btn'),),
          FlatButton(
              color: Colors.yellow, //设置背景色为黄色
              shape:BeveledRectangleBorder(borderRadius: BorderRadius.circular(20.0)), //设置斜角矩形边框
              colorBrightness: Brightness.light, //确保文字按钮为深色
              onPressed: () => print('FlatButton pressed'), 
              child: Row(children: <Widget>[Icon(Icons.add), Text("Add")],)
          )
        ],
      )
    );
  }
}
