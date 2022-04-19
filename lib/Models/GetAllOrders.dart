// To parse this JSON data, do
//
//     final getAllOrders = getAllOrdersFromJson(jsonString);

import 'dart:convert';

GetAllOrders getAllOrdersFromJson(String str) => GetAllOrders.fromJson(json.decode(str));

String getAllOrdersToJson(GetAllOrders data) => json.encode(data.toJson());

class GetAllOrders {
  GetAllOrders({
    required this.msg,
  });

  List<Msg> msg;

  factory GetAllOrders.fromJson(Map<String, dynamic> json) => GetAllOrders(
    msg: List<Msg>.from(json["msg"].map((x) => Msg.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
  };
}

class Msg {
  Msg({
    required this.createdAt,
    required this.orderId,
    required this.params,
    required this.progress,
    required this.userId,
  });

  String createdAt;
  String orderId;
  Params params;
  int progress;
  String userId;

  factory Msg.fromJson(Map<String, dynamic> json) => Msg(
    createdAt: json["created_at"],
    orderId: json["order_id"],
    params: Params.fromJson(json["params"]),
    progress: json["progress"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "created_at": createdAt,
    "order_id": orderId,
    "params": params.toJson(),
    "progress": progress,
    "user_id": userId,
  };
}

class Params {
  Params({
    required this.serviceId,
    required this.serviceName,
    required this.serviceParam,
  });

  int serviceId;
  String serviceName;
  ServiceParam serviceParam;

  factory Params.fromJson(Map<String, dynamic> json) => Params(
    serviceId: json["service_id"],
    serviceName: json["service_name"],
    serviceParam: ServiceParam.fromJson(json["service_param"]),
  );

  Map<String, dynamic> toJson() => {
    "service_id": serviceId,
    "service_name": serviceName,
    "service_param": serviceParam.toJson(),
  };
}

class ServiceParam {
  ServiceParam({
    required this.alternativeEmail,
    required this.delivery,
    required this.measurements,
    required this.optionalDeliverables,
    required this.pitchValue,
    required this.address,
    required this.autodiscountedprice,
    required this.latitude,
    required this.longitude,
    required this.paymentMode,
    required this.price,
    required this.specialNotes,
    required this.type,
    required this.coordinates,
    required this.quantity,
  });

  String? alternativeEmail;
  String? delivery;
  String? measurements;
  List<String> optionalDeliverables;
  String? pitchValue;
  String? address;
  double? autodiscountedprice;
  String? latitude;
  String? longitude;
  String? paymentMode;
  int price;
  String? specialNotes;
  String? type;
  String? coordinates;
  String? quantity;

  factory ServiceParam.fromJson(Map<String, dynamic> json) => ServiceParam(
    alternativeEmail: json["Alternative Email"],
    delivery: json["Delivery"],
    measurements: json["Measurements"],
    optionalDeliverables: List<String>.from(json["Optional Deliverables"].map((x) => x)),
    pitchValue: json["Pitch Value"] == null ? null : json["Pitch Value"],
    address: json["address"],
    autodiscountedprice: json["autodiscountedprice"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    paymentMode: json["payment_mode"],
    price: json["price"],
    specialNotes: json["Special Notes"],
    type: json["Type"],
    coordinates: json["coordinates"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "Alternative Email": alternativeEmail == null ? null : alternativeEmail,
    "Delivery": delivery,
    "Measurements": measurements,
    "Optional Deliverables": List<dynamic>.from(optionalDeliverables.map((x) => x)),
    "Pitch Value": pitchValue == null ? null : pitchValue,
    "address": address,
    "autodiscountedprice": autodiscountedprice,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "payment_mode": paymentMode,
    "price": price,
    "Special Notes": specialNotes == null ? null : specialNotes,
    "Type": type == null ? null : type,
    "coordinates": coordinates == null ? null : coordinates,
    "quantity": quantity == null ? null : quantity,
  };
}
