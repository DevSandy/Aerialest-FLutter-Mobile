import 'package:aerial_est_mobile/Screens/auth/register_screen.dart';
import 'package:aerial_est_mobile/Screens/homescreens/dashboard_screen.dart';
import 'package:flutter/material.dart';

import '../../Methods/AuthMethod.dart';
import '../../Widgets/LoaderDialog.dart';
import 'forgot_password_screen.dart';
class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  _Login_ScreenState createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          color: Colors.lightBlue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
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
                        child: Text("Welcome Back", style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text('If you are an existing user, please login below.',style: TextStyle(fontSize: 12),),
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
                                      controller: emailcontroller,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Enter your email",
                                          hintStyle: TextStyle(color: Colors.grey[400])
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: passwordcontroller,
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
                            const SizedBox(height: 30,),
                            GestureDetector(
                                onTap: () async {
                                  LoaderDialog(context);
                                  var res = await AuthMethod().LoginMethod(emailcontroller.text,passwordcontroller.text);
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
                                    child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                  ),
                                )),
                            const SizedBox(height: 20,),
                            GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Register_Screen()),
                                  );
                                },
                                child:  Container(
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
                                    child: Text("Register", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                  ),
                                )),

                            const SizedBox(height: 30,),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Forgot_Password_Screen()),
                                );
                              },
                              child: const Text("Forgot Password?", style: TextStyle(color: Colors.lightBlue),),
                            ),

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
