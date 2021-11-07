import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassvault/main.dart';
import 'package:glassvault/ui/screen/add_wallet.dart';
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
          onPressed: () =>
              Get.to(() => AddWallet(), transition: Transition.downToUp),
          label: Text("Add Wallet"),
          icon: Icon(Icons.add_rounded),
          gradient: RadialGradient(
              colors: Grad.sol, center: Alignment.topLeft, radius: 11)),
      primary: true,
      appBar: AppBar(
        title: GradientText(
          "Wallets",
          gradient: RadialGradient(
              colors: Grad.sol, center: Alignment.bottomRight, radius: 11),
        ),
      ),
      body: Center(child: Text("Wallets go here")),
    );
  }
}
