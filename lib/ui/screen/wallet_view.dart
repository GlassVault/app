import 'package:black_vault/main.dart';
import 'package:black_vault/util/wallet_loader.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/crypto.dart';
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

  void toggleLock() {
    if (wallet == null) {
      _asyncInputDialog(context).then((value) {
        try {
          Wallet w =
              WalletLoader.loadWallet(widget.walletKey, value.toString());
          setState(() {
            wallet = w;
          });

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Wallet Unlocked!")));
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Failed to Unlock. Incorrect Password?")));
        }
      });
    } else {
      WalletLoader.unlocked.remove(widget.walletKey);
      setState(() {
        wallet = null;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Wallet Locked!")));
    }
  }

  Future _asyncInputDialog(BuildContext context) async {
    String pw = '';
    return showDialog(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Wallet Password'),
          content: new Row(
            children: [
              new Expanded(
                  child: new TextField(
                autofocus: true,
                obscureText: true,
                decoration: new InputDecoration(labelText: 'Wallet Password'),
                onChanged: (value) {
                  pw = value;
                },
              ))
            ],
          ),
          actions: [
            TextButton(
              child: Text('Unlock'),
              onPressed: () {
                Navigator.of(context).pop(pw);
              },
            ),
          ],
        );
      },
    );
  }

  Future _confirm(BuildContext context, String f) async {
    String pw = '';
    return showDialog(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(f),
          content: Text("Are you sure?"),
          actions: [
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    wallet = WalletLoader.unlocked[widget.walletKey];
    int pos = widget.walletKey.hashCode;
    List<Widget> actions = <Widget>[
      GradientIconButton(
          icon: Icon(
              wallet == null ? Icons.lock_outlined : Icons.lock_open_rounded),
          onPressed: () => toggleLock(),
          gradient: RadialGradient(
              colors: Grad.sol,
              center: pos % 4 == 0
                  ? Alignment.bottomLeft
                  : pos % 4 == 1
                      ? Alignment.topLeft
                      : pos % 4 == 2
                          ? Alignment.bottomRight
                          : Alignment.topRight,
              radius: 1.95)),
      GradientIconButton(
          icon: Icon(Icons.qr_code_rounded),
          onPressed: () => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("NYI!"))),
          gradient: RadialGradient(
              colors: Grad.sol,
              center: pos % 4 == 0
                  ? Alignment.bottomLeft
                  : pos % 4 == 1
                      ? Alignment.topLeft
                      : pos % 4 == 2
                          ? Alignment.bottomRight
                          : Alignment.topRight,
              radius: 1.65)),
      Visibility(
        child: GradientIconButton(
            icon: Icon(Icons.send_outlined),
            onPressed: () => ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("NYI!"))),
            gradient: RadialGradient(
                colors: Grad.sol,
                center: pos % 4 == 0
                    ? Alignment.bottomLeft
                    : pos % 4 == 1
                        ? Alignment.topLeft
                        : pos % 4 == 2
                            ? Alignment.bottomRight
                            : Alignment.topRight,
                radius: 1.15)),
        visible: wallet != null,
      )
    ];
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
          actions: actions,
          headerWidget: Container(
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                AppBar(
                  actions: actions,
                ),
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
            decoration: BoxDecoration(
                gradient: RadialGradient(
                    colors: Grad.solFaint,
                    center: pos % 4 == 0
                        ? Alignment.topRight
                        : pos % 4 == 1
                            ? Alignment.bottomRight
                            : pos % 4 == 2
                                ? Alignment.topLeft
                                : Alignment.bottomLeft,
                    radius: 3.7)),
          ),
          body: [
            ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  leading: GradientIcon(
                    Icons.account_balance_wallet_rounded,
                    gradient: RadialGradient(
                        colors: Grad.sol,
                        center: pos % 4 == 0
                            ? Alignment.topRight
                            : pos % 4 == 1
                                ? Alignment.bottomRight
                                : pos % 4 == 2
                                    ? Alignment.topLeft
                                    : Alignment.bottomLeft,
                        radius: 1.7),
                  ),
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: widget.walletKey))
                        .then((value) =>
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Wallet Address copied!"),
                            )));
                  },
                  title: GradientText(
                    "Wallet Address",
                    gradient: RadialGradient(
                        colors: Grad.sol,
                        center: pos % 4 == 0
                            ? Alignment.topRight
                            : pos % 4 == 1
                                ? Alignment.bottomRight
                                : pos % 4 == 2
                                    ? Alignment.topLeft
                                    : Alignment.bottomLeft,
                        radius: 13),
                  ),
                  subtitle: GradientText(
                    widget.walletKey,
                    gradient: RadialGradient(
                        colors: Grad.sol,
                        center: pos % 4 == 0
                            ? Alignment.topRight
                            : pos % 4 == 1
                                ? Alignment.bottomRight
                                : pos % 4 == 2
                                    ? Alignment.topLeft
                                    : Alignment.bottomLeft,
                        radius: 16.7),
                  ),
                ),
                Visibility(
                  child: ListTile(
                    leading: GradientIcon(
                      Icons.save_rounded,
                      gradient: RadialGradient(
                          colors: Grad.sol,
                          center: pos % 4 == 0
                              ? Alignment.topRight
                              : pos % 4 == 1
                                  ? Alignment.bottomRight
                                  : pos % 4 == 2
                                      ? Alignment.topLeft
                                      : Alignment.bottomLeft,
                          radius: 1.7),
                    ),
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: wallet!.toJson()))
                          .then((value) => ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    Text("Wallet JSON Copied to Clipboard!"),
                              )));
                    },
                    title: GradientText(
                      "Export Wallet",
                      gradient: RadialGradient(
                          colors: Grad.sol,
                          center: pos % 4 == 0
                              ? Alignment.topRight
                              : pos % 4 == 1
                                  ? Alignment.bottomRight
                                  : pos % 4 == 2
                                      ? Alignment.topLeft
                                      : Alignment.bottomLeft,
                          radius: 13),
                    ),
                    subtitle: GradientText(
                      "Export this wallet to a JSON File (encrypted)",
                      gradient: RadialGradient(
                          colors: Grad.sol,
                          center: pos % 4 == 0
                              ? Alignment.topRight
                              : pos % 4 == 1
                                  ? Alignment.bottomRight
                                  : pos % 4 == 2
                                      ? Alignment.topLeft
                                      : Alignment.bottomLeft,
                          radius: 16.7),
                    ),
                  ),
                  visible: wallet != null,
                ),
                ExpansionTile(
                  leading: GradientIcon(
                    Icons.error_rounded,
                    gradient: RadialGradient(
                        colors: Grad.sol,
                        center: pos % 4 == 0
                            ? Alignment.topRight
                            : pos % 4 == 1
                                ? Alignment.bottomRight
                                : pos % 4 == 2
                                    ? Alignment.topLeft
                                    : Alignment.bottomLeft,
                        radius: 1.7),
                  ),
                  title: GradientText("Danger Zone",
                      gradient: RadialGradient(
                          colors: Grad.sol,
                          center: pos % 4 == 0
                              ? Alignment.topRight
                              : pos % 4 == 1
                                  ? Alignment.bottomRight
                                  : pos % 4 == 2
                                      ? Alignment.topLeft
                                      : Alignment.bottomLeft,
                          radius: 13)),
                  subtitle: GradientText(
                      "Tap to expose insecure & dangerous wallet options.",
                      gradient: RadialGradient(
                          colors: Grad.sol,
                          center: pos % 4 == 0
                              ? Alignment.topRight
                              : pos % 4 == 1
                                  ? Alignment.bottomRight
                                  : pos % 4 == 2
                                      ? Alignment.topLeft
                                      : Alignment.bottomLeft,
                          radius: 13)),
                  children: [
                    Visibility(
                      child: ListTile(
                        leading: GradientIcon(
                          Icons.vpn_key_rounded,
                          gradient: RadialGradient(
                              colors: Grad.sol,
                              center: pos % 4 == 0
                                  ? Alignment.topRight
                                  : pos % 4 == 1
                                      ? Alignment.bottomRight
                                      : pos % 4 == 2
                                          ? Alignment.topLeft
                                          : Alignment.bottomLeft,
                              radius: 1.7),
                        ),
                        onTap: () {
                          Clipboard.setData(ClipboardData(
                                  text: bytesToHex(
                                      wallet!.privateKey.privateKey,
                                      include0x: false)))
                              .then((value) => ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                        "Private Key Copied to Clipboard!"),
                                  )));
                        },
                        title: GradientText(
                          "Copy Private Key",
                          gradient: RadialGradient(
                              colors: Grad.sol,
                              center: pos % 4 == 0
                                  ? Alignment.topRight
                                  : pos % 4 == 1
                                      ? Alignment.bottomRight
                                      : pos % 4 == 2
                                          ? Alignment.topLeft
                                          : Alignment.bottomLeft,
                              radius: 13),
                        ),
                        subtitle: GradientText(
                          "Copies the unencrypted private key (not secure)",
                          gradient: RadialGradient(
                              colors: Grad.sol,
                              center: pos % 4 == 0
                                  ? Alignment.topRight
                                  : pos % 4 == 1
                                      ? Alignment.bottomRight
                                      : pos % 4 == 2
                                          ? Alignment.topLeft
                                          : Alignment.bottomLeft,
                              radius: 16.7),
                        ),
                      ),
                      visible: wallet != null,
                    ),
                    ListTile(
                      leading: GradientIcon(
                        Icons.delete_rounded,
                        gradient: RadialGradient(
                            colors: Grad.sol,
                            center: pos % 4 == 0
                                ? Alignment.topRight
                                : pos % 4 == 1
                                    ? Alignment.bottomRight
                                    : pos % 4 == 2
                                        ? Alignment.topLeft
                                        : Alignment.bottomLeft,
                            radius: 1.7),
                      ),
                      onTap: () {
                        String w =
                            WalletLoader.loadWalletName(widget.walletKey);
                        _confirm(context, "Delete Wallet '$w'?").then((value) {
                          if (value) {
                            WalletLoader.removeWallet(widget.walletKey);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Removed Wallet '$w'"),
                              duration: Duration(milliseconds: 750),
                            ));
                            Navigator.pop(context);
                          }
                        });
                      },
                      title: GradientText(
                        "Delete Wallet",
                        gradient: RadialGradient(
                            colors: Grad.sol,
                            center: pos % 4 == 0
                                ? Alignment.topRight
                                : pos % 4 == 1
                                    ? Alignment.bottomRight
                                    : pos % 4 == 2
                                        ? Alignment.topLeft
                                        : Alignment.bottomLeft,
                            radius: 13),
                      ),
                      subtitle: GradientText(
                        "Remove this wallet from Black Valut",
                        gradient: RadialGradient(
                            colors: Grad.sol,
                            center: pos % 4 == 0
                                ? Alignment.topRight
                                : pos % 4 == 1
                                    ? Alignment.bottomRight
                                    : pos % 4 == 2
                                        ? Alignment.topLeft
                                        : Alignment.bottomLeft,
                            radius: 16.7),
                      ),
                    )
                  ],
                )
              ],
            )
          ]),
    );
  }
}
