import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcornhub/common/extensions/string_extensions.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';
import 'package:popcornhub/presentation/theme/theme_text.dart';

class TabTitleWidget extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final bool isSelected;
  const TabTitleWidget({
    super.key,
    required this.title,
    required this.onTap,
    required this.isSelected,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 15.h),
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
                bottom: BorderSide(
              color: isSelected ? AppColor.charcoalGrey : Colors.transparent,
            ))),
        child: Text(
          title.t(context),
            style: isSelected
                ? Theme.of(context).textTheme.royalBlueSubtitle1
                : Theme.of(context).textTheme.greySubtitle1),
      ),
    );
  }
}
