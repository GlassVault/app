import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:gradient_ui_widgets/buttons/gradient_floating_action_button.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart';

class WalletsScreen extends StatefulWidget {
  const WalletsScreen({Key? key}) : super(key: key);

  @override
  _WalletsScreenState createState() => _WalletsScreenState();
}

class _WalletsScreenState extends State<WalletsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GradientFloatingActionButton.extended(
          onPressed: () {},
          label: Text("Add Wallet"),
          icon: Icon(Icons.add_rounded),
          gradient: LinearGradient(colors: GradientColors.blue)),
      primary: true,
      appBar: AppBar(
        title: Text("Wallets"),
      ),
      body: Center(child: Text("Wallets go here")),
    );
  }
}
