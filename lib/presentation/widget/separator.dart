import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';

class Separator extends StatelessWidget{
  const Separator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3.h,
      width: 80.w,
      padding: EdgeInsets.only(
        top: 2.h,
        bottom: 6.h
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1.r),
        gradient: LinearGradient(colors: [AppColor.royalBlue, AppColor.violet])
      ),
    );
    
    
  }
}