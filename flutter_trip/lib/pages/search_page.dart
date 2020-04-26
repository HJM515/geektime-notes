import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget{
  final String hint;
  const SearchPage({ Key key, this.hint}): super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Text('搜索'),
    );
  }
}
