import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';

class NavigationListItem extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const NavigationListItem({
    super.key,
    required this.title,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: AppColor.richBlack.withOpacity(0.7),
              blurRadius: 2),
        ]),
        child: ListTile(
          title: Text(
            title,
             style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class NavigationSubListItem extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const NavigationSubListItem({
    super.key,
    required this.title,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: AppColor.richBlack.withOpacity(0.7),
              blurRadius: 2),
        ]),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 32.w),
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
