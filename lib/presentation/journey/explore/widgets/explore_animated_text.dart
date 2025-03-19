import 'package:flutter/material.dart';

class AnimatedText extends StatefulWidget {
  final String text;

  const AnimatedText({super.key, required this.text});

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true); // تکرار انیمیشن

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0.1, 0), // میزان لرزش
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.text.split("").map((char) {
          return Text(
            char,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
