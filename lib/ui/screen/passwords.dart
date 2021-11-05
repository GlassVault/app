import 'package:flutter/material.dart';

class PasswordsScreen extends StatefulWidget {
  const PasswordsScreen({Key? key}) : super(key: key);

  @override
  _PasswordsScreenState createState() => _PasswordsScreenState();
}

class _PasswordsScreenState extends State<PasswordsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        title: Text("Passwords"),
      ),
      body: Center(child: Text("Passwords go here")),
    );
  }
}
