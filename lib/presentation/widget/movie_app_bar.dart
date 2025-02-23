import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:popcornhub/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:popcornhub/presentation/journey/search_movie/custom_search_movie_delegate.dart';
import 'package:popcornhub/presentation/widget/logo_widget.dart';

class MovieAppBar extends StatelessWidget {
  const MovieAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: ScreenUtil().statusBarHeight + 4.h,
        left: 16.w,
        right: 16.w,
      ),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: SvgPicture.asset(
                'assets/svgs/menu.svg',
                height: 30.h,
              )),
          Expanded(child: LogoWidget(height: 29.h)),
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate(BlocProvider.of<SearchMovieBloc>(context)));
              },
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: 30.h,
              ))
        ],
      ),
    );
  }
}
