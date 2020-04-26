import 'dart:async';
import 'dart:convert';
import '../model/travel_tab.dart';
import 'package:http/http.dart' as http;

class TravelTabDao {
  static Future<TravelTab> fetch() async{
    final response = await http.get('http://www.devio.org/io/flutter_app/json/travel_page.json');
    if(response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelTab.fromJson(result);
    }else{
      throw Exception('Failed to load travel_tab.json');
    }
  }
}