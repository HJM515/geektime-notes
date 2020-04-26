import 'package:flutter/material.dart';
import 'package:fluttertrip/pages/home_page.dart';
import 'package:fluttertrip/pages/my_page.dart';
import 'package:fluttertrip/pages/search_page.dart';
import 'package:fluttertrip/pages/travel_page.dart';

class TabNavigator extends StatefulWidget{
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;
  final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(), // 可滚动组件，用户停止滑动后 禁止滑动
        children: <Widget>[
          HomePage(),
          SearchPage(),
          TravelPage(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          _bottomItem('首页', Icons.home, 0),
          _bottomItem('搜索', Icons.search, 1),
          _bottomItem('旅拍', Icons.camera_alt, 2),
          _bottomItem('我的', Icons.account_circle, 3),
        ]
      ),


    );
  }

  _bottomItem(String title, IconData icon, int index) {
      return BottomNavigationBarItem(
          title: Text(
              title,
              style: TextStyle(
                     color: _currentIndex == index ? _activeColor : _defaultColor,
                 )
          ),
          icon: Icon(
            icon,
            color: _defaultColor
          ),
          activeIcon: Icon(
            icon,
            color: _activeColor
          ),
      );
  }
}


