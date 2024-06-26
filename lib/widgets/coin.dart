import 'package:flutter/material.dart';

class CoinWidget extends StatelessWidget {
  final double coinHeight;
  final double coinWidth;
  final double borderWidth;
  final double centerIconSize;

  const CoinWidget({
    required this.coinHeight,
    required this.coinWidth,
    required this.borderWidth,
    required this.centerIconSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: coinHeight,
      width: coinWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200.0),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          colors: [
            Colors.yellow,
            Color.fromRGBO(188, 136, 4, 0.9),
          ],
        ),
        border: Border.all(
          width: borderWidth,
          color: Colors.yellow,
        ),
      ),
      child: Icon(
        //Icons.currency_bitcoin,
        Icons.diamond_rounded,
        size: centerIconSize,
      ),
    );
  }
}