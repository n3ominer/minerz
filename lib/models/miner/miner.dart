import 'package:minerz/models/miner/hashrate_power.dart';
import 'package:minerz/models/miner/minerz_level.dart';
import 'package:minerz/utils/string.dart';

class Miner {
  double _profitPerHour = 0;
  double totalCoins = 2000;
  int minerHashrate = 2000;
  
  String _name = "Holder ₿";
  String _profilIconUrl = "https://robohash.org/";
  
  MinerLevel _level = MinerLevel.newbie;  

  MinerHashratePower minerHashratePower = MinerHashratePower();


  // GETTERS
  double get  profitPerHour => _profitPerHour;
  String get  profitPerHourFormattedString => _getFormattedPph();

  String get totalCoinsFormattedString => _getFormattedTotalCoins();

  String get name => _name;
  String get profilIconUrl => _profilIconUrl;
  MinerLevel get level => _level;

  Miner() {
    _profilIconUrl += name;
    minerHashrate = minerHashratePower.maxHashratePower;
  }

  // Formatting functions
  String _getFormattedPph() {
    double num = _profitPerHour;
    return integerValueFormattedToString(num);
  }

  String _getFormattedTotalCoins() {
    return integerValueFormattedToString(totalCoins);
  }

  void upgradePph(int coins) {
    _profitPerHour += coins;
  }

}


