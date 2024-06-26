import 'dart:async';

import 'package:flutter/material.dart';
import 'package:minerz/models/hashrate_power.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  // Total coins
  int totalCoins = 21000000;
  int minerHashrate = 2000;

  MinerHashratePower minerHashratePower = MinerHashratePower();

  Timer? timer;

  @override
  void initState() {
    super.initState();
    minerHashrate = minerHashratePower.maxHashratePower;
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
        if (minerHashrate < minerHashratePower.maxHashratePower - 10) {
          minerHashrate += 10;
          print("Reloaded 10 to the hash power");
        } else {
          minerHashrate = minerHashratePower.maxHashratePower;
          timer?.cancel();
          print("Timer canceled");
        }
      }),
    );
  }

  void _consumeHashRate() {
    setState(() {
      if (minerHashrate >= 10) {
        if (timer != null && !(timer!.isActive)) {
          _setUpHashRateReloadTimer();
          print("Timer restarted");
        }
        minerHashrate -= 10;
        totalCoins += 10;
      }
    });
  }

  void _upgradeMaxHashRate() {
    setState(() {
      if (totalCoins >= minerHashratePower.upgradeToNextLevelCost) {
        totalCoins -= minerHashratePower.upgradeToNextLevelCost;
        minerHashratePower.upgradeHashPower();
        minerHashrate = minerHashratePower.maxHashratePower;
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
          _buildMinerStatContainre(),
          _buildCoinsCounter(),
          GestureDetector(
            onTap: () => {_consumeHashRate()},
            child: _buildCoinTapContainer(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: _buildBottomHashrate(),
          )
        ],
      ),
    );
  }

  Padding _buildMinerStatContainre() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 70.0,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(40.0),
        ),
      ),
    );
  }

  Row _buildCoinsCounter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 30.0,
          width: 30.0,
          decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(
                width: 0.8,
                color: Colors.red,
              )),
        ),
        const SizedBox(
          width: 16.0,
        ),
        Text(
          "$totalCoins",
          style: const TextStyle(
            fontSize: 45,
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }

  Container _buildCoinTapContainer() {
    return Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200.0),
          color: const Color.fromARGB(95, 255, 235, 59),
          border: Border.all(width: 20, color: Colors.yellow)),
      child: const Icon(
        //Icons.currency_bitcoin,
        Icons.add,
        size: 190,
      ),
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
              "$minerHashrate / ${minerHashratePower.maxHashratePower}",
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
          "Level ${minerHashratePower.tapLevel}",
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
        Text(
          minerHashratePower.upgradeToNextLevelCostString,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16),
        ),
      ],
    );
  }
}
