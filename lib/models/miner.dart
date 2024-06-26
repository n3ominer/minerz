import 'package:minerz/models/hashrate_power.dart';
import 'package:minerz/models/minerz_level.dart';
import 'package:minerz/utils/string.dart';

class Miner {
  double _profitPerHour = 0;
  double totalCoins = 0;
  int minerHashrate = 2000;
  
  String _name = "Miner";
  String _profilIcon = "https://robohash.org/";
  
  MinerLevel _level = MinerLevel.newbie;  

  MinerHashratePower minerHashratePower = MinerHashratePower();


  // GETTERS
  double get  profitPerHour => _profitPerHour;
  String get  profitPerHourFormattedString => _getFormattedPph();

  String get totalCoinsFormattedString => _getFormattedTotalCoins();

  String get name => _name;
  String get profilIcon => _profilIcon;
  MinerLevel get level => _level;

  Miner() {
    _profilIcon += name;
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

}


