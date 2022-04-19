import 'package:flutter/material.dart';

import '../../Methods/AuthMethod.dart';
import '../../Widgets/LoaderDialog.dart';
import '../homescreens/dashboard_screen.dart';
import 'login_screen.dart';
class Register_Screen extends StatefulWidget {
  const Register_Screen({Key? key}) : super(key: key);

  @override
  _Register_ScreenState createState() => _Register_ScreenState();
}

class _Register_ScreenState extends State<Register_Screen> {
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: height,
          width: width,
          color: Colors.lightBlue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.only(top: height/12),
                  child: CircleAvatar(
                      radius: width/5,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset('assets/images/logo.png'),
                      )
                  ),
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: height/1.5,
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(width/3)
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12,horizontal: 12),
                        child: Text("Register Now", style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text('If you are new here, please fill details below.',style: TextStyle(fontSize: 12),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 40,top: 30),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color.fromRGBO(143, 148, 251, .2),
                                        blurRadius: 20.0,
                                        offset: Offset(0, 10)
                                    )
                                  ]
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.grey.shade100))
                                    ),
                                    child: TextField(
                                      controller: firstnamecontroller,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "First name",
                                          hintStyle: TextStyle(color: Colors.grey[400])
                                      ),
                                    ),
                                  ),

                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.grey.shade100))
                                    ),
                                    child: TextField(
                                      controller: lastnamecontroller,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Last name",
                                          hintStyle: TextStyle(color: Colors.grey[400])
                                      ),
                                    ),
                                  ),

                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.grey.shade100))
                                    ),
                                    child: TextField(
                                      controller: emailcontroller,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Enter your email",
                                          hintStyle: TextStyle(color: Colors.grey[400])
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: passwordcontroller,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Password",
                                          hintStyle: TextStyle(color: Colors.grey[400])
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 20,),
                            GestureDetector(
                                onTap: () async {
                                  bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailcontroller.text);
                                  if(emailValid == false){
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter valid email")));
                                    return;
                                  }
                                  if(firstnamecontroller.text==""&&lastnamecontroller.text==""&&emailcontroller.text==""&&passwordcontroller.text==""){
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all fields")));
                                  }else{
                                    LoaderDialog(context);
                                    var res = await AuthMethod().RegisterMethod(firstnamecontroller.text,lastnamecontroller.text,emailcontroller.text,passwordcontroller.text);
                                    Navigator.pop(context);
                                    if(res['event']==true){
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res['msg'])));
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => const Dashboard_Screen()),
                                      );
                                    }else{
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res['msg'])));
                                    }
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(
                                          colors: [
                                            Colors.lightBlue,
                                            Colors.blue,
                                          ]
                                      )
                                  ),
                                  child: const Center(
                                    child: Text("Register", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                  ),
                                )),

                            SizedBox(height: 10,),
                            GestureDetector(
                                onTap: (){
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => Login_Screen()),
                                  );
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(
                                          colors: [
                                            Colors.blue,
                                            Colors.lightBlue,
                                          ]
                                      )
                                  ),
                                  child: const Center(
                                    child: Text("Go Back", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                  ),
                                )),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
