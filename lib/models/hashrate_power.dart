import 'package:minerz/utils/string.dart';

class MinerHashratePower {
  int _hashrateBoosterLevel = 0;
  double _maxHashratePower = 2000;
  
  double _upgradeBoost = 250;
  double _boostMutliplicatorFactor = 0.1;
  
  double _upgradeToNextLevelCost = 1500;
  double _upgradeMultiplicatorFactor = 1.1;

  int _miningEarnings = 10;


  // Getters
  int get hashrateBoosterLevel => _hashrateBoosterLevel;
  int get miningEarnings => _miningEarnings;
  int get maxHashratePower => _maxHashratePower.round();
  int get upgradeToNextLevelCost => _upgradeToNextLevelCost.round();
  String get upgradeToNextLevelCostString => _formatUpgradeToNextLevelCost();


  void upgradeHashPower() {
    _hashrateBoosterLevel += 1;

    _upgradeMaxHashRatePower(); // Update the user's maximum hashrate
    _upgradeBoostValue(); // Next boost that will be bought

    _hashrateBoosterCostUpgrade(); // Next price to upgrade maximum hashrate power

    _upgradeHashrateMultiplicatorFactors();
    _upgradeMiningTapEarnings();
  }

  /// Number of coins earned for each tap
  void _upgradeMiningTapEarnings() {
    _miningEarnings += 1;
  }

  /// Functions to upgrade multiplicator factors that will upgrade boosts and upgrade boosts
  void _upgradeHashrateMultiplicatorFactors() {
    _boostMutliplicatorFactor += _boostMutliplicatorFactor / 10;
    _upgradeMultiplicatorFactor += 0.3;
  }

  void _upgradeMaxHashRatePower() {
    _maxHashratePower += _upgradeBoost;
  }

  /// Function to upgrade the price to upgrade the user's hashrate power for next level
  void _hashrateBoosterCostUpgrade() {
    _upgradeToNextLevelCost = _upgradeToNextLevelCost * _upgradeMultiplicatorFactor;
  }

  /// Function to update the boost that will be added the next time user wants to upgrade his maximum hashrate
  void _upgradeBoostValue() {
    _upgradeBoost += _upgradeBoost * _boostMutliplicatorFactor;
  }

  String _formatUpgradeToNextLevelCost() {
    double num = _upgradeToNextLevelCost;
    return integerValueFormattedToString(num);
  }

}