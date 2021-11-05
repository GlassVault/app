import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:glassvault/ui/screen/documents.dart';
import 'package:glassvault/ui/screen/passwords.dart';
import 'package:glassvault/ui/screen/wallets.dart';

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
        borderRadius: Radius.circular(18),
        iconSize: 38,
        backgroundColor: Colors.transparent,
        elevation: 0,
        items: [
          CustomNavigationBarItem(icon: Icon(Icons.fifteen_mp_rounded)),
          CustomNavigationBarItem(icon: Icon(Icons.ten_k_rounded)),
          CustomNavigationBarItem(icon: Icon(Icons.twenty_mp_outlined)),
        ],
      ),
      body: Center(
        child:
            widget.pages[index](context) ?? Text("Couldnt Load this screen!"),
      ),
    );
  }
}
