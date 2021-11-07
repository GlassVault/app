import 'package:black_vault/main.dart';
import 'package:black_vault/ui/screen/drawer.dart';
import 'package:flutter/material.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart';

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
        title: GradientText(
          "Passwords",
          gradient: RadialGradient(
              colors: Grad.sol, center: Alignment.centerRight, radius: 6),
        ),
      ),
      body: Center(child: Text("Passwords go here")),
    );
  }
}
