import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minerz/widgets/animations/earning_coins_animation_widget.dart';

class InvisibleCoinEarningGridItem extends StatefulWidget {
  final Function() clickAction;
  final int earningsPoints;
  final bool isHrPowerAvailable;

  const InvisibleCoinEarningGridItem({
    super.key,
    required this.earningsPoints,
    required this.clickAction,
    required this.isHrPowerAvailable
  });

  @override
  State<InvisibleCoinEarningGridItem> createState() => _InvisibleCoinEarningGridItemState();
}

class _InvisibleCoinEarningGridItemState extends State<InvisibleCoinEarningGridItem>
    with SingleTickerProviderStateMixin {
  final List<Widget> _textAnimations = [];

  void _handleTap() {
    HapticFeedback.heavyImpact();
    widget.clickAction();

    final animationKey = UniqueKey();
    final animationWidget = AnimatedText(
      key: animationKey,
      earningsPoints: widget.earningsPoints,
      onEnd: () {
        setState(() {
          _textAnimations.removeWhere((widget) => widget.key == animationKey);
        });
      },
    );

    setState(() {
      _textAnimations.add(animationWidget);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(widget.isHrPowerAvailable) {
          _handleTap();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          color: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: _textAnimations,
          ),
        ),
      ),
    );
  }
}