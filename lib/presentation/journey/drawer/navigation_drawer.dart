// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:popcornhub/common/constants/route_constants.dart';
// import 'package:popcornhub/presentation/blocs/login/loging_bloc.dart';
// import 'package:popcornhub/presentation/blocs/theme_bloc/theme_bloc.dart';
// import 'package:popcornhub/presentation/theme/app_color.dart';
// import 'package:popcornhub/presentation/journey/dashboard/widget/app_dialog.dart';
// import 'package:wiredash/wiredash.dart';
// import 'package:popcornhub/common/constants/languages.dart';
// import 'package:popcornhub/common/constants/translation_constants.dart';
// import 'package:popcornhub/common/extensions/string_extensions.dart';
// import 'package:popcornhub/presentation/blocs/movie_language/language_bloc.dart';
// import 'package:popcornhub/presentation/journey/drawer/navigation_expanded_list_item.dart';
// import 'package:popcornhub/presentation/journey/drawer/navigation_list_item.dart';
// import 'package:popcornhub/presentation/widget/logo_widget.dart';

// //! This is the big boss drawer! Opens up, shows options, and does magic.
// class NavigationDrawerr extends StatelessWidget {
//   const NavigationDrawerr({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final themeMode = context.watch<ThemeBloc>().state;
//     final themeBloc = context.read<ThemeBloc>();

//     return Container(
//       //! Adding some shadow because plain drawers are boring
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: AppColor.richBlack.withOpacity(0.9),
//             blurRadius: 4,
//           )
//         ],
//       ),
//       width: 300.w,
//       child: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             //! The first row: Logo + The Mighty Theme Switcher ⚡️
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(8.h, 8.h, 8.h, 18.h),
//                   child: LogoWidget(height: 60.h),
//                 ),
//                 //! This button changes the entire vibe of the app 🌙☀️
//                 Padding(
//                   padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
//                   child: GestureDetector(
//                     onTap: () {
//                       themeBloc.add(ToggleThemeEvent());
//                     },
//                     child: AnimatedSwitcher(
//                       duration: const Duration(milliseconds: 300),
//                       transitionBuilder: (child, animation) {
//                         return ScaleTransition(scale: animation, child: child);
//                       },
//                       child: Icon(
//                         themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
//                         key: ValueKey(themeMode),
//                         color: Colors.white,
//                         size: 25.sp,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             //! Here’s where you can keep your favorite movies 🎬
//             NavigationListItem(
//               title: TranslationConstants.favoriteMovies.t(context),
//               onPressed: () {
//                 Navigator.of(context).pushNamed(RouteList.favorite);
//               },
//             ),

//             //! This button makes your app multilingual 🌍
//             NavigationExpandedListItem(
//               title: TranslationConstants.language.t(context),
//               children: Languages.languages.map((e) => e.value).toList(),
//               onPressed: (index) {
//                 BlocProvider.of<LanguageBloc>(context).add(
//                   ToggleLanguageEvent(Languages.languages[index]),
//                 );
//               },
//             ),

//             //! Who doesn’t love feedback? This button opens the doors 📢
//             NavigationListItem(
//               title: TranslationConstants.feedback.t(context),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 Wiredash.of(context).show();
//               },
//             ),

//             //! Just in case someone wonders "who made this awesome app?" 🤔
//             NavigationListItem(
//               title: TranslationConstants.about.t(context),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _showDialog2(context);
//               },
//             ),

//             //! The final button... Logout... But are you sure you want to leave? 😢
//             BlocListener<LoginBloc, LoginState>(
//               listenWhen: (previous, current) => current is LogoutSuccess,
//               listener: (context, state) {
//                 Navigator.of(context)
//                     .pushNamedAndRemoveUntil(RouteList.initial, (route) => false);
//               },
//               child: NavigationListItem(
//                 title: TranslationConstants.logout.t(context),
//                 onPressed: () {
//                   Navigator.of(context).pushNamedAndRemoveUntil(RouteList.loginScreen, (route) => false);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   //! This little function pops up the "About" section because curiosity is good! 🕵️‍♂️
//   void _showDialog2(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AppDialog(
//           buttonText: TranslationConstants.okay,
//           image: Image.asset(
//             'assets/pngs/tmdb_logo.png',
//             scale: 1.5,
//           ),
//           title: TranslationConstants.about,
//           description: TranslationConstants.aboutDescription,
//         );
//       },
//     );
//   }
// }


