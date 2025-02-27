import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcornhub/presentation/journey/login/login_form.dart';
import 'package:popcornhub/presentation/widget/logo_widget.dart';

class LoginScreen extends StatelessWidget{
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(

    body: Center(
      child: Column(      
        children: [
        Padding(
          padding:  EdgeInsets.only(top: 60.h),
          child: LogoWidget(height: 60.h),
        ),
        LoginForm()
      
      ],),
    ),
   );
  }
}