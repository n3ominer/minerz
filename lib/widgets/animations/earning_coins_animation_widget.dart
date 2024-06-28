import 'package:flutter/material.dart';

class AnimatedText extends StatefulWidget {
  final VoidCallback onEnd;
  final int earningsPoints;
  const AnimatedText({Key? key, required this.onEnd, required this.earningsPoints})
      : super(key: key);

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, -1))
            .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward().then((_) {
      _controller.reverse().then((_) {
        widget.onEnd();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: Text(
          '+${widget.earningsPoints}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 41,
            fontFamily: 'Rye',
          ),
        ),
      ),
    );
  }
}
