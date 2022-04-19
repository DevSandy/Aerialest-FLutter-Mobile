import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../order_screens/my_order_screen.dart';
import '../profile_screens/profile_screen.dart';
import '../wallet_screens/wallet_screen.dart';
import 'home_screen.dart';
class Dashboard_Screen extends StatefulWidget {
  const Dashboard_Screen({Key? key}) : super(key: key);

  @override
  _Dashboard_ScreenState createState() => _Dashboard_ScreenState();
}

class _Dashboard_ScreenState extends State<Dashboard_Screen> {
  int _index = 0;
  List _pages = [
    Home_Screen(),
    My_Order_Screen(),
    Wallet_Screen(),
    Profile_Screen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: _pages[_index],
      extendBody: true,
      bottomNavigationBar: FloatingNavbar(
        selectedItemColor: Colors.blue,
        backgroundColor: Colors.blue,
        onTap: (int val) => setState(() => _index = val),
        currentIndex: _index,
        items: [
          FloatingNavbarItem(icon: Icons.home, title: 'Home'),
          FloatingNavbarItem(icon: Icons.shopping_bag, title: 'My Orders'),
          FloatingNavbarItem(icon: Icons.account_balance_wallet, title: 'Wallet'),
          FloatingNavbarItem(icon: Icons.person, title: 'Profile'),
        ],
      ),
    );
  }
}
