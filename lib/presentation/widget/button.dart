import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcornhub/common/extensions/string_extensions.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';

class Button extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final bool isEnabled;
  
  const Button({
    super.key,
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient:
              LinearGradient(
                colors: isEnabled ? (Theme.of(context).brightness == Brightness.dark ?  [AppColor.charcoalGrey, AppColor.deepPurple] : [AppColor.mintGreen.withAlpha(100), AppColor.deepPurple] ): [Colors.grey, Colors.grey.shade400],
              ),

        borderRadius: BorderRadius.circular(30.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      margin: EdgeInsets.symmetric(vertical: 30.h),
      height: 50.h,
      child: TextButton(
        onPressed: isEnabled ? onPressed : null,
        child: Text(
          text.t(context),
          style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),
        ),
      ),
    );
  }
}
