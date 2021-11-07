import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassvault/main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool dark;

  @override
  void initState() {
    dark = context.box().get("dark", defaultValue: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: [
          CheckboxListTile(
              title: Text("Dark Theme"),
              value: dark,
              onChanged: (f) => setState(() {
                    dark = f!;
                    context.box().put("dark", f);
                    Get.forceAppUpdate();
                  }))
        ],
      ),
    );
  }
}
