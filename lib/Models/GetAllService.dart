// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

GetAllService getAllServiceFromJson(String str) => GetAllService.fromJson(json.decode(str));

String getAllServiceToJson(GetAllService data) => json.encode(data.toJson());

class GetAllService {
  GetAllService({
    required this.msg,
  });

  List<Msg> msg;

  factory GetAllService.fromJson(Map<String, dynamic> json) => GetAllService(
    msg: List<Msg>.from(json["msg"].map((x) => Msg.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
  };
}

class Msg {
  Msg({
    required this.id,
    required this.imageUrl,
    required this.isMulti,
    required this.isactive,
    required this.params,
    required this.serviceDesc,
    required this.servicePrice,
    required this.serviceTitle,
  });

  int id;
  String imageUrl;
  int isMulti;
  int isactive;
  List<Param> params;
  String serviceDesc;
  int servicePrice;
  String serviceTitle;

  factory Msg.fromJson(Map<String, dynamic> json) => Msg(
    id: json["id"],
    imageUrl: json["image_url"],
    isMulti: json["is_multi"],
    isactive: json["isactive"],
    params: List<Param>.from(json["params"].map((x) => Param.fromJson(x))),
    serviceDesc: json["service_desc"],
    servicePrice: json["service_price"],
    serviceTitle: json["service_title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image_url": imageUrl,
    "is_multi": isMulti,
    "isactive": isactive,
    "params": List<dynamic>.from(params.map((x) => x.toJson())),
    "service_desc": serviceDesc,
    "service_price": servicePrice,
    "service_title": serviceTitle,
  };
}



class Param {
  Param({
    required this.param,
    required this.paramHeading,
    required this.paramPrice,
    required this.paramUrl,
    required this.paramtype,
  });

  String param;
  String paramHeading;
  int paramPrice;
  String paramUrl;
  String paramtype;

  factory Param.fromJson(Map<String, dynamic> json) => Param(
    param: json["param"],
    paramHeading: json["param_heading"],
    paramPrice: json["param_price"],
    paramUrl: json["param_url"],
    paramtype: json["paramtype"],
  );

  Map<String, dynamic> toJson() => {
    "param": param,
    "param_heading": paramHeading,
    "param_price": paramPrice,
    "param_url": paramUrl,
    "paramtype": paramtype,
  };
}