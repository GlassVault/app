// ignore_for_file: no_logic_in_create_state

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassvault/ui/screen/home.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';

class Properties {
  static String initializedNetwork = "...";
  static const String PROJECT_ID = "a46ace53e3f74ccaa1e4487b1f27f8c5";
  static const String DEFAULT_NETWORK = "Polygon Mainnet";
  static const Map<String, String> NETWORKS = <String, String>{
    'Mainnet': 'https://mainnet.infura.io/v3/$PROJECT_ID',
    'Ropsten': 'https://ropsten.infura.io/v3/$PROJECT_ID',
    'Kovan': 'https://kovan.infura.io/v3/$PROJECT_ID',
    'Rinkeby': 'https://rinkeby.infura.io/v3/$PROJECT_ID',
    'Goerli': 'https://goerli.infura.io/v3/$PROJECT_ID',
    'Polygon Mainnet': 'https://polygon-mainnet.infura.io/v3/$PROJECT_ID',
    'Polygon Mumbai': 'https://polygon-mumbai.infura.io/v3/$PROJECT_ID',
    'Arbitrum Mainnet': 'https://arbitrum-mainnet.infura.io/v3/$PROJECT_ID',
    'Arbitrum Rinkeby': 'https://arbitrum-rinkeby.infura.io/v3/$PROJECT_ID',
    'Optimism Mainnet': 'https://optimism-mainnet.infura.io/v3/$PROJECT_ID',
    'Optimism Kovan': 'https://optimism-kovan.infura.io/v3/$PROJECT_ID'
  };
}

Future<Web3Client> initRPC(String net) async {
  Properties.initializedNetwork = Properties.NETWORKS.containsKey(net)
      ? Properties.NETWORKS[net]!
      : Properties.NETWORKS[Properties.DEFAULT_NETWORK]!;
  return Web3Client(Properties.initializedNetwork, Client());
}

Future<Box> initStorage() async {
  if (!kIsWeb) {
    Hive.init("data");
  }

  return Hive.openBox("box");
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initStorage().then((box) =>
      initRPC(box.get("network", defaultValue: Properties.DEFAULT_NETWORK))
          .then((rpc) => runApp(BlackVault(
                rpc: rpc,
                box: box,
              ))));
}

class BlackVault extends StatefulWidget {
  late final _BlackVaultState state;
  final Box box;
  final Web3Client rpc;

  BlackVault({Key? key, required this.box, required this.rpc})
      : super(key: key);

  @override
  _BlackVaultState createState() {
    state = _BlackVaultState();
    return state;
  }
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
          debugShowCheckedModeBanner: false,
          title: "Black Vault",
          darkTheme: ThemeData.dark().copyWith(
              tooltipTheme:
                  TooltipThemeData(triggerMode: TooltipTriggerMode.manual),
              appBarTheme: const AppBarTheme(
                  actionsIconTheme: IconThemeData(color: Colors.white60),
                  centerTitle: true,
                  iconTheme: IconThemeData(color: Colors.white60),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  titleTextStyle:
                      TextStyle(color: Colors.white60, fontSize: 42))),
          theme: ThemeData(
              tooltipTheme:
                  TooltipThemeData(triggerMode: TooltipTriggerMode.manual),
              appBarTheme: const AppBarTheme(
                  actionsIconTheme: IconThemeData(color: Colors.black38),
                  centerTitle: true,
                  iconTheme: IconThemeData(color: Colors.black38),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  titleTextStyle:
                      TextStyle(color: Colors.black38, fontSize: 42))),
          themeMode: widget.box.get("dark", defaultValue: false)
              ? ThemeMode.dark
              : ThemeMode.light,
          home: HomeScreen(),
        ),
      );
}

extension XBuildContext on BuildContext {
  Box box() => this.read<Box>();
  Web3Client rpc() => this.read<Web3Client>();
}
