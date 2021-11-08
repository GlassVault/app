import 'package:black_vault/main.dart';
import 'package:black_vault/ui/screen/documents.dart';
import 'package:black_vault/ui/screen/passwords.dart';
import 'package:black_vault/ui/screen/wallets.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart';

typedef Build = Widget? Function(BuildContext context);

class HomeScreen extends StatefulWidget {
  List<Build> pages = <Build>[
    (ctx) => DocumentsScreen(),
    (ctx) => PasswordsScreen(),
    (ctx) => WalletsScreen(),
  ];

  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        bubbleCurve: Curves.easeOutCirc,
        scaleFactor: 0.0001,
        scaleCurve: Curves.easeInOutSine,
        iconSize: 38,
        backgroundColor: Colors.transparent,
        elevation: 0,
        strokeColor: Grad.sol[0],
        items: [
          CustomNavigationBarItem(
              icon: GradientIcon(Icons.folder_outlined,
                  gradient: RadialGradient(
                      colors: Grad.solFaint,
                      radius: 1.77,
                      center: Alignment.bottomCenter)),
              selectedIcon: GradientIcon(
                Icons.folder_rounded,
                gradient: RadialGradient(
                    colors: Grad.sol,
                    radius: 0.787,
                    center: Alignment.topCenter),
              )),
          CustomNavigationBarItem(
              icon: GradientIcon(Icons.shield_outlined,
                  gradient: RadialGradient(
                      colors: Grad.solFaint,
                      radius: 1.77,
                      center: Alignment.bottomCenter)),
              selectedIcon: GradientIcon(
                Icons.shield_rounded,
                gradient: RadialGradient(
                    colors: Grad.sol,
                    radius: 1.77,
                    center: Alignment.bottomCenter),
              )),
          CustomNavigationBarItem(
              icon: GradientIcon(Icons.account_balance_wallet_outlined,
                  gradient: RadialGradient(
                      colors: Grad.solFaint,
                      radius: 1.77,
                      center: Alignment.bottomCenter)),
              selectedIcon: GradientIcon(
                Icons.account_balance_wallet_rounded,
                gradient: RadialGradient(
                    colors: Grad.sol, radius: 1.37, center: Alignment.topLeft),
              )),
        ],
      ),
      body: Center(
        child:
            widget.pages[index](context) ?? Text("Couldnt Load this screen!"),
      ),
    );
  }
}
