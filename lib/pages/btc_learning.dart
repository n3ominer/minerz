import 'package:flutter/material.dart';

class BitcoinLearningScreen extends StatefulWidget {
  const BitcoinLearningScreen({super.key});

  @override
  State<BitcoinLearningScreen> createState() => _WalletStateScreen();
}

class _WalletStateScreen extends State<BitcoinLearningScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Learning",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'BungeeSpice'
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: const Center(
          child: Icon(
            Icons.book,
            color: Colors.white,
            size: 350,
          ),
        ),
      ),
    );
  }
}
