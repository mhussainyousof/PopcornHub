import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:popcornhub/common/constants/translation_constants.dart';
import 'package:popcornhub/common/extensions/string_extensions.dart';
import 'package:popcornhub/data/di/get_it.dart';
import 'package:popcornhub/presentation/blocs/account/account_bloc.dart';
import 'package:popcornhub/presentation/journey/dashboard/dashboard_screen.dart';
import 'package:popcornhub/presentation/journey/explore/explore_cubit.dart';
import 'package:popcornhub/presentation/journey/explore/explore_screen.dart';
import 'package:popcornhub/presentation/journey/home/home_screen.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';




class NavigationHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NavigationCubit(),
        ),
        BlocProvider(
          create: (context) => AccountBloc(getAccountDetails: getItInstance())
            ..add(LoadAccountDetailsEvent()),
        )
      ],
      child: Scaffold(
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                    color: AppColor.richBlack.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: Offset(0, -2)),
              ],
            ),
            child: BlocBuilder<NavigationCubit, int>(
              builder: (context, currentIndex) {
                return ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  child: NavigationBar(
                    animationDuration: Duration(seconds: 1),
                    backgroundColor: Colors.transparent,
                    indicatorColor:
                        Theme.of(context).colorScheme.primary.withAlpha(26),
                    labelBehavior:
                        NavigationDestinationLabelBehavior.alwaysShow,
                    selectedIndex: currentIndex,
                    onDestinationSelected: (index) {
                      context.read<NavigationCubit>().updateIndex(index);
                    },
                    destinations: [
                      NavigationDestination(
                          selectedIcon: Icon(Iconsax.home, size: 27),
                          icon: Icon(Iconsax.home),
                          label: TranslationConstants.home.t(context)),
                      NavigationDestination(
                          selectedIcon: Icon(Iconsax.video_play, size: 27),
                          icon: Icon(Iconsax.video_play),
                          label: TranslationConstants.explore.t(context)),
                      NavigationDestination(
                          selectedIcon: Icon(Iconsax.menu_board, size: 27),
                          icon: Icon(Iconsax.menu_board),
                          label: TranslationConstants.dashboard.t(context)),
                    ],
                  ),
                );
              },
            ),
          ),
          body: BlocBuilder<NavigationCubit, int>(
            builder: (context, currentIndex) {
              return IndexedStack(index: currentIndex, children: [
                HomeScreen(),
                ExploreScreen(),
                DashboardScreen(),
              ]);
            },
          )),
    );
  }
}






