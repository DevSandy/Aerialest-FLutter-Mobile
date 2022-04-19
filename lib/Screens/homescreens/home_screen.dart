import 'package:aerial_est_mobile/Methods/Homedata_Method.dart';
import 'package:aerial_est_mobile/Screens/cart_screens/cart_screen.dart';
import 'package:aerial_est_mobile/Utils/aecolors.dart';
import 'package:aerial_est_mobile/Widgets/ServiceBottomModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/Apis.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  _Home_ScreenState createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  String username= '';
  Map homepagedata = {'serlist': [], 'orderlist': [], 'cart_count': 0};
  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return homepagedata['serlist'].length != 0
        ? Scaffold(
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(top: 35, bottom: 8, left: 8, right: 8),
                    color: Colors.blue,
                    child: Row(
                      children: [
                        Text(
                          'Hello, $username',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Stack(
                            children: [
                              Positioned(
                                right: 5,
                                bottom: 5,
                                child: CircleAvatar(
                                    backgroundColor:
                                        Colors.transparent.withAlpha(1),
                                    child: IconButton(
                                      icon: const Icon(Icons.shopping_cart),
                                      splashColor: Colors.blue,
                                      splashRadius: 30,
                                      color: Colors.white,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Cart_Screen()),
                                        );
                                      },
                                    )),
                              ),
                              Positioned(
                                  right: 2,
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.red,
                                    ),
                                    child: Center(
                                      child: Text(
                                        homepagedata['cart_count'].toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: aecolors.primary,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
                            child: const Text(
                              'Recent Orders',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0;
                                  i < homepagedata['orderlist'].length;
                                  i++)
                                Container(
                                  margin: const EdgeInsets.all(8),
                                  height: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color.fromRGBO(
                                                143, 148, 251, .2),
                                            blurRadius: 5.0,
                                            offset: Offset(
                                              5,
                                              5,
                                            ))
                                      ]),
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/logo.png',
                                          height: 60,
                                          width: 60,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.all(5),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                homepagedata['orderlist'][i]
                                                    .params
                                                    .serviceName
                                                    .toString(),
                                                style: TextStyle(
                                                    color: aecolors.primary,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                homepagedata['orderlist'][i]
                                                    .orderId,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                              Text(
                                                homepagedata['orderlist'][i]
                                                    .createdAt,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                            margin: const EdgeInsets.all(5),
                                            child: CircleAvatar(
                                                backgroundColor:
                                                    aecolors.primary,
                                                child: const Icon(
                                                  Icons.arrow_forward_outlined,
                                                  color: Colors.white,
                                                )))
                                      ],
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
                      child: const Text(
                        'Book Now',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      )),
                  Container(
                    margin: const EdgeInsets.only(left: 8, right: 8),
                    child: GridView.count(
                      physics: const ScrollPhysics(),
                      crossAxisCount: 2,
                      scrollDirection: Axis.vertical,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      shrinkWrap: true,
                      children: [
                        for (int i = 0; i < homepagedata['serlist'].length; i++)
                          Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(10, 10))
                                ]),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.network(
                                    Apis.base_url +
                                        homepagedata['serlist'][i]['image_url'],
                                    height: 110,
                                    width: 110,
                                  ),
                                  Text(homepagedata['serlist'][i]
                                      ['service_title']),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () async {
                                      await ServiceBottomModal().showmodal(
                                          context, homepagedata['serlist'][i]);
                                    },
                                    child: Container(
                                      height: 50,
                                      color: Colors.blue,
                                      child: const Center(
                                        child: Text(
                                          'Book Now',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString('firstname')!+" "+prefs.getString('lastname')!;
    homepagedata = await Homedata_Method().gethomepagedata();
    setState(() {});
  }
}
