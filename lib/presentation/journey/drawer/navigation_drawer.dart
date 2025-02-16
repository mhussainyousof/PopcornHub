import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcornhub/presentation/journey/drawer/navigation_expanded_list_item.dart';
import 'package:popcornhub/presentation/journey/drawer/navigation_list_item.dart';
import 'package:popcornhub/presentation/widget/logo_widget.dart';

class NavigationDrawerr extends StatelessWidget{
  const NavigationDrawerr({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            blurRadius: 4
          )
        ]
      ),
      width: 300.w,
      child: SafeArea(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Padding(padding: EdgeInsets.fromLTRB(8.h, 8.h, 8.h, 18.h),
        child: LogoWidget(height: 60.h),

        ),
        NavigationListItem(title: 'Favorite Movies',
        onPressed: (){},
        ),
        NavigationExpandedListItem(title: 'Language', children: ['English', 'Spanish'],
        onPressed: (){},
        ),
        NavigationListItem(title: 'Feedback',
        onPressed: (){},
        ),
        NavigationListItem(title: 'About',
        onPressed: (){},
        ),

      ],)),
    );
  }
}