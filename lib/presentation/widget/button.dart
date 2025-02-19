// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcornhub/common/extensions/string_extensions.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';

class Button extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  const Button({
    super.key,
    required this.text,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
  
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColor.royalBlue, AppColor.violet]),
        borderRadius: BorderRadius.circular(30.r),
        
      ),
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      margin: EdgeInsets.symmetric(vertical: 30.h),
      height: 50.h,
      child: TextButton(onPressed: onPressed,
      child: Text(text.t(context),
      style: Theme.of(context).textTheme.bodyMedium,
      ),
      ),
    );

  }
}
