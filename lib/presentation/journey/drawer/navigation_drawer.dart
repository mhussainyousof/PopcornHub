import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcornhub/common/constants/route_constants.dart';
import 'package:popcornhub/presentation/blocs/login/loging_bloc.dart';
import 'package:popcornhub/presentation/widget/app_dialog.dart';
import 'package:wiredash/wiredash.dart';
import 'package:popcornhub/common/constants/languages.dart';
import 'package:popcornhub/common/constants/translation_constants.dart';
import 'package:popcornhub/common/extensions/string_extensions.dart';
import 'package:popcornhub/presentation/blocs/movie_language/language_bloc.dart';
import 'package:popcornhub/presentation/journey/drawer/navigation_expanded_list_item.dart';
import 'package:popcornhub/presentation/journey/drawer/navigation_list_item.dart';
import 'package:popcornhub/presentation/widget/logo_widget.dart';

class NavigationDrawerr extends StatelessWidget {
  const NavigationDrawerr({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            blurRadius: 4)
      ]),
      width: 300.w,
      child: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(8.h, 8.h, 8.h, 18.h),
            child: LogoWidget(height: 60.h),
          ),
          NavigationListItem(
            title: TranslationConstants.favoriteMovies.t(context),
            onPressed: () {
              Navigator.of(context).pushNamed(RouteList.favorite);
              // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> FavoriteScreen()));
            },
          ),
          NavigationExpandedListItem(
            title: TranslationConstants.language.t(context),
            children: Languages.languages.map((e) => e.value).toList(),
            onPressed: (index) {
              BlocProvider.of<LanguageBloc>(context).add(
                ToggleLanguageEvent(Languages.languages[index]),
              );
            },
          ),
          NavigationListItem(
            title: TranslationConstants.feedback.t(context),
            onPressed: () {
              Navigator.of(context).pop();
              Wiredash.of(context).show();
            },
          ),
          NavigationListItem(
            title: TranslationConstants.about.t(context),
            onPressed: () {
              Navigator.of(context).pop();
              _showDialog2(context);
            },
          ),
          BlocListener<LoginBloc, LoginState>(
            listenWhen: (previous, current)=> current is LogoutSuccess,
            listener: (context, state) {
              Navigator.of(context).pushNamedAndRemoveUntil(RouteList.initial, (route)=> false);
            },
            child: NavigationListItem(
              title: TranslationConstants.logout.t(context),
              onPressed: () {
                BlocProvider.of<LoginBloc>(context).add(LogoutEvent());
              },
            ),
          ),
        ],
      )),
    );
  }

  void _showDialog2(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AppDialog(
            buttonText: TranslationConstants.okay,
            image: Image.asset(
              'assets/pngs/tmdb_logo.png',
              scale: 1.5,
            ),
            title: TranslationConstants.about,
            description: TranslationConstants.aboutDescription);
      },
    );
  }
}
