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
    final themeMode = Theme.of(context).brightness;
    final isDark = themeMode == Brightness.dark;

    return Dialog(
      backgroundColor: isDark ? AppColor.richBlack : Colors.white, 
      elevation: 32,
      insetPadding: EdgeInsets.all(32),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColor.richBlack : Colors.white,
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black54 : Colors.grey.shade300, 
              blurRadius: 5,
            )
          ],
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title.t(context),
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: isDark ? Colors.white : Colors.black), 
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                description.t(context),
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: isDark ? Colors.white70 : Colors.black87), 
              ),
            ),
            SizedBox(height: 10.h),
            image,
            SizedBox(height: 10.h),
            Button(
              text: TranslationConstants.okay,
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
