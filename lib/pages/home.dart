import 'dart:async';

import 'package:flutter/material.dart';
import 'package:minerz/models/hashrate_power.dart';
import 'package:minerz/models/miner.dart';
import 'package:minerz/widgets/coin.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  // Miner data
  Miner miner = Miner();
  late MinerHashratePower minerHashratePower;

  // Timer
  Timer? timer;

  @override
  void initState() {
    super.initState();
    minerHashratePower = miner.minerHashratePower;
    _setUpHashRateReloadTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _setUpHashRateReloadTimer() {
    timer = Timer.periodic(
      const Duration(milliseconds: 1200),
      (Timer t) => setState(() {
        if (miner.minerHashrate <
            minerHashratePower.maxHashratePower -
                minerHashratePower.miningEarnings) {
          miner.minerHashrate += minerHashratePower.miningEarnings;
          print(
              "Reloaded ${minerHashratePower.miningEarnings} to the hash power");
        } else {
          miner.minerHashrate = minerHashratePower.maxHashratePower;
          //timer?.cancel();
          print("Timer canceled");
        }

        if (miner.profitPerHour > 0) {
          miner.totalCoins += miner.profitPerHour / 3600;
        }
      }),
    );
  }

  void _consumeHashRate() {
    setState(() {
      if (miner.minerHashrate >= minerHashratePower.miningEarnings) {
        if (timer != null && !(timer!.isActive)) {
          _setUpHashRateReloadTimer();
          print("Timer restarted");
        }
        miner.minerHashrate -= minerHashratePower.miningEarnings;
        miner.totalCoins += minerHashratePower.miningEarnings;
      }
    });
  }

  void _upgradeMaxHashRate() {
    setState(() {
      if (miner.totalCoins >= minerHashratePower.upgradeToNextLevelCost) {
        miner.totalCoins -= minerHashratePower.upgradeToNextLevelCost;
        minerHashratePower.upgradeHashPower();
        miner.minerHashrate = minerHashratePower.maxHashratePower;
        miner.upgradePph(5000000);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              height: 35.0,
              width: 35.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(width: 1.0, color: Colors.white),
              ),
              child: const Icon(
                Icons.more_vert,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
        title: const Text(
          "Minerz",
          style: TextStyle(
            color: Colors.orange,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildMinerStatContainer(miner.profilIconUrl),
          _buildCoinsCounter(),
          GestureDetector(
            onTap: () => {_consumeHashRate()},
            child: const CoinWidget(
              coinHeight: 300.0,
              coinWidth: 300.0,
              borderWidth: 20,
              centerIconSize: 190,
            ),
          ),
          Padding(
            /// Hashrate bottom section
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: _buildBottomHashrate(),
          ),
          Container(
            /// Bottom separator between the views and the navigation bar
            height: 0.2,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Padding _buildMinerStatContainer(String minerProfilPictureUrl) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 70.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          border: Border.all(width: 0.2, color: Colors.white),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0.0, 1.0),
              blurRadius: 5.0,
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              /// Avatar widget
              padding: const EdgeInsets.only(left: 8.0, right: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(width: 0.5, color: Colors.white),
                  gradient: const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color.fromARGB(255, 28, 28, 28),
                      Color.fromARGB(255, 109, 108, 108),
                    ],
                  ),
                ),
                child: CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(minerProfilPictureUrl),
                ),
              ),
            ),
            Expanded(
              /// Player stats section
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        miner.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Row(
                        children: [
                          const CoinWidget(
                              coinHeight: 20.0,
                              coinWidth: 20.0,
                              borderWidth: 2,
                              centerIconSize: 13),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            miner.profitPerHourFormattedString,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Container(
                      child: IconButton(
                        icon: Image.asset("images/medaille.png"),
                        onPressed: () => {print("Display leagues")},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildCoinsCounter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CoinWidget(
          coinHeight: 30.0,
          coinWidth: 30.0,
          borderWidth: 3,
          centerIconSize: 17,
        ),
        const SizedBox(
          width: 16.0,
        ),
        Text(
          "${miner.totalCoins.round()}",
          style: const TextStyle(
            fontSize: 45,
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }

  Row _buildBottomHashrate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.bolt,
              size: 25.0,
              color: Colors.white,
            ),
            Text(
              "${miner.minerHashrate} / ${minerHashratePower.maxHashratePower}",
              style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => {_upgradeMaxHashRate()},
          child: _buildHashrateBoostWidget(),
        ),
      ],
    );
  }

  Column _buildHashrateBoostWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Level ${minerHashratePower.hashrateBoosterLevel}",
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w900, fontSize: 13.0),
        ),
        const SizedBox(
          height: 10,
        ),
        const Icon(
          Icons.rocket_launch,
          size: 40,
          color: Colors.white,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const CoinWidget(coinHeight: 15.0, coinWidth: 15.0, borderWidth: 1, centerIconSize: 12,),
            const SizedBox(width: 8,),
            Text(
              minerHashratePower.upgradeToNextLevelCostString,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 14,
              ),
            ),
          ],
        )
      ],
    );
  }
}
