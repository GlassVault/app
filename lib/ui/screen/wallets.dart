import 'package:black_vault/main.dart';
import 'package:black_vault/ui/screen/add_wallet.dart';
import 'package:black_vault/ui/screen/drawer.dart';
import 'package:black_vault/ui/screen/wallet_view.dart';
import 'package:black_vault/util/wallet_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:gradient_ui_widgets/buttons/gradient_floating_action_button.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';

class WalletsScreen extends StatefulWidget {
  const WalletsScreen({Key? key}) : super(key: key);

  @override
  _WalletsScreenState createState() => _WalletsScreenState();
}

class _WalletsScreenState extends State<WalletsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    List<String> wallets = WalletLoader.listWallets();

    Future.delayed(Duration(milliseconds: 2000), () {
      List<String> wt = WalletLoader.listWallets();

      print("WTS = " +
          wt.length.toString() +
          " ORIGIN IS " +
          wallets.length.toString());

      if (wt.length != wallets.length) {
        setState(() {});
      }
    });

    return Scaffold(
      key: _scaffoldKey,
      drawer: VaultDrawer(),
      floatingActionButton: GradientFloatingActionButton.extended(
          onPressed: () =>
              Get.to(() => AddWallet(), transition: Transition.downToUp)
                  ?.then((value) => setState(() {})),
          label: Text("Add Wallet"),
          icon: Icon(Icons.add_rounded),
          gradient: RadialGradient(
              colors: Grad.sol, center: Alignment.topLeft, radius: 11)),
      primary: true,
      appBar: AppBar(
        leading: GradientIconButton(
          icon: Icon(Icons.menu),
          gradient: RadialGradient(
              colors: Grad.sol, radius: 1.2, center: Alignment.topLeft),
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
        ),
        title: GradientText(
          "Wallets",
          gradient: RadialGradient(
              colors: Grad.sol, center: Alignment.bottomRight, radius: 11),
        ),
      ),
      body: wallets.isEmpty
          ? Center(child: Text("Add a wallet to get started!"))
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300),
              itemBuilder: (context, pos) => GradientCard(
                gradient: RadialGradient(
                  colors: Grad.solFaint,
                  radius: 1.21 + (pos * 0.38 % 12),
                  center: pos % 4 == 0
                      ? Alignment.topRight
                      : pos % 4 == 1
                          ? Alignment.bottomRight
                          : pos % 4 == 2
                              ? Alignment.topLeft
                              : Alignment.bottomLeft,
                ),
                child: InkWell(
                  child: GridTile(
                    child: Center(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GradientIcon(
                          Icons.account_balance_wallet_rounded,
                          size: 69,
                          gradient: RadialGradient(
                              colors: Grad.sol,
                              center: pos % 4 == 0
                                  ? Alignment.topRight
                                  : pos % 4 == 1
                                      ? Alignment.bottomRight
                                      : pos % 4 == 2
                                          ? Alignment.topLeft
                                          : Alignment.bottomLeft,
                              radius: 1),
                        ),
                        GradientText(
                          WalletLoader.loadWalletName(wallets[pos]),
                          gradient: RadialGradient(
                              colors: Grad.sol,
                              center: pos % 4 == 0
                                  ? Alignment.bottomLeft
                                  : pos % 4 == 1
                                      ? Alignment.topLeft
                                      : pos % 4 == 2
                                          ? Alignment.bottomRight
                                          : Alignment.topRight,
                              radius: 3.25),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 36),
                        ),
                        FutureBuilder<EtherAmount>(
                          future: context.rpc().getBalance(
                              EthereumAddress.fromHex(wallets[pos])),
                          builder: (context, snap) {
                            if (!snap.hasData) {
                              return Container(
                                width: 20,
                                height: 20,
                                child: GradientCircularProgressIndicator(
                                    valueGradient: RadialGradient(
                                        colors: Grad.sol,
                                        radius: 1.7,
                                        center: Alignment.topLeft)),
                              );
                            }

                            return GradientText(
                              snap.data!.getInEther.toString() + " ETH",
                              style: TextStyle(fontSize: 24),
                              gradient: RadialGradient(
                                  colors: Grad.sol,
                                  center: pos % 4 == 0
                                      ? Alignment.topRight
                                      : pos % 4 == 1
                                          ? Alignment.bottomRight
                                          : pos % 4 == 2
                                              ? Alignment.topLeft
                                              : Alignment.bottomLeft,
                                  radius: 13.7),
                            );
                          },
                        )
                      ],
                    )),
                  ),
                  onTap: () => Get.to(() => WalletView(walletKey: wallets[pos]),
                          transition: Transition.downToUp)
                      ?.then((value) => setState(() {})),
                ),
              ),
              itemCount: wallets.length,
            ),
    );
  }
}
