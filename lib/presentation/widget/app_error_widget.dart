import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcornhub/common/constants/translation_constants.dart';
import 'package:popcornhub/common/extensions/string_extensions.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/presentation/widget/button.dart';
import 'package:wiredash/wiredash.dart';

class AppErrorWidget extends StatelessWidget {
  final AppErrorType errorType;
  final Function() onPressed;
  const AppErrorWidget( 
      {super.key, required this.errorType, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30,),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorType == AppErrorType.api
                ? TranslationConstants.somethingWentWrong.t(context)
                : TranslationConstants.checkNetwork.t(context),
                textAlign: TextAlign.center,
          ),
      
          OverflowBar(
            children: [
              Button(text: TranslationConstants.retry, onPressed: onPressed
               
              
              ),
              SizedBox(width: 10.w,),
              Button(text: TranslationConstants.feedback, onPressed: (){
                Wiredash.of(context).show();
              })
            ],
          )
      
        ],
      ),
    );
  }
}
