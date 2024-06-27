class CommonMiningCard {
  String id;
  String cardTitle;
  String cardDescription;
  double cardTotalPph;
  int cardLevel;
  double cardUpgradeCost;
  double upgradePph;
  String cardIcon;
  bool cardIsLocked;
  String nextUpgradeTimer;
  bool hasTimer = false;
  CommonMiningCard? linkedCard;
  int? linkedCardPosition;


  CommonMiningCard({
    required this.id,
    required this.cardTitle,
    required this.cardDescription,
    required this.cardTotalPph,
    required this.cardLevel,
    required this.cardUpgradeCost,
    required this.upgradePph,
    required this.cardIcon,
    required this.cardIsLocked,
    required this.nextUpgradeTimer,
    required this.hasTimer,
  });
}