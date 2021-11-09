import 'package:intl/intl.dart';
import 'package:web3dart/web3dart.dart';

class SmartValue {
  static String getSmartValue(EtherAmount amout) {
    NumberFormat f = NumberFormat();
    num v = amout.getValueInUnit(EtherUnit.ether);
    if (v >= 0.001) {
      return "${f.format(v)} ETH";
    }
    v = amout.getValueInUnit(EtherUnit.gwei).round();
    if (v > 1) {
      return "${f.format(v)} GWEI";
    }
    v = amout.getValueInUnit(EtherUnit.mwei).round();
    if (v > 1) {
      return "${f.format(v)} MWEI";
    }
    v = amout.getValueInUnit(EtherUnit.kwei).round();
    if (v > 1) {
      return "${f.format(v)} KWEI";
    }
    v = amout.getValueInUnit(EtherUnit.wei).round();
    if (v > 1) {
      return "${f.format(v)} WEI";
    }

    return "0 ETH";
  }
}
