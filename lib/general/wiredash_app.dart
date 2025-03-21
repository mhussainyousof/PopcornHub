import 'package:flutter/material.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';
import 'package:wiredash/wiredash.dart';

class WiredashApp extends StatelessWidget {
  final navigatorKey;
  final Widget child;
  final String languageCode;
  const WiredashApp({super.key, this.navigatorKey, required this.child,
  required this.languageCode
  });

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      options: WiredashOptionsData(
        locale: Locale.fromSubtags(languageCode: languageCode)
      ),
      projectId: 'movieF-app-tutorial-fwraxig',
      secret: 'geVkONpyWg-ywH2nLYFnVk2xukNBv1BH',
      theme: WiredashThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColor.charcoalGrey,
        secondaryColor: AppColor.pureWhite,
        secondaryBackgroundColor: AppColor.richBlack,
       
      ),
      child: child,
    );
  }
}
