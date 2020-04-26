import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertrip/dao/home_dao.dart';
import 'package:fluttertrip/model/common_model.dart';
import 'package:fluttertrip/model/grid_nav_model.dart';
import 'package:fluttertrip/model/home_model.dart';
import 'package:fluttertrip/model/sales_box_model.dart';
import 'package:fluttertrip/pages/search_page.dart';
import 'package:fluttertrip/utils/navigator_util.dart';
import 'package:fluttertrip/widget/grid_nav.dart';
import 'package:fluttertrip/widget/loading_container.dart';
import 'package:fluttertrip/widget/local_nav.dart';
import 'package:fluttertrip/widget/sales_box.dart';
import 'package:fluttertrip/widget/search_bar.dart';
import 'package:fluttertrip/widget/sub_nav.dart';
import 'package:fluttertrip/widget/webview.dart';

const APPBAR_SCROLL_OFFSET = 100;
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CommonModel> bannerList = [];
  List<CommonModel> localNavList = [];
  List<CommonModel> subNavList = [];
  GridNavModel gridNav;
  SalesBoxModel salesBox;
  bool _loading = true;
  double appBarAlpha = 0;

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  Future<Null> _handleRefresh() async {
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        bannerList = model.bannerList;
        localNavList = model.localNavList;
        subNavList = model.subNavList;
        gridNav = model.gridNav;
        salesBox = model.salesBox;
        _loading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _loading = false;
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingContainer(
        isLoading: _loading,
        child: Stack(
          children: <Widget>[
            MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
                child: NotificationListener(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollUpdateNotification &&
                        scrollNotification.depth == 0) {
                      //滚动且是列表滚动的时候
                      _onScroll(scrollNotification.metrics.pixels);
                    }
                    return false; // 继续向上冒泡
                  },
                  child: _listView,
                ),
              ),
            ),
            _appBar
          ],
        ),
      ),
    );
  }

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }

  Widget get _listView {
    return ListView(
      children: <Widget>[
        _banner,
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(localNavList: localNavList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: GridNav(gridNavModel: gridNav),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: SubNav(subNavList: subNavList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: SalesBox(salesBox: salesBox),
        ),
      ],
    );
  }

  Widget get _appBar {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 80.0,
            decoration: BoxDecoration(
              color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255),
            ),
            child: SearchBar(
              searchBarType: appBarAlpha > 0.2 ? SearchBarType.homeLight : SearchBarType.home,
              inputBoxClick: _jumpToSearch,
              speakClick: _jumpToSpeak,
              defaultText: SEARCH_BAR_DEFAULT_TEXT,
              leftButtonClick: () {},
            ),
          ),
        )
      ],
    );
  }

  Widget get _banner {
    return Container(
      height: 160,
      child: Swiper(
          itemCount: bannerList.length,
          autoplay: true,
          pagination: SwiperPagination(),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () {
                  CommonModel model = bannerList[index];
                  NavigatorUtil.push(
                      context,
                      WebView(
                        url: model.url,
                        title: model.title,
                        hideAppBar: model.hideAppBar,
                      ));
                },
                child: Image.network(bannerList[index].icon, fit: BoxFit.fill));
          }),
    );
  }

  _jumpToSearch() {
    NavigatorUtil.push(context, SearchPage(hint: SEARCH_BAR_DEFAULT_TEXT));
  }

  _jumpToSpeak() {
    NavigatorUtil.push(context, SearchPage(hint: SEARCH_BAR_DEFAULT_TEXT));
  }
}
