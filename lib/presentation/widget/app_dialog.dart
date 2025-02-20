import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcornhub/common/constants/translation_constants.dart';
import 'package:popcornhub/common/extensions/string_extensions.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';
import 'package:popcornhub/presentation/widget/button.dart';

class AppDialog extends StatelessWidget {
  final String title, description, buttonText;
  final Widget image;
  const AppDialog({
    super.key,
    required this.buttonText,
    required this.image,
    required this.title,
    required this.description,
  });
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.vulcan,
      elevation: 32,
      insetPadding: EdgeInsets.all(32),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
      
            boxShadow: [
              BoxShadow(
                color: AppColor.vulcan,
                blurRadius: 5
              )
            ]
          ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title.t(context),
            style: Theme.of(context).textTheme.titleLarge,
            
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text(description.t(context),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SizedBox(height: 10.h,),
            image,  
            Button(text: TranslationConstants.okay, onPressed: (){
              Navigator.of(context).pop();
            })
          ],
        ),
      ),
    );
  }
}

