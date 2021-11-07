import 'package:flutter/material.dart';
import 'package:glassvault/ui/screen/drawer.dart';

class PasswordsScreen extends StatefulWidget {
  const PasswordsScreen({Key? key}) : super(key: key);

  @override
  _PasswordsScreenState createState() => _PasswordsScreenState();
}

class _PasswordsScreenState extends State<PasswordsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: VaultDrawer(),
      primary: true,
      appBar: AppBar(
        title: Text("Passwords"),
      ),
      body: Center(child: Text("Passwords go here")),
    );
  }
}
