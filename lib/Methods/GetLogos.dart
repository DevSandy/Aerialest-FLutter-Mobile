import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

import '../Utils/Apis.dart';

class GetLogos{
  getuserlogos() async {
    List logolist = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email')!;
    Map<String,String> header = {'Content-Type':'application/json-patch+json','accept':'application/json'};
    var bodydata = jsonEncode(
        {
          "user_id":email,
        }
    );
    final response = await http.post(Uri.parse(Apis.getuserlogos),body: bodydata,headers: header);
    if(response.statusCode == 200){
      logolist = jsonDecode(response.body)['logos'];
      print(jsonDecode(response.body)['logos']);
      return logolist;
    }
  }

  uploadlogotoserver(File pickedImage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uri = Uri.parse(Apis.uploaduserlogo);
    var request = http.MultipartRequest('POST', uri)
      ..fields['user'] = prefs.getString('email')
      ..files.add(await http.MultipartFile.fromPath(
          'logo', pickedImage.path,
          contentType: MediaType('application', 'x-tar')));
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    print(response.body);
    return Apis.base_url+response.body;
  }
}