import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.lightBlue[800],
      ),
      home: MyHomePage(title: 'Custom UI'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, this.title}): super(key:key);

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  TabController _tabController;

  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(
          tabs: <Widget>[
            Tab(icon: Icon(Icons.system_update), text: '组合',),
            Tab(icon: Icon(Icons.cake), text: '自绘',)
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ListView(
            children: <Widget>[
              UpdatedItemWidget(model: UpdatedItemModel(
                appIcon: 'assets/icon.png',
                appDescription: 'Thanks for using Google Maps!',
                appName: 'Google Maps - Tansit & Fond',
                appSize: '137.2',
                appVersion: 'Version 5.19',
                appDate: '2019.06.05'
              ), onPressed: () {})
            ],
          ),
          Center(child: Cake(),)
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class UpdatedItemModel {
  String appIcon;
  String appDescription;
  String appName;
  String appSize;
  String appVersion;
  String appDate;
  UpdatedItemModel({this.appIcon, this.appDescription, this.appName, this.appSize, this.appVersion, this.appDate});
}

class UpdatedItemWidget extends StatelessWidget {
  final UpdatedItemModel model;
  final VoidCallback onPressed;
  UpdatedItemWidget({Key key, this.model, this.onPressed}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildTopRow(context),
        buildBottomRow(context)
      ],
    );
  }

  Widget buildTopRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(model.appIcon, width: 80, height: 80),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(model.appName, maxLines: 1, overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 20, color: Color(0xFF8E8D92)),),
              Text(model.appDate, maxLines: 1, overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16, color: Color(0xFF8E8D92)),),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: FlatButton(
            color: Color(0xFFF1F0F7),
            highlightColor: Colors.blue[700],
            colorBrightness: Brightness.dark,
            child: Text('OPEN', style: TextStyle(color: Color(0xFF007AFE), fontWeight: FontWeight.bold),),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            onPressed: onPressed,
          ),
        )
      ],
    );
  }

  Widget buildBottomRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(model.appDescription),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Text('${model.appVersion} ~ ${model.appSize}MB'),
          )
        ],
      ),
    );
  }
}

class Cake extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(200, 200),
      painter: WheelPainter(),
    );
  }
}

class WheelPainter extends CustomPainter {
  Paint getColoredPaint(Color color) {
    Paint paint = Paint();
    paint.color = color;
    return paint;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double wheelSize = min(size.width, size.height) / 2;
    double nbElem = 6;
    double radius = (2 * pi) / nbElem;
    Rect boundingRect = Rect.fromCircle(center: Offset(wheelSize, wheelSize), radius: wheelSize);

    canvas.drawArc(boundingRect, 0, radius, true, getColoredPaint((Colors.orange)));
    canvas.drawArc(boundingRect, radius, radius, true, getColoredPaint((Colors.black)));
    canvas.drawArc(boundingRect, radius * 2, radius, true, getColoredPaint((Colors.green)));
    canvas.drawArc(boundingRect, radius * 3, radius, true, getColoredPaint((Colors.grey)));
    canvas.drawArc(boundingRect, radius * 4, radius, true, getColoredPaint((Colors.blue)));
    canvas.drawArc(boundingRect, radius * 5, radius, true, getColoredPaint((Colors.pink)));
  }

  @override
  bool shouldRepaint(CustomPainter oldDeleget) => oldDeleget != this;
}




