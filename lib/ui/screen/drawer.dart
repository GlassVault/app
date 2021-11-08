import 'package:black_vault/main.dart';
import 'package:black_vault/ui/screen/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart';

class VaultDrawer extends StatefulWidget {
  const VaultDrawer({Key? key}) : super(key: key);

  @override
  _VaultDrawerState createState() => _VaultDrawerState();
}

class _VaultDrawerState extends State<VaultDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
                colors: Grad.solFaint,
                center: Alignment.bottomRight,
                radius: 3)),
        child: Stack(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: <Color>[
                    Theme.of(context).scaffoldBackgroundColor,
                    Colors.transparent
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                )),
              ),
            ),
            SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: 200,
                    child: Stack(
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.all(14),
                            child: Image.asset("assets/icon.png"),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(7),
                          child: GradientIconButton(
                            gradient: RadialGradient(
                                colors: Grad.sol,
                                center: Alignment.bottomRight,
                                radius: 2.5),
                            icon: Icon(Icons.menu),
                            onPressed: () => Navigator.pop(context),
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ListTile(
                          leading: GradientIcon(
                            Icons.settings_rounded,
                            gradient: RadialGradient(
                                colors: Grad.sol,
                                radius: 0.387,
                                center: Alignment.center),
                          ),
                          title: Text("Settings"),
                          onTap: () {
                            Navigator.pop(context);
                            Get.to(() => SettingsScreen(),
                                transition: Transition.leftToRightWithFade);
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
