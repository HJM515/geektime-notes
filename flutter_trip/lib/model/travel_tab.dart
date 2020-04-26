import 'package:json_annotation/json_annotation.dart'; 
  
part 'travel_tab.g.dart';


@JsonSerializable()
  class TravelTab extends Object {

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'params')
  Params params;

  @JsonKey(name: 'tabs')
  List<Tabs> tabs;

  TravelTab(this.url,this.params,this.tabs,);

  factory TravelTab.fromJson(Map<String, dynamic> srcJson) => _$TravelTabFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TravelTabToJson(this);

}

  
@JsonSerializable()
  class Params extends Object {

  @JsonKey(name: 'districtId')
  int districtId;

  @JsonKey(name: 'groupChannelCode')
  String groupChannelCode;

  @JsonKey(name: 'lat')
  int lat;

  @JsonKey(name: 'lon')
  int lon;

  @JsonKey(name: 'locatedDistrictId')
  int locatedDistrictId;

  @JsonKey(name: 'pagePara')
  PagePara pagePara;

  @JsonKey(name: 'imageCutType')
  int imageCutType;

  @JsonKey(name: 'head')
  Head head;

  @JsonKey(name: 'contentType')
  String contentType;

  Params(this.districtId,this.groupChannelCode,this.lat,this.lon,this.locatedDistrictId,this.pagePara,this.imageCutType,this.head,this.contentType,);

  factory Params.fromJson(Map<String, dynamic> srcJson) => _$ParamsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ParamsToJson(this);

}

  
@JsonSerializable()
  class PagePara extends Object {

  @JsonKey(name: 'pageIndex')
  int pageIndex;

  @JsonKey(name: 'pageSize')
  int pageSize;

  @JsonKey(name: 'sortType')
  int sortType;

  @JsonKey(name: 'sortDirection')
  int sortDirection;

  PagePara(this.pageIndex,this.pageSize,this.sortType,this.sortDirection,);

  factory PagePara.fromJson(Map<String, dynamic> srcJson) => _$PageParaFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PageParaToJson(this);

}

  
@JsonSerializable()
  class Head extends Object {

  @JsonKey(name: 'cid')
  String cid;

  @JsonKey(name: 'ctok')
  String ctok;

  @JsonKey(name: 'cver')
  String cver;

  @JsonKey(name: 'lang')
  String lang;

  @JsonKey(name: 'sid')
  String sid;

  @JsonKey(name: 'syscode')
  String syscode;

  @JsonKey(name: 'extension')
  List<Extension> extension;

  Head(this.cid,this.ctok,this.cver,this.lang,this.sid,this.syscode,this.extension,);

  factory Head.fromJson(Map<String, dynamic> srcJson) => _$HeadFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeadToJson(this);

}

  
@JsonSerializable()
  class Extension extends Object {

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'value')
  String value;

  Extension(this.name,this.value,);

  factory Extension.fromJson(Map<String, dynamic> srcJson) => _$ExtensionFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ExtensionToJson(this);

}

  
@JsonSerializable()
  class Tabs extends Object {

  @JsonKey(name: 'labelName')
  String labelName;

  @JsonKey(name: 'groupChannelCode')
  String groupChannelCode;

  Tabs(this.labelName,this.groupChannelCode,);

  factory Tabs.fromJson(Map<String, dynamic> srcJson) => _$TabsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TabsToJson(this);

}

  
