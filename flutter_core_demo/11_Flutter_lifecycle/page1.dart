import 'package:flutter/material.dart';
import './page2.dart';

class Page1 extends StatefulWidget {
  Page1({Key key}): super(key: key);
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    print('page1 initState');
    WidgetsBinding.instance.addObserver(this); // 注册监听器

    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('单次Frame绘制回调$_');
    });

    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      print('实时Frame绘制回调');
    });
  }

  @override
  void setState(fn) {
    super.setState(fn);
    print('page1 setState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('page1 didChangeDependencies');
  }

  @override
  Widget build(BuildContext context) {
    print('page1 build...');
    return Scaffold(
      appBar: AppBar(title: Text('lifecycle demo')),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('打开、关闭新页面查看状态变化'),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Parent())),
            )
      ],),)
    );
  }

  @override
  void didUpdateWidget(Page1 oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('page1 didUpdateWidget...');
  }

  @override
  void deactivate() {
    super.deactivate();
    print('page1 deactivate');
  }

  @override
  void dispose() {
    super.dispose();
    print('page1 dispose');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // super.didChangeAppLifecycleState(state);
    print('$state');
    if(state == AppLifecycleState.resumed) {
      print('AppLifecycleState.resumed');
    }
  } 
}