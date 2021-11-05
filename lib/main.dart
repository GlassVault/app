import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

Future<Box> initStorage() async {
  if (!kIsWeb) {
    Hive.init("data");
  }

  return Hive.openBox("box");
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initStorage().then((box) => runApp(GlassVault(
        box: box,
      )));
}

class GlassVault extends StatefulWidget {
  final Box box;

  const GlassVault({Key? key, required this.box}) : super(key: key);

  @override
  _GlassVaultState createState() => _GlassVaultState();
}

class _GlassVaultState extends State<GlassVault> {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<Box>(
            create: (_) => widget.box,
          )
        ],
        child: GetMaterialApp(),
      );
}

extension XBuildContext on BuildContext {
  Box box() => read<Box>();
}
