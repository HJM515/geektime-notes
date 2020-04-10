import 'package:flutter/material.dart';

class Parent extends StatefulWidget {
  Parent({Key key}): super(key: key);
  _ParentState createState() => _ParentState();
}

class _ParentState extends State<Parent> {
  int _counter = 0;

  // Widget第一次插入Widget树时会被调用
  @override
  void initState() {
    super.initState();
    print('page2 parent initState...');
  }

  @override
  void setState(fn) {
    super.setState(fn);
    print('page2 parent setState...');
  }

  /**
   * 初始化initState之后立即调用
   * State依赖关系发生变化时调用
   */
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('page2 parent didChangeDependencies');
  }

  // 绘制界面
  @override
  Widget build(BuildContext context) {
    print('page2 parent build...');
    return Scaffold(
      appBar: AppBar(title: Text('setState demo')),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            setState(() {
              _counter++;
            });
          },
          child: Child(count: _counter)
        ),
      )
    );
  }

  // 状态改变时调用
  @override
  void didUpdateWidget(Parent oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('page2 parent didUpdateWidget');
  }

  // State对象从树中被移除时调用
  @override
  void deactivate() {
    super.deactivate();
    print('page2 parent deactivate...');
  }

  // State对象从树中永久移除时调用
  @override
  void dispose() {
    super.dispose();
    print('page2 parent dispose...');
  }
}

class Child extends StatefulWidget {
  final int count;
  Child({Key key, this.count}): super(key: key);

  @override
  _ChildState createState() => _ChildState();
}

class _ChildState extends State<Child> {
  
}