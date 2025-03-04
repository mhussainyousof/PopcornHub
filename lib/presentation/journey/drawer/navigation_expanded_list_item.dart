import 'package:flutter/material.dart';
import 'package:popcornhub/presentation/journey/drawer/navigation_list_item.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';

class NavigationExpandedListItem extends StatelessWidget {
  final String title;
  final void Function(int index)? onPressed;
  final List<String> children;

  const NavigationExpandedListItem({
    super.key,
    required this.title,
    this.onPressed,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: AppColor.vulcan.withOpacity(0.7),
          blurRadius: 2,
        ),
      ]),
      child: ExpansionTile(
        iconColor: AppColor.royalBlue,
        collapsedIconColor: AppColor.royalBlue,
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),
        ),
        children: children.asMap().entries.map((entry) {
          final index = entry.key;
          final child = entry.value;
          return NavigationSubListItem(
            title: child,
            onPressed: () => onPressed?.call(index),
          );
        }).toList(),
      ),
    );
  }
}

