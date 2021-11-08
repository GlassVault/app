import 'dart:convert';

import 'package:black_vault/main.dart';
import 'package:black_vault/util/wallet_loader.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart';
import 'package:web3dart/credentials.dart';

class AddWallet extends StatefulWidget {
  const AddWallet({Key? key}) : super(key: key);

  @override
  _AddWalletState createState() => _AddWalletState();
}

class _AddWalletState extends State<AddWallet> {
  late PageController controller;
  int choice = 0;
  late TextEditingController tc;
  late TextEditingController tc2;
  late TextEditingController tc3;

  @override
  void initState() {
    tc = TextEditingController();
    tc2 = TextEditingController();
    tc3 = TextEditingController();
    controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: GradientText(
              "Add Wallet",
              gradient: RadialGradient(
                  colors: Grad.sol, radius: 6.25, center: Alignment.topRight),
            ),
          ),
          body: PageView(
            pageSnapping: true,
            physics: NeverScrollableScrollPhysics(),
            controller: controller,
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 350),
                  child: GradientCard(
                    gradient: RadialGradient(
                        colors: Grad.solFaint,
                        radius: 1.6,
                        center: Alignment(0, 1.5)),
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      children: [
                        GridTileGrad(
                          icon: Icons.inbox_rounded,
                          text: "Import Wallet File",
                          callback: () {
                            setState(() {
                              choice = 0;
                              Future.delayed(
                                  Duration(milliseconds: 100),
                                  () => controller.nextPage(
                                      duration: Duration(milliseconds: 750),
                                      curve: Curves.easeOutExpo));
                            });
                          },
                        ),
                        GridTileGrad(
                          icon: Icons.featured_play_list_rounded,
                          text: "Recovery Phrase",
                          callback: () {
                            setState(() {
                              choice = 1;
                              Future.delayed(
                                  Duration(milliseconds: 100),
                                  () => controller.nextPage(
                                      duration: Duration(milliseconds: 750),
                                      curve: Curves.easeOutExpo));
                            });
                          },
                        ),
                        GridTileGrad(
                          icon: Icons.password_rounded,
                          text: "Private Key",
                          callback: () {
                            setState(() {
                              choice = 2;
                              Future.delayed(
                                  Duration(milliseconds: 100),
                                  () => controller.nextPage(
                                      duration: Duration(milliseconds: 750),
                                      curve: Curves.easeOutExpo));
                            });
                          },
                        ),
                        GridTileGrad(
                          icon: Icons.add,
                          text: "Create Wallet",
                          callback: () {
                            setState(() {
                              choice = 3;
                              Future.delayed(
                                  Duration(milliseconds: 100),
                                  () => controller.nextPage(
                                      duration: Duration(milliseconds: 750),
                                      curve: Curves.easeOutExpo));
                            });
                          },
                        ),
                      ],
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ),
                ),
              ),
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 350),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GradientIconButton(
                            icon: Icon(Icons.arrow_back_ios_rounded),
                            onPressed: () => controller.previousPage(
                                duration: Duration(milliseconds: 750),
                                curve: Curves.easeInOutExpo),
                            gradient: RadialGradient(
                                colors: Grad.sol,
                                radius: 1.25,
                                center: Alignment.topRight)),
                      ),
                      GradientCard(
                        gradient: RadialGradient(
                            colors: Grad.solFaint,
                            radius: 2.6,
                            center: Alignment(1.2, 0.8)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(14),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 7),
                                    child: GradientIcon(
                                        choice == 0
                                            ? Icons.inbox_rounded
                                            : choice == 1
                                                ? Icons
                                                    .featured_play_list_rounded
                                                : choice == 2
                                                    ? Icons.password_rounded
                                                    : Icons.add,
                                        size: 36,
                                        gradient: RadialGradient(
                                            colors: Grad.sol,
                                            center: Alignment.topRight,
                                            radius: 2)),
                                  ),
                                  GradientText(
                                    choice == 0
                                        ? "Import Wallet File"
                                        : choice == 1
                                            ? "Enter Recovery Phrase"
                                            : choice == 2
                                                ? "Enter Private Key"
                                                : "Create New Wallet",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 24),
                                    gradient: RadialGradient(
                                        colors: Grad.sol,
                                        center: Alignment.bottomLeft,
                                        radius: 11),
                                  )
                                ],
                              ),
                            ),
                            choice == 0
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                        TextField(
                                          controller: tc,
                                          decoration: InputDecoration(
                                              hintText: "Nickname"),
                                        ),
                                        TextField(
                                          controller: tc2,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                              hintText: "Wallet Password"),
                                        ),
                                        GradientElevatedButton.icon(
                                            onPressed: () {
                                              FilePicker.platform
                                                  .pickFiles()
                                                  .then((r) {
                                                Wallet w = Wallet.fromJson(
                                                    utf8.decode(
                                                        r!.files.single.bytes!),
                                                    tc2.value.text);
                                                WalletLoader.saveWallet(w);
                                                WalletLoader.saveWalletName(
                                                    w.privateKey.address.hex,
                                                    tc.value.text);
                                              });
                                            },
                                            gradient: RadialGradient(
                                                colors: Grad.sol,
                                                center: Alignment.bottomLeft,
                                                radius: 11),
                                            icon: Icon(Icons.upload_rounded),
                                            label: Text("Choose File"))
                                      ])
                                : choice == 1
                                    ? Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            controller: tc,
                                            decoration: InputDecoration(
                                                hintText:
                                                    "Enter Recovery Phrase"),
                                            maxLines: 5,
                                            minLines: 3,
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 7),
                                              child:
                                                  GradientElevatedButton.icon(
                                                      onPressed: () {},
                                                      gradient: RadialGradient(
                                                          colors: Grad.sol,
                                                          center: Alignment
                                                              .bottomLeft,
                                                          radius: 11),
                                                      icon: Icon(Icons.check),
                                                      label: Text(
                                                          "Import Wallet")),
                                            ),
                                          )
                                        ],
                                      )
                                    : choice == 2
                                        ? Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextField(
                                                controller: tc,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "Enter Private Key"),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 7),
                                                  child: GradientElevatedButton
                                                      .icon(
                                                          onPressed: () {},
                                                          gradient: RadialGradient(
                                                              colors: Grad.sol,
                                                              center: Alignment
                                                                  .bottomLeft,
                                                              radius: 11),
                                                          icon:
                                                              Icon(Icons.check),
                                                          label: Text(
                                                              "Import Wallet")),
                                                ),
                                              )
                                            ],
                                          )
                                        : choice == 3
                                            ? Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextField(
                                                    controller: tc,
                                                    decoration: InputDecoration(
                                                        hintText: "Nickname"),
                                                  ),
                                                  TextField(
                                                    controller: tc2,
                                                    obscureText: true,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            "Wallet Password"),
                                                  ),
                                                  TextField(
                                                    controller: tc3,
                                                    obscureText: true,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            "Confirm Password"),
                                                  ),
                                                  GradientElevatedButton.icon(
                                                      onPressed: () {
                                                        if (tc2.value.text ==
                                                            tc3.value.text) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  SnackBar(
                                                            duration: Duration(
                                                                hours: 24),
                                                            content: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                GradientCircularProgressIndicator(
                                                                    valueGradient: RadialGradient(
                                                                        colors: Grad
                                                                            .sol,
                                                                        radius:
                                                                            0.7,
                                                                        center:
                                                                            Alignment.topRight)),
                                                                GradientText(
                                                                  " Creating Wallet '" +
                                                                      tc.value
                                                                          .text +
                                                                      "'...",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          24),
                                                                  gradient: RadialGradient(
                                                                      colors: Grad
                                                                          .sol,
                                                                      radius:
                                                                          2.7,
                                                                      center: Alignment
                                                                          .bottomLeft),
                                                                )
                                                              ],
                                                            ),
                                                          ));
                                                          Future.delayed(
                                                              Duration(
                                                                  milliseconds:
                                                                      750),
                                                              () => WalletLoader.createWallet(
                                                                      tc.value
                                                                          .text,
                                                                      tc2.value
                                                                          .text)
                                                                  .then((value) =>
                                                                      setState(
                                                                          () {
                                                                        ScaffoldMessenger.of(context)
                                                                            .hideCurrentSnackBar();
                                                                      }))).then(
                                                              (value) =>
                                                                  Navigator.pop(
                                                                      context));
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  SnackBar(
                                                            content: Text(
                                                                "Passwords do not match!"),
                                                          ));
                                                        }
                                                      },
                                                      gradient: RadialGradient(
                                                          colors: Grad.sol,
                                                          center: Alignment
                                                              .bottomLeft,
                                                          radius: 11),
                                                      icon: Icon(Icons.check),
                                                      label:
                                                          Text("Create Wallet"))
                                                ],
                                              )
                                            : Container()
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        onWillPop: () async {
          if (controller.page! > 0) {
            controller.previousPage(
                duration: Duration(milliseconds: 750),
                curve: Curves.easeInOutExpo);
            return false;
          }

          return true;
        });
  }
}

class GridTileGrad extends StatelessWidget {
  final String text;
  final IconData icon;
  final GestureTapCallback? callback;
  const GridTileGrad(
      {Key? key, required this.text, required this.icon, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Center(
          child: Column(
        children: [
          GradientIcon(icon,
              size: 48,
              gradient: RadialGradient(
                  colors: Grad.sol, center: Alignment.topRight, radius: 2)),
          Padding(
            padding: EdgeInsets.only(top: 14),
            child: GradientText(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
              gradient: RadialGradient(
                  colors: Grad.sol, center: Alignment.bottomLeft, radius: 11),
            ),
          )
        ],
        mainAxisSize: MainAxisSize.min,
      )),
      onTap: callback,
    );
  }
}
