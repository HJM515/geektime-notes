// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'travel_tab.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TravelTab _$TravelTabFromJson(Map<String, dynamic> json) {
  return TravelTab(
      json['url'] as String,
      json['params'] == null
          ? null
          : Params.fromJson(json['params'] as Map<String, dynamic>),
      (json['tabs'] as List)
          ?.map((e) =>
              e == null ? null : Tabs.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$TravelTabToJson(TravelTab instance) => <String, dynamic>{
      'url': instance.url,
      'params': instance.params,
      'tabs': instance.tabs
    };

Params _$ParamsFromJson(Map<String, dynamic> json) {
  return Params(
      json['districtId'] as int,
      json['groupChannelCode'] as String,
      json['lat'] as int,
      json['lon'] as int,
      json['locatedDistrictId'] as int,
      json['pagePara'] == null
          ? null
          : PagePara.fromJson(json['pagePara'] as Map<String, dynamic>),
      json['imageCutType'] as int,
      json['head'] == null
          ? null
          : Head.fromJson(json['head'] as Map<String, dynamic>),
      json['contentType'] as String);
}

Map<String, dynamic> _$ParamsToJson(Params instance) => <String, dynamic>{
      'districtId': instance.districtId,
      'groupChannelCode': instance.groupChannelCode,
      'lat': instance.lat,
      'lon': instance.lon,
      'locatedDistrictId': instance.locatedDistrictId,
      'pagePara': instance.pagePara,
      'imageCutType': instance.imageCutType,
      'head': instance.head,
      'contentType': instance.contentType
    };

PagePara _$PageParaFromJson(Map<String, dynamic> json) {
  return PagePara(json['pageIndex'] as int, json['pageSize'] as int,
      json['sortType'] as int, json['sortDirection'] as int);
}

Map<String, dynamic> _$PageParaToJson(PagePara instance) => <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'sortType': instance.sortType,
      'sortDirection': instance.sortDirection
    };

Head _$HeadFromJson(Map<String, dynamic> json) {
  return Head(
      json['cid'] as String,
      json['ctok'] as String,
      json['cver'] as String,
      json['lang'] as String,
      json['sid'] as String,
      json['syscode'] as String,
      (json['extension'] as List)
          ?.map((e) =>
              e == null ? null : Extension.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$HeadToJson(Head instance) => <String, dynamic>{
      'cid': instance.cid,
      'ctok': instance.ctok,
      'cver': instance.cver,
      'lang': instance.lang,
      'sid': instance.sid,
      'syscode': instance.syscode,
      'extension': instance.extension
    };

Extension _$ExtensionFromJson(Map<String, dynamic> json) {
  return Extension(json['name'] as String, json['value'] as String);
}

Map<String, dynamic> _$ExtensionToJson(Extension instance) =>
    <String, dynamic>{'name': instance.name, 'value': instance.value};

Tabs _$TabsFromJson(Map<String, dynamic> json) {
  return Tabs(json['labelName'] as String, json['groupChannelCode'] as String);
}

Map<String, dynamic> _$TabsToJson(Tabs instance) => <String, dynamic>{
      'labelName': instance.labelName,
      'groupChannelCode': instance.groupChannelCode
    };
