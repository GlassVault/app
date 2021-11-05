import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassvault/ui/screen/home.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';

class Properties {
  static const String RPC_SERVER =
      "https://mainnet.infura.io/v3/a46ace53e3f74ccaa1e4487b1f27f8c5";
}

Future<Web3Client> initRPC() async =>
    Web3Client(Properties.RPC_SERVER, Client());

Future<Box> initStorage() async {
  if (!kIsWeb) {
    Hive.init("data");
  }

  return Hive.openBox("box");
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initStorage().then((box) => initRPC().then((rpc) => runApp(BlackVault(
        rpc: rpc,
        box: box,
      ))));
}

class BlackVault extends StatefulWidget {
  final Box box;
  final Web3Client rpc;

  const BlackVault({Key? key, required this.box, required this.rpc})
      : super(key: key);

  @override
  _BlackVaultState createState() => _BlackVaultState();
}

class _BlackVaultState extends State<BlackVault> {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<Box>(
            create: (_) => widget.box,
          ),
          Provider<Web3Client>(
            create: (_) => widget.rpc,
          )
        ],
        child: GetMaterialApp(
          title: "Black Vault",
          darkTheme: ThemeData(),
          theme: ThemeData(
              appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  titleTextStyle:
                      TextStyle(color: Colors.black38, fontSize: 42))),
          themeMode: ThemeMode.light,
          home: HomeScreen(),
        ),
      );
}

extension XBuildContext on BuildContext {
  Box box() => this.read<Box>();
  Web3Client rpc() => this.read<Web3Client>();
}
