import 'package:flutter/material.dart';

class WalletsScreen extends StatefulWidget {
  const WalletsScreen({Key? key}) : super(key: key);

  @override
  _WalletsScreenState createState() => _WalletsScreenState();
}

class _WalletsScreenState extends State<WalletsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        title: Text("Accounts"),
      ),
      body: Center(child: Text("Wallets go here")),
    );
  }
}
