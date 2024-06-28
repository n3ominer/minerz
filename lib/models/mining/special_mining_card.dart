import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:minerz/models/mining/common_mining_card.dart';

class SpecialMiningCard extends CommonMiningCard {
  bool isPerishable = false;
  bool isFinished = false;
  int availabilityToBOwnedTimer = 0;
  Color? backgroundColor;

  SpecialMiningCard(
    String id,
    String cardTitle,
    String cardDescription,
    double cardTotalPph,
    int cardLevel,
    double cardUpgradeCost,
    double upgradePph,
    String cardIcon,
    bool cardIsLocked,
    String nextUpgradeTimer,
    bool hasTimer,
  {
    Color this.backgroundColor = const Color.fromARGB(255, 28, 28, 28),
    required this.isPerishable,
    required this.isFinished,
    required this.availabilityToBOwnedTimer,
  }) :
   super(
    id: id,
    cardTitle: cardTitle, 
    cardDescription: cardDescription, 
    cardTotalPph: cardTotalPph,
    cardLevel: cardLevel,
    cardUpgradeCost: cardUpgradeCost,
    upgradePph: upgradePph, 
    cardIcon: cardIcon, 
    cardIsLocked: cardIsLocked,
    nextUpgradeTimer: nextUpgradeTimer, 
    hasTimer: hasTimer
  );

}