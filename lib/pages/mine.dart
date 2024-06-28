import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:minerz/models/mining/common_mining_card.dart';
import 'package:minerz/models/mining/mocks/blockchain_mining_cards_mocks.dart';
import 'package:minerz/models/mining/mocks/finance_mining_cards_mock.dart';
import 'package:minerz/models/mining/mocks/hardware_software_mining_cards_mock.dart';
import 'package:minerz/models/mining/mocks/special_mining_cards_mock.dart';
import 'package:minerz/models/mining/special_mining_card.dart';
import 'package:minerz/pages/btc_learning.dart';
import 'package:minerz/utils/string.dart';
import 'package:minerz/widgets/coin.dart';
import 'package:minerz/widgets/home/mining_sections_segmented_controler.dart';
import 'package:minerz/widgets/utils/timer.dart';

class MiningScreen extends StatefulWidget {
  const MiningScreen({super.key});

  @override
  State<MiningScreen> createState() => _MiningScreenState();
}

class _MiningScreenState extends State<MiningScreen> {
  late int currentScreen;
  late MiningSubject selectedSection;

  late List<CommonMiningCard> miningCards;

  late Timer dailyJackpotQuestsTimer;

  @override
  void initState() {
    super.initState();

    miningCards = blockchainCards;
    currentScreen = 0;
    selectedSection = MiningSubject.blockchain;
  }

  void _updateMinigCardsList(MiningSubject section) {
    int screenPos = 0;
    switch (section) {
      case MiningSubject.blockchain:
        miningCards = blockchainCards;
        screenPos = 0;
        selectedSection = MiningSubject.blockchain;
      case MiningSubject.it:
        miningCards = hardwareAndSoftwareCards;
        screenPos = 1;
        selectedSection = MiningSubject.it;
      case MiningSubject.finance:
        miningCards = financeCards;
        screenPos = 2;
        selectedSection = MiningSubject.finance;
      case MiningSubject.specials:
        miningCards = specialMiningCards;
        screenPos = 3;
        selectedSection = MiningSubject.specials;
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
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Mining",
          style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: 'BungeeSpice'),
        ),
      ),
      backgroundColor: Colors.black,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            _buildDailyJackpotQuestsContainer(),
            _buildQuestsRow(),
            MiningSectionController(
              callback: (screenPos) => setState(() {
                _updateMinigCardsList(screenPos);
              }),
            ),
            const SizedBox(height: 16.0),
            _buildMiningCardsGridScrollView(selectedSection)
          ],
        ),
      ),
    );
  }

  /// UI Widget building

  Padding _buildDailyJackpotQuestsContainer() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 28, 28, 28),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            const SizedBox(width: 8.0),
            const Icon(Icons.timer, color: Colors.white, size: 30.0),
            const SizedBox(width: 8.0),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Daily jackpot quests",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontFamily: 'PatuaOne',
                  ),
                ),
                CustomTimerWidget(),
              ],
            ),
            const Expanded(child: SizedBox()),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => {
                    showModalBottomSheet<void>(
                      isScrollControlled: true,
                      context: context,
                      backgroundColor: Colors.black,
                      builder: (BuildContext context) {
                        return _buildInfoBottomSheet();
                      },
                    ),
                    print("OUHOOOO")
                  },
                  child: const Icon(
                    Icons.info,
                    size: 20.0,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                const Row(
                  children: [
                    CoinWidget(
                      coinHeight: 15.0,
                      coinWidth: 15.0,
                      borderWidth: 1,
                      centerIconSize: 12.0,
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      "6,000,000",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontFamily: 'Rye',
                      ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(width: 8.0),
          ],
        ),
      ),
    );
  }

  Padding _buildQuestsRow() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 12.0,
        bottom: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          3,
          (index) => Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(
                    Random().nextInt(255),
                    Random().nextInt(255),
                    Random().nextInt(255),
                    Random().nextInt(255).toDouble(),
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    color: Colors.orange,
                    width: 3,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.question_mark,
                    size: 90.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildMiningCardsGridScrollView(MiningSubject selectedSection) {
    return Expanded(
      child: Container(
        color: Colors.black,
        child: GridView.count(
          childAspectRatio: 0.8,
          crossAxisCount: 2,
          children: List.generate(miningCards.length, (index) {
            CommonMiningCard card = miningCards[index];
            return selectedSection == MiningSubject.specials
                ? _buildGridCardCellForSpecialMiningCard(
                    card as SpecialMiningCard,
                    selectedSection,
                  )
                : _buildGridCardCellForCommonMiningCard(
                    card,
                    selectedSection,
                  );
          }),
        ),
      ),
    );
  }

  GestureDetector _buildGridCardCellForCommonMiningCard(
    CommonMiningCard card,
    MiningSubject selectedSection,
  ) {
    return GestureDetector(
      onTap: () => {
        if (!card.cardIsLocked) {_handleBottomSheetDisplay(card)}
      },
      child: _buildGridMiningCardCell(card),
    );
  }

  GestureDetector _buildGridCardCellForSpecialMiningCard(
    SpecialMiningCard card,
    MiningSubject selectedSection,
  ) {
    return GestureDetector(
      onTap: () => {
        if (!card.cardIsLocked) {_handleBottomSheetDisplay(card)}
      },
      child: _buildGridMiningCardCell(
        card,
        section: selectedSection,
        bgColor: card.backgroundColor!,
      ),
    );
  }

  Padding _buildGridMiningCardCell(
    CommonMiningCard card, {
    Color bgColor = const Color.fromARGB(255, 28, 28, 28),
    MiningSubject? section,
  }) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          color: section == null ? bgColor : null,
          gradient: section != null
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    bgColor,
                    bgColor.withAlpha(150),
                    bgColor.withAlpha(100),
                    Colors.black
                  ],
                )
              : null,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.white,
            width: 0.5,
          ),
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
                    color: const Color.fromARGB(255, 167, 167, 167),
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
            color: Colors.white,
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

  FractionallySizedBox _buildInfoBottomSheet() {
    return FractionallySizedBox(
      heightFactor: 0.5,
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
                height: 150.0,
                width: 150.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "images/satoshi_referal.jpeg",
                    cacheHeight: 500,
                    cacheWidth: 500,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  "You have daily quests to solve and 24h to earn 6,000,000 coins !! \n Learn about bitcoin and do some research to find the answers.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PatuaOne',
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const BitcoinLearningScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Container(
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Center(
                      child: Text(
                        "Let's go !",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontFamily: 'PatuaOne',
                        ),
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
