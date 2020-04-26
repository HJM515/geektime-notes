import 'package:flutter/material.dart';
import 'package:fluttertrip/dao/travel_tab_dao.dart';
import 'package:fluttertrip/model/travel_tab.dart';
import 'package:fluttertrip/pages/travel_item_page.dart';

class TravelPage extends StatefulWidget{
  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin{
  TabController _controller;
  List<Tabs> tabs = [];
  TravelTab travelTab;

  @override
  void initState() {
    _controller = TabController(length: 0, vsync: this);
    TravelTabDao.fetch().then((TravelTab model) {
      _controller = TabController(length: model.tabs.length, vsync: this);
      setState(() {
        tabs = model.tabs;
        travelTab = model;
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override 
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 30),
            child: TabBar(
              controller: _controller,
              isScrollable: true,
              labelColor: Colors.black,
              labelPadding: EdgeInsets.fromLTRB(20, 0, 10, 5),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: Color(0xff2fcfbb),
                  width: 3
                ),
                insets: EdgeInsets.only(bottom: 10)
              ),
              tabs: tabs.map((Tabs tab) {
                return Tab(
                  text: tab.labelName,
                );
              }).toList(),
            ),
          ),

          Flexible(
              child: TabBarView(
                  controller: _controller,
                  children: tabs.map((TravelTab tab) {
                    return TravelTabPage(
                      travelUrl: travelTabModel.url,
                      params: travelTabModel.params,
                      groupChannelCode: tab.groupChannelCode,
                    );
                  }).toList()))
        ],
      ),
    );
  }
}
