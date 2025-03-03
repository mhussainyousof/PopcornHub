import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcornhub/common/constants/route_constants.dart';
import 'package:popcornhub/common/constants/translation_constants.dart';
import 'package:popcornhub/common/extensions/string_extensions.dart';
import 'package:popcornhub/presentation/blocs/login/loging_bloc.dart';
import 'package:popcornhub/presentation/journey/login/lable_field_widget.dart';
import 'package:popcornhub/presentation/theme/theme_text.dart';
import 'package:popcornhub/presentation/widget/button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController _userNameController, _passwordController;
  late bool enableSignIn = false;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
    _userNameController.addListener(() {
      setState(() {
        enableSignIn = _userNameController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty;
      });
    });
    _passwordController.addListener(() {
      setState(() {
        enableSignIn = _userNameController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 30.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 30.h),
              child: Text(
                TranslationConstants.loginToMovieApp.t(context),
                // textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            LableFieldWidget(
                lable: TranslationConstants.username.t(context),
                hintText: TranslationConstants.enterTMDbUsername.t(context),
                controller: _userNameController),
            LableFieldWidget(
              lable: TranslationConstants.password.t(context),
              hintText: TranslationConstants.enterPassword.t(context),
              controller: _passwordController,
              isPasswordField: true,
            ),
            BlocConsumer<LoginBloc, LoginState>(
                buildWhen: (previous, current) => current is LoginError,
                builder: (context, state) {
                  if (state is LoginError) {
                    return Text(
                      state.message.t(context),
                      style: Theme.of(context).textTheme.orangeSubtitle1,
                    );
                  }
                  return SizedBox.shrink();
                },
                listenWhen: (previous, current) => current is LoginSuccess,
                listener: (context, state) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      RouteList.home, (route) => false);
                }),
            Button(
                isEnabled: true,
                text: TranslationConstants.signIn,
                onPressed: (){
                  Navigator.of(context).pushNamed(RouteList.home);
                }
                    )
          ],
        ),
      ),
    );
  }
}
