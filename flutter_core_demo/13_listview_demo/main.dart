import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter lifecycle demo',
      theme: ThemeData(
        primaryColor: Colors.lightBlue[800],
      ),
      home: MyHomePage(title: 'Custom UI'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({Key key, this.title}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: <Widget>[
            ParalleWidget(),
            ScrollNotificationWidget(),
            ScrollControllerWidget()
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: <Widget>[
            Tab(icon: Icon(Icons.home), text: '视差'),
            Tab(icon: Icon(Icons.rss_feed), text: 'Notification'),
            Tab(icon: Icon(Icons.perm_identity), text: 'Controller')
          ],
          unselectedLabelColor: Colors.blueGrey, // 未选中tab颜色
          labelColor: Colors.blue,  // 选择tab颜色
          indicatorSize: TabBarIndicatorSize.label, // 选中指示条尺寸
          indicatorColor: Colors.red, // 芝士条颜色
        ),
      ),
    );
  }
}

class ParalleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[ // 独立、可滚动的widget
        SliverAppBar( // 头图控件
          title: Text('CustomScrollView Demo'),
          floating: true, //  设置浮动样式
          flexibleSpace: Image.network("https://media-cdn.tripadvisor.com/media/photo-s/13/98/8f/c2/great-wall-hiking-tours.jpg",fit:BoxFit.cover),
          expandedHeight: 280, // 头图空间高度
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(title: Text('Item #$index'),),  // 列表创建方法
            childCount: 100,
          ),
        )
      ],
    );
  }
}

class ScrollNotificationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scroll Notification Demo',
      home: Scaffold(
        appBar: AppBar(title: Text('ScrollNotificationWidget Demo'),),
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification) {
            if(ScrollNotification is ScrollStartNotification) {
              print('Scroll Start');
            }else if(ScrollNotification is ScrollUpdateNotification) {
              print('Scroll Update');
            }else if(ScrollNotification is ScrollEndNotification) {
              print('Scroll End');
            }
            // if (scrollNotification.metrics.pixels > 500) {
            //   setState(() {
            //     isToTop = true;
            //   });
            // } else if (scrollNotification.metrics.pixels < 300) {
            //   setState(() {
            //     isToTop = false;
            //   });
            // }
          },
          child: ListView.builder(
            itemBuilder: (context, index) => ListTile(title: Text('index: $index'),),
            itemCount: 30,
          ),
        ),
      ),
    );
  }
}

class ScrollControllerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScrollControllerState();
}

class _ScrollControllerState extends State<ScrollControllerWidget> {
  ScrollController _controller; // ListView控制器
  bool isToTop = false;
  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      if(_controller.offset > 1000) {
        setState(() {
          isToTop = true;
        });
      }else if(_controller.offset < 300) {
        setState(() {
          isToTop = false;
        });
      }
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scroll Controller Widget'),),
      body: Column(
        children: <Widget>[
          Container(
            height: 40.0,
            child: RaisedButton(
              onPressed: (isToTop ? () {
                if(isToTop) {
                  _controller.animateTo(.0, duration: Duration(microseconds: 200), curve: Curves.ease);
                }
              } : null),
              child: Text('Top'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _controller,
              itemCount: 100,
              itemBuilder: (context, index) => ListTile(title: Text('Index: $index'),),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}