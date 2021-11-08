import 'dart:math';

import 'package:black_vault/main.dart';
import 'package:get/get.dart';
import 'package:web3dart/credentials.dart';

class WalletLoader {
  static Map<String, Wallet> unlocked = <String, Wallet>{};

  static void removeWallet(String key) {
    Get.context!.box().delete(key);
    Get.context!.box().delete("wallet-" + key);
    Get.context!.box().delete("wallet.name-" + key);
  }

  static List<String> listWallets() => Get.context!
      .box()
      .keys
      .map((e) => e.toString())
      .where((element) => element.toString().startsWith("wallet-"))
      .map((e) => e.replaceFirst("wallet-", ""))
      .toList(growable: false);

  static Wallet loadWallet(String address, String password) {
    Wallet w =
        Wallet.fromJson(Get.context!.box().get("wallet-" + address), password);
    unlocked[w.privateKey.address.hex] = w;
    return w;
  }

  static void saveWalletName(String key, String name) =>
      Get.context!.box().put("wallet.name-" + key, name);

  static String loadWalletName(String key) => Get.context!
      .box()
      .get("wallet.name-" + key, defaultValue: "Wallet " + key.substring(0, 4));

  static void saveWallet(Wallet w) {
    Get.context!.box().put("wallet-" + w.privateKey.address.hex, w.toJson());
    unlocked[w.privateKey.address.hex] = w;
  }

  static Future<Wallet> createWallet(String name, String password) async {
    Wallet w = Wallet.createNew(
        EthPrivateKey.createRandom(Random.secure()), password, Random.secure());
    WalletLoader.saveWalletName(w.privateKey.address.hex, name);
    WalletLoader.saveWallet(w);
    return w;
  }
}
