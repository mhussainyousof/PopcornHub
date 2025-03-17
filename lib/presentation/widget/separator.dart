import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';

class Separator extends StatelessWidget{
  const Separator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
     margin: EdgeInsets.only(top: 4.h,bottom: 4.h),
      height: 2.h,
      width: 80.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1.r),
        gradient: LinearGradient(colors: [AppColor.charcoalGrey, AppColor.pureWhite])
      ),
    );
    
    
  }
}