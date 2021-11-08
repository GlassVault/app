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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: VaultDrawer(),
      primary: true,
      key: _scaffoldKey,
      appBar: AppBar(
        leading: GradientIconButton(
          icon: Icon(Icons.menu),
          gradient: RadialGradient(
              colors: Grad.sol, radius: 1.2, center: Alignment.topLeft),
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
        ),
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
