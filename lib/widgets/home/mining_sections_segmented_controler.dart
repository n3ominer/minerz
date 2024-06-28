import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';

enum MiningSubject { blockchain, it, finance, specials }

class MiningSectionController extends StatefulWidget {
  final Function(MiningSubject) callback;

  const MiningSectionController({super.key, required this.callback});

  @override
  State<MiningSectionController> createState() =>
      _MiningSectionControllerState();
}

class _MiningSectionControllerState extends State<MiningSectionController> {
  MiningSubject miningSection = MiningSubject.blockchain;

  @override
  Widget build(BuildContext context) {
    return CustomSlidingSegmentedControl<int>(
      initialValue: 0,
      isShowDivider: true,
      dividerSettings: const DividerSettings(
        indent: 5,
        endIndent: 5,
        thickness: 0.2,
        isHideAutomatically: true,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
      ),
      children: const {
        0: Text(
          'Blockchain',
          style: TextStyle(
              fontSize: 15.0, fontFamily: 'PatuaOne', color: Colors.white),
        ),
        1: Text(
          'IT & Tech',
          style: TextStyle(
              fontSize: 15.0, fontFamily: 'PatuaOne', color: Colors.white),
        ),
        2: Text(
          'Finance',
          style: TextStyle(
              fontSize: 15.0, fontFamily: 'PatuaOne', color: Colors.white),
        ),
        3: Text(
          'Specials',
          style: TextStyle(
              fontSize: 15.0, fontFamily: 'PatuaOne', color: Colors.white),
        ),
      },
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 62, 62, 62),
        borderRadius: BorderRadius.circular(8),
      ),
      thumbDecoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [
          BoxShadow(
            color: Colors.red,
            blurRadius: 4.0,
            spreadRadius: 1.0,
            offset: Offset(
              0.0,
              2.0,
            ),
          ),
        ],
      ),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInToLinear,
      onValueChanged: (section) {
        switch (section) {
          case 0:
            widget.callback(MiningSubject.blockchain);
          case 1:
            widget.callback(MiningSubject.it);
          case 2:
            widget.callback(MiningSubject.finance);
          case 3:
            widget.callback(MiningSubject.specials);
          default:
            widget.callback(MiningSubject.blockchain);
        }
      },
    );
  }
}