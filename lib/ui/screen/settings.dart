import 'package:black_vault/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool dark;
  late List<String> networks;
  late String network;

  @override
  void initState() {
    networks = Properties.NETWORKS.keys.toList(growable: false);
    dark = context.box().get("dark", defaultValue: false);
    network =
        context.box().get("network", defaultValue: Properties.DEFAULT_NETWORK);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        title: GradientText(
          "Settings",
          gradient: RadialGradient(
              colors: Grad.sol, center: Alignment.topLeft, radius: 8),
        ),
      ),
      body: ListView(
        children: [
          CheckboxListTile(
              secondary: GradientIcon(
                Icons.palette_rounded,
                gradient: RadialGradient(
                    colors: Grad.sol,
                    radius: 1.787,
                    center: Alignment.topRight),
              ),
              title: Text("Dark Theme"),
              value: dark,
              onChanged: (f) => setState(() {
                    dark = f!;
                    context.box().put("dark", f);
                    Get.forceAppUpdate();
                  })),
          ExpansionTile(
            title: Text("Network"),
            leading: GradientIcon(
              Icons.signal_cellular_alt_rounded,
              gradient: RadialGradient(
                  colors: Grad.sol,
                  radius: 1.187,
                  center: Alignment.bottomLeft),
            ),
            subtitle: Text(Properties.initializedNetwork == network
                ? network
                : network + " (App Restart Required)"),
            children: [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, pos) => RadioListTile<String>(
                    value: networks[pos],
                    groupValue: network,
                    title: Text(networks[pos]),
                    onChanged: (f) => setState(() {
                          network = f!;
                          context.box().put("network", network);
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(kIsWeb
                                  ? "You need to refresh/relaunch to switch networks."
                                  : "You need to relaunch Black Vault to change the network.")));
                        })),
                itemCount: Properties.NETWORKS.length,
              )
            ],
          )
        ],
      ),
    );
  }
}
