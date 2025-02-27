import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';
import 'package:popcornhub/presentation/theme/theme_text.dart';

class LableFieldWidget extends StatelessWidget {
  final String lable;
  final String hintText;
  final bool isPasswordField;
  final TextEditingController controller;
  final UnderlineInputBorder _enableBorder =
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey));

  final UnderlineInputBorder _focusBorder =
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.white));
  LableFieldWidget(
      {super.key,
      required this.lable,
      required this.hintText,
       this.isPasswordField = false,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
          lable.toUpperCase(),
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.start,
          ),
      
          TextField(
            obscureText: isPasswordField,
            obscuringCharacter: '*',
            controller: controller,
            cursorColor: AppColor.royalBlue,
            style:Theme.of(context).textTheme.titleMedium ,
            decoration: InputDecoration(
              hintText: hintText,
              
              hintStyle: Theme.of(context).textTheme.greySubtitle1,
              focusedBorder: _focusBorder,
              enabledBorder: _enableBorder
      
            ),
          )
        ],
      ),
    );
  }
}
