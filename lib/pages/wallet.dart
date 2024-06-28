import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletStateScreen();
}

class _WalletStateScreen extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Wallet",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'BungeeSpice'
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              _scanQrcode();
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.qr_code_scanner,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: const Center(
          child: Icon(
            Icons.qr_code_2,
            color: Colors.white,
            size: 350,
          ),
        ),
      ),
    );
  }

  void _scanQrcode() {
    print("Opening camera to scan qrcode");
  }
}
