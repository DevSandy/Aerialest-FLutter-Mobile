// To parse this JSON data, do
//
//     final getAllSliders = getAllSlidersFromJson(jsonString);
import 'dart:convert';

GetAllSliders getAllSlidersFromJson(String str) => GetAllSliders.fromJson(json.decode(str));

String getAllSlidersToJson(GetAllSliders data) => json.encode(data.toJson());

class GetAllSliders {
  GetAllSliders({
    required this.msg,
    required this.cartlen
  });

  List<MsgSlider> msg;
  int cartlen;

  factory GetAllSliders.fromJson(Map<String, dynamic> json) => GetAllSliders(
    msg: List<MsgSlider>.from(json["msg"].map((x) => MsgSlider.fromJson(x))),
    cartlen: json['cartlen'],
  );

  Map<String, dynamic> toJson() => {
    "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
    "cartlen": cartlen,
  };
}

class MsgSlider {
  MsgSlider({
    required this.description,
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.title,
  });

  String description;
  int id;
  String imageUrl;
  String name;
  String title;

  factory MsgSlider.fromJson(Map<String, dynamic> json) => MsgSlider(
    description: json["description"],
    id: json["id"],
    imageUrl: json["image url"],
    name: json["name"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "id": id,
    "image url": imageUrl,
    "name": name,
    "title": title,
  };
}
