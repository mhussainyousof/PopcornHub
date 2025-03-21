import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:popcornhub/common/constants/languages.dart';
import 'package:popcornhub/common/constants/route_constants.dart';
import 'package:popcornhub/common/constants/translation_constants.dart';
import 'package:popcornhub/common/extensions/string_extensions.dart';
import 'package:popcornhub/data/core/api_constants.dart';
import 'package:popcornhub/data/domain/entity/account_entity.dart';
import 'package:popcornhub/presentation/blocs/account/account_bloc.dart';
import 'package:popcornhub/presentation/blocs/login/loging_bloc.dart';
import 'package:popcornhub/presentation/blocs/movie_language/language_bloc.dart';
import 'package:popcornhub/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';
import 'package:popcornhub/presentation/widget/app_dialog.dart';
import 'package:switcher_button/switcher_button.dart';




class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeBloc>().state;
    final themeBloc = context.read<ThemeBloc>();
    final languageBloc = context.read<LanguageBloc>();

    return Scaffold(
      appBar: AppBar(
        title:  Text(TranslationConstants.dashboard.t(context)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              if (state is AccountLoaded) {
                return _buildProfileSection(state.account);
              } else if (state is AccountLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AccountError) {
                return const Center(
                    child: Text('Error loading account details'));
              } else {
                return const Center(child: Text('Unknown state'));
              }
            },
          ),
          const SizedBox(height: 16),
          _buildFavoriteSection(context),
          const SizedBox(height: 16),
          _buildLanguageSwitcher(languageBloc),
          const SizedBox(height: 16),
          _buildAboutSection(context),
          const SizedBox(height: 16),
          _buildThemeSwitcher(themeMode, themeBloc),
          const SizedBox(height: 16),
          _buildLogoutSection(context),
        ],
      ),
    );
  }

  Widget _buildProfileSection(AccountEntity account) {
    return Card(
      child: ListTile(
        minTileHeight: 70,
        leading: ClipOval(
          child: CachedNetworkImage(
            imageUrl: '${ApiConstants.baseImageUrl}${account.avatarPath}',
            height: 60,
            width: 60,
            fit: BoxFit.cover,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) =>
                const Icon(Iconsax.profile_circle),
          ),
        ),
        title: Text(account.username),
      ),
    );
  }

  Widget _buildThemeSwitcher(ThemeMode themeMode, ThemeBloc themeBloc) {
    return Card(
      child: ListTile(
        leading: Icon(
          themeMode == ThemeMode.dark ? Iconsax.moon : Iconsax.sun_1,
          color: AppColor.electricBlue,
        ),
        title: Text(TranslationConstants.appTheme.t(context)),
        trailing: SwitcherButton(
          onColor: AppColor.mintGreen,
          offColor: Colors.grey.shade300,
          value: themeMode == ThemeMode.dark,
          size: 50,
          onChange: (value) {
            setState(() {
            });
            themeBloc.add(ToggleThemeEvent());
          },
        ),
      ),
    );
  }

  Widget _buildFavoriteSection(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Iconsax.gallery_export, color: Colors.redAccent),
        title:  Text(TranslationConstants.moviePicks.t(context)),
        onTap: () => Navigator.of(context).pushNamed(RouteList.favorite),
      ),
    );
  }

  Widget _buildLanguageSwitcher(LanguageBloc languageBloc) {
    return Card(
      child: ExpansionTile(
        leading: const Icon(Iconsax.global, color: AppColor.deepPurple),
        title:  Text(TranslationConstants.language.t(context)),
        children: Languages.languages.map((lang) {
          return ListTile(
            title: Text(lang.value),
            onTap: () => languageBloc.add(ToggleLanguageEvent(lang)),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Iconsax.info_circle, color: Colors.green),
        title:  Text(TranslationConstants.about.t(context)),
        onTap: () => _showAboutDialog(context),
      ),
    );
  }

  Widget _buildLogoutSection(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) => current is LogoutSuccess,
      listener: (context, state) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          RouteList.initial,
          (route) => false,
        );
      },
      child: Card(
        child: ListTile(
          leading: const Icon(Iconsax.logout, color: Colors.grey),
          title:  Text(TranslationConstants.logout.t(context)),
          onTap: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              RouteList.loginScreen,
              (route) => false,
            );
          },
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AppDialog(
          buttonText: TranslationConstants.okay,
          image: Image.asset('assets/pngs/tmdb_logo.png', scale: 1.5),
          title: TranslationConstants.about,
          description: TranslationConstants.aboutDescription,
        );
      },
    );
  }
}
