import 'package:flutter/material.dart';
class Wallet_Screen extends StatefulWidget {
  const Wallet_Screen({Key? key}) : super(key: key);

  @override
  _Wallet_ScreenState createState() => _Wallet_ScreenState();
}

class _Wallet_ScreenState extends State<Wallet_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wallet"),
      ),
    );  }
}
