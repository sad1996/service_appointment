import 'package:flutter/material.dart';

class AnimatedEmoji extends StatefulWidget {
  @override
  _AnimatedEmojiState createState() => _AnimatedEmojiState();
}

class _AnimatedEmojiState extends State<AnimatedEmoji>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        lowerBound: 0,
        upperBound: 1,
        duration: Duration(milliseconds: 1500));
    _controller.addListener(() => setState(() {}));
    _controller.forward();
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Stack(
        children: <Widget>[
          Image.asset('assets/icons/head.png'),
          Positioned(
            bottom: 26,
            right: 20,
            left: 20,
            child: Opacity(
              opacity: _controller.value,
              child: Image.asset('assets/icons/smile.png'),
            ),
          )
        ],
      ),
    );
  }
}
