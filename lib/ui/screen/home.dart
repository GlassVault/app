import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:glassvault/ui/screen/documents.dart';
import 'package:glassvault/ui/screen/passwords.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart';

typedef Build = Widget? Function(BuildContext context);

class HomeScreen extends StatefulWidget {
  List<Build> pages = <Build>[
    (ctx) => DocumentsScreen(),
    (ctx) => PasswordsScreen(),
  ];

  List<List<Color>> grads = <List<Color>>[
    GradientColors.blue,
    GradientColors.orange
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
        strokeColor: widget.grads[index][0],
        items: [
          CustomNavigationBarItem(
              icon: Icon(Icons.folder_outlined),
              selectedIcon: GradientIcon(
                Icons.folder_rounded,
                gradient: LinearGradient(colors: widget.grads[0]),
              )),
          CustomNavigationBarItem(
              icon: Icon(Icons.shield_outlined),
              selectedIcon: GradientIcon(
                Icons.shield_rounded,
                gradient: LinearGradient(colors: widget.grads[1]),
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
