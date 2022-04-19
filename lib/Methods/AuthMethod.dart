import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/LoginModel.dart';
import '../Utils/Apis.dart';

class AuthMethod{

  LoginMethod(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String,String> header = {'Content-Type':'application/json-patch+json','accept':'application/json'};
    var bodydata = jsonEncode(
        {
          "email":email,
          "password":password,
        }
    );
    final response = await http.post(Uri.parse(Apis.login_api),body: bodydata,headers: header);
    if(response.statusCode == 200){
      prefs.setString('email',LoginModel.fromJson(jsonDecode(response.body)).userDetails.email);
      prefs.setString('firstname',LoginModel.fromJson(jsonDecode(response.body)).userDetails.firstName);
      prefs.setString('lastname',LoginModel.fromJson(jsonDecode(response.body)).userDetails.lastName);
      return {
        'event':true,
        'msg':'Login Success'
      };
    } else if(response.statusCode == 202){
      return {
        'event':false,
        'msg':'User Not Found'
      };
    }else{
      return {
        'event':false,
        'msg':'Something Went Wrong'
      };
    }
  }

  RegisterMethod(String fname, String lname, String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String,String> header = {'Content-Type':'application/json-patch+json','accept':'application/json'};
    var bodydata = jsonEncode(
        {
          "firstname":fname,
          "lastname":lname,
          "email":email,
          "password":password,
        }
    );
    final response = await http.post(Uri.parse(Apis.register_api),body: bodydata,headers: header);
    if(response.statusCode == 200){
      prefs.setString('email',email);
      prefs.setString('firstname',fname);
      prefs.setString('lastname',lname);
      return {
        'event':true,
        'msg': 'Registration Successfull'
      };
    }
    else if(response.statusCode == 202){
      return {
        'event':false,
        'msg': 'User Already Exist'
      };
    }
    else{
      return {
        'event':false,
        'msg': 'Something Went Wrong'
      };
    }
  }
}