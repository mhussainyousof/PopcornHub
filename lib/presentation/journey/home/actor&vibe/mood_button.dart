import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';

class MoodButton extends StatelessWidget {
  final String label;
  final String imageAsset;
  final int genreId;
  final Size size;
  final Function(String, int) onTap;

  const MoodButton({
    Key? key,
    required this.label,
    required this.imageAsset,
    required this.genreId,
    required this.size,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double buttonSize = size.width * 0.18;
    final Color moodColor = _getMoodColor(label);

    return GestureDetector(
      onTap: () => onTap(label, genreId),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Hero(
            tag: "mood_$label",
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: buttonSize,
                height: buttonSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: moodColor.withOpacity(0.4),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Lottie.asset(
                  imageAsset,
                  repeat: true,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: moodColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  Color _getMoodColor(String label) {
    switch (label) {
      case '🔥':
        return AppColor.softCoral;
      case '💔':
        return AppColor.deepPurple;
      case '😂':
        return AppColor.mintGreen;
      case '😱':
        return AppColor.electricBlue;
      case '🚀':
        return AppColor.electricBlue;
      default:
        return AppColor.coolGrey;
    }
  }
}
