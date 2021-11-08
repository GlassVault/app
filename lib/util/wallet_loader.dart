import 'dart:math';

import 'package:black_vault/main.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:web3dart/credentials.dart';

class WalletLoader {
  static Map<String, Wallet> unlocked = <String, Wallet>{};

  static void removeWallet(String key) => Get.context!.box().delete(key);

  static List<String> listWallets() => Get.context!
      .box()
      .keys
      .map((e) => e.toString())
      .where((element) => element.toString().startsWith("wallet-"))
      .map((e) => e.replaceFirst("wallet-", ""))
      .toList(growable: false);

  static Wallet loadWallet(String address, String password) =>
      Wallet.fromJson("wallet-" + Get.context!.box().get(address), password);

  static void saveWalletName(String key, String name) =>
      Get.context!.box().put("wallet.name-" + key, name);

  static String loadWalletName(String key) => Get.context!
      .box()
      .get("wallet.name-" + key, defaultValue: "Wallet " + key.substring(0, 4));

  static void saveWallet(Wallet w) =>
      Get.context!.box().put("wallet-" + w.privateKey.address.hex, w.toJson());

  static Future<Wallet> createWallet(String name, String password) async =>
      compute<List<String>, Wallet>((s) {
        Wallet w = Wallet.createNew(EthPrivateKey.createRandom(Random.secure()),
            password, Random.secure());
        WalletLoader.saveWalletName(w.privateKey.address.hex, name);
        WalletLoader.saveWallet(w);
        return w;
      }, <String>[name, password]);
}
