import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/GetAllOrders.dart';
import '../Models/GetAllService.dart';
import '../Models/GetAllSliders.dart';
import '../Utils/Apis.dart';

class Homedata_Method {
  Map homedata = {};


  gethomepagedata() async {
    await getcartlen();
    await getservices();
    await getorders();
    return homedata;
  }


  getcartlen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> header = {
      'Content-Type': 'application/json-patch+json',
      'accept': 'application/json'
    };
    var bodydata = jsonEncode({
      "user_id": prefs.getString('email'),
    });
    final response = await http.post(Uri.parse(Apis.get_all_slider),
        headers: header, body: bodydata);
    if (response.statusCode == 200) {
      homedata['cart_count']=GetAllSliders.fromJson(jsonDecode(response.body)).cartlen;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  getservices() async {
    List serviceslist = [];
    Map<String,String> header = {'Content-Type':'application/json-patch+json','accept':'application/json'};
    final response = await http.post(Uri.parse(Apis.get_all_service),headers: header);
    if(response.statusCode == 200){
      for(int i=0;i<GetAllService.fromJson(jsonDecode(response.body)).msg.length;i++){
        serviceslist.add({
          'service_id':GetAllService.fromJson(jsonDecode(response.body)).msg[i].id,
          'image_url':GetAllService.fromJson(jsonDecode(response.body)).msg[i].imageUrl,
          'is_multi':GetAllService.fromJson(jsonDecode(response.body)).msg[i].isMulti,
          'service_price':GetAllService.fromJson(jsonDecode(response.body)).msg[i].servicePrice,
          'service_title':GetAllService.fromJson(jsonDecode(response.body)).msg[i].serviceTitle,
          'service_params':GetAllService.fromJson(jsonDecode(response.body)).msg[i].params,
        });
      }
      homedata['serlist']=serviceslist;
    }else{
      // throw Exception('Failed to load album');
      return GetAllService.fromJson(jsonDecode(response.body));

    }
  }

  getorders() async {
    List orderlist = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String,String> header = {'Content-Type':'application/json-patch+json','accept':'application/json'};
    var bodydata = jsonEncode(
        {
          "user_id":prefs.getString('email'),
        }
    );
    final response = await http.post(Uri.parse(Apis.getallorder),body: bodydata,headers: header);

    if(response.statusCode == 200){
      for(int i=0;i<GetAllOrders.fromJson(jsonDecode(response.body)).msg.length;i++){
        orderlist.add(GetAllOrders.fromJson(jsonDecode(response.body)).msg[i]);
      }
      homedata['orderlist']=orderlist;
    }
    else{
      return;
    }
  }
}
