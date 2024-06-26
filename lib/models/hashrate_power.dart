class MinerHashratePower {
  int _tapLevel = 0;
  double _maxHashratePower = 2000;
  
  double _upgradeBoost = 250;
  double _boostMutliplicatorFactor = 0.1;
  
  double _upgradeToNextLevelCost = 1500;
  double _upgradeMultiplicatorFactor = 1.1;


  // Getters
  int get tapLevel => _tapLevel;
  int get maxHashratePower => _maxHashratePower.round();
  int get upgradeToNextLevelCost => _upgradeToNextLevelCost.round();
  String get upgradeToNextLevelCostString => _formatUpgradeToNextLevelCost();


  void upgradeHashPower() {
    _tapLevel += 1;

    _maxHashratePower += _upgradeBoost;
    _upgradeBoost += _upgradeBoost * _boostMutliplicatorFactor;
    _boostMutliplicatorFactor += _boostMutliplicatorFactor / 10;

    _upgradeToNextLevelCost = _upgradeToNextLevelCost * _upgradeMultiplicatorFactor;
    _upgradeMultiplicatorFactor += 0.3;
  }

  String _formatUpgradeToNextLevelCost() {
    double num = _upgradeToNextLevelCost;
    if (num > 999 && num < 99999) {
        return "${(num / 1000).toStringAsFixed(1)} K";
      } else if (num > 99999 && num < 999999) {
        return "${(num / 1000).toStringAsFixed(0)} K";
      } else if (num > 999999 && num < 999999999) {
        return "${(num / 1000000).toStringAsFixed(1)} M";
      } else if (num > 999999999) {
        return "${(num / 1000000000).toStringAsFixed(1)} B";
      } else {
        return num.toString();
      }
  }

}