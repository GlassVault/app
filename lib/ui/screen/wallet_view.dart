import 'package:black_vault/main.dart';
import 'package:black_vault/util/wallet_loader.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';

class WalletView extends StatefulWidget {
  final String walletKey;
  const WalletView({Key? key, required this.walletKey}) : super(key: key);

  @override
  _WalletViewState createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  Wallet? wallet;

  @override
  void initState() {
    wallet = WalletLoader.unlocked[widget.walletKey];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int pos = widget.walletKey.hashCode;
    Widget title = GradientText(
      (WalletLoader.loadWalletName(widget.walletKey).isEmpty
          ? (widget.walletKey.substring(0, 12) + "...")
          : (WalletLoader.loadWalletName(widget.walletKey))),
      gradient: RadialGradient(
          colors: Grad.sol, center: Alignment.bottomRight, radius: 11),
    );
    return Scaffold(
      body: DraggableHome(
          title: title,
          headerWidget: Stack(
            fit: StackFit.passthrough,
            children: [
              AppBar(),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GradientText(
                      (WalletLoader.loadWalletName(widget.walletKey).isEmpty
                          ? (widget.walletKey.substring(0, 12) + "...")
                          : (WalletLoader.loadWalletName(widget.walletKey))),
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
                      style: TextStyle(fontSize: 36),
                    ),
                    GradientIcon(
                      Icons.account_balance_wallet_rounded,
                      size: 128,
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
                    FutureBuilder<EtherAmount>(
                      future: context.rpc().getBalance(
                          EthereumAddress.fromHex(widget.walletKey)),
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
                ),
              )
            ],
          ),
          body: [
            ListView(
              shrinkWrap: true,
              children: [],
            )
          ]),
    );
  }
}
