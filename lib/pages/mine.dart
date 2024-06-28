import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minerz/models/mining/common_mining_card.dart';
import 'package:minerz/models/mining/mocks/blockchain_mining_cards_mocks.dart';
import 'package:minerz/models/mining/mocks/finance_mining_cards_mock.dart';
import 'package:minerz/models/mining/mocks/hardware_software_mining_cards_mock.dart';
import 'package:minerz/models/mining/mocks/special_mining_cards_mock.dart';
import 'package:minerz/utils/string.dart';
import 'package:minerz/widgets/coin.dart';

class MiningScreen extends StatefulWidget {
  const MiningScreen({super.key});

  @override
  State<MiningScreen> createState() => _MiningScreenState();
}

class _MiningScreenState extends State<MiningScreen> {
  late int currentScreen;

  late List<CommonMiningCard> miningCards;

  @override
  void initState() {
    super.initState();

    miningCards = blockchainCards;
    currentScreen = 0;
  }

  void _updateMinigCardsList(int screenPos) {
    switch (screenPos) {
      case 0:
        miningCards = blockchainCards;
      case 1:
        miningCards = hardwareAndSoftwareCards;
      case 2:
        miningCards = financeCards;
      case 3:
        miningCards = specialMiningCards;
      default:
        miningCards = [];
    }
    currentScreen = screenPos;
  }

  void _handleBottomSheetDisplay(CommonMiningCard card) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.black,
      builder: (BuildContext context) {
        return _buildMinigCardDescriptionBottomSheet(card);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            _buildSegmentedController(),
            _buildMiningCardsGridScrollView()
          ],
        ),
      ),
    );
  }

  /// UI Widget building

  Container _buildSegmentedController() {
    return Container(
      height: 70.0,
      color: Colors.black,
      child: _buildSegmentedControl(
        (screenPos) => setState(
          () {
            _updateMinigCardsList(screenPos);
            print("Current state position $currentScreen");
          },
        ),
        currentScreen,
      ),
    );
  }

  Expanded _buildMiningCardsGridScrollView() {
    return Expanded(
      child: Container(
        color: Colors.black,
        child: GridView.count(
          childAspectRatio: 0.8,
          crossAxisCount: 2,
          children: List.generate(miningCards.length, (index) {
            CommonMiningCard card = miningCards[index];
            return GestureDetector(
              onTap: () => {
                if (!card.cardIsLocked) {_handleBottomSheetDisplay(card)}
              },
              child: _buildGridMiningCardCell(card),
            );
          }),
        ),
      ),
    );
  }

  Padding _buildGridMiningCardCell(CommonMiningCard card) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 28, 28, 28),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildMiningCardIcon(card),

            /// Card title name
            Text(
              card.cardTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'BungeeSpice',
              ),
            ),

            /// Pph + upgrade to be earned section
            _buildMiningCardProfitToEarnInfos(card),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                height: 0.3,
                color: Colors.grey,
              ),
            ),

            /// Level + upgrade cost section
            _buildMiningCardLevelPlusUpgradeCostSection(card),
          ],
        ),
      ),
    );
  }

  CupertinoSegmentedControl _buildSegmentedControl(
      Function(int) callback, int screen) {
    return CupertinoSegmentedControl(
      onValueChanged: (value) => callback(value as int),
      groupValue: screen,
      children: const {
        0: SizedBox(
          height: 50,
          child: Center(
            child: Text(
              "Blockchain",
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        1: SizedBox(
          height: 40.0,
          child: Center(
            child: Text(
              "IT & Technical",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        2: SizedBox(
          height: 40.0,
          child: Center(
            child: Text(
              "Finance",
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        3: SizedBox(
          height: 40.0,
          child: Center(
            child: Text(
              "Specials",
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      },
    );
  }

  Stack _buildMiningCardIcon(CommonMiningCard card) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(18.0),
          child: ImageFiltered(
            enabled: card.cardIsLocked,
            imageFilter: ImageFilter.blur(
              sigmaX: 6,
              sigmaY: 6,
            ),
            child: Stack(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'images/btc_light.png',
                    image: 'https://robohash.org/${Random().nextInt(10)}',
                  ),
                ),
              ],
            ),
          ),
        ),
        card.cardIsLocked
            ? const CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.white,
                child: Icon(Icons.lock),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Row _buildMiningCardProfitToEarnInfos(CommonMiningCard card) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Profit/h",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        const CoinWidget(
            coinHeight: 15, coinWidth: 15, borderWidth: 2, centerIconSize: 10),
        const SizedBox(
          width: 4,
        ),
        Text(
          "+${integerValueFormattedToString(card.upgradePph.round())}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Rye',
          ),
        ),
      ],
    );
  }

  SizedBox _buildMiningCardLevelPlusUpgradeCostSection(CommonMiningCard card) {
    return SizedBox(
      height: 70.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Level ${card.cardLevel}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: Container(
              width: 0.3,
              color: Colors.grey,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CoinWidget(
                  coinHeight: 15,
                  coinWidth: 15,
                  borderWidth: 2,
                  centerIconSize: 10),
              const SizedBox(
                width: 4,
              ),
              Text(
                "+${integerValueFormattedToString(card.cardUpgradeCost.round())}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rye',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  FractionallySizedBox _buildMinigCardDescriptionBottomSheet(
      CommonMiningCard card) {
    return FractionallySizedBox(
      heightFactor: 0.7,
      widthFactor: 1,
      child: SafeArea(
        bottom: true,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 158, 158, 158),
              width: 0.7,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Image.asset("images/youtube.png"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  card.cardTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'BungeeSpice',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 24.0),
                child: Text(
                  card.cardDescription,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontFamily: 'PatuaOne',
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Profit per hour",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Rye',
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CoinWidget(
                        coinHeight: 15,
                        coinWidth: 15,
                        borderWidth: 1,
                        centerIconSize: 12,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        "${card.upgradePph}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Rye',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CoinWidget(
                      coinHeight: 40,
                      coinWidth: 40,
                      borderWidth: 4.5,
                      centerIconSize: 23),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    "${card.cardUpgradeCost}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 45.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Rye',
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Container(
                  height: 70.0,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Center(
                    child: Text(
                      "Invest !",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PatuaOne',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
