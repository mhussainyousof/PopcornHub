import 'package:flutter/material.dart';
import 'package:popcornhub/presentation/journey/drawer/navigation_list_item.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';

class NavigationExpandedListItem extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final List<String> children;
  const NavigationExpandedListItem(
      {super.key, required this.title, this.onPressed, required this.children});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.7),
              blurRadius: 2),
        ]),
        child: ExpansionTile(
            iconColor: AppColor.royalBlue,
            collapsedIconColor: AppColor.royalBlue,
            title: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            children: children.map((child) {
              return NavigationSubListItem(
                title: child,
                onPressed: () {},
              );
            }).toList()
            //  [
            //   for (int i = 0; i < children.length; i++)
            //     NavigationSubListItem(
            //       title: children[i],
            //       onPressed: () {},
            //     )
            // ],
            ),
      ),
    );
  }
}
