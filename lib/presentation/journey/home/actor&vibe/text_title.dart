import 'package:flutter/material.dart';

class TextTitle extends StatelessWidget {
  const TextTitle({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w800,
       
      ),
    );
  }
}

