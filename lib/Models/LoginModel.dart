// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.msg,
    required this.userDetails,
  });

  String msg;
  UserDetails userDetails;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    msg: json["msg"],
    userDetails: UserDetails.fromJson(json["user_details"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "user_details": userDetails.toJson(),
  };
}

class UserDetails {
  UserDetails({
    required this.billingAddress,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.secondaryEmail,
    required this.wallet,
  });

  String billingAddress;
  String email;
  String firstName;
  String lastName;
  String secondaryEmail;
  int wallet;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    billingAddress: json["billing_address"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    secondaryEmail: json["secondary_email"],
    wallet: json["wallet"],
  );

  Map<String, dynamic> toJson() => {
    "billing_address": billingAddress,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "secondary_email": secondaryEmail,
    "wallet": wallet,
  };
}
