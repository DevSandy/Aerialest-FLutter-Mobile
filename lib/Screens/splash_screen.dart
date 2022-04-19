import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/login_screen.dart';
import 'homescreens/dashboard_screen.dart';
class Splash_Screen extends StatefulWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  _Splash_ScreenState createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {

  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/logo.png',width: screensize.width/2,),
      ),
    );
  }

  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('email'));
    if(prefs.getString('email')==""||prefs.getString('email')==null){
      Future.delayed(
          const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login_Screen()),
        );
      });
    }else{
      Future.delayed(
          const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard_Screen()),
        );
      });
    }
  }
}
