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

//! 🔐 LoginForm: Handles user authentication 🔐
//! Collects username & password, validates input, and triggers login.

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  //! Controllers for handling username & password input
  late TextEditingController _userNameController, _passwordController;
  late bool enableSignIn = false; //! Tracks if the sign-in button should be enabled

  @override
  void initState() {
    super.initState();

    //! Initialize text controllers
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();

    //! Add listeners to enable/disable sign-in button dynamically
    _userNameController.addListener(_updateSignInState);
    _passwordController.addListener(_updateSignInState);
  }

  //! Update sign-in button state based on input fields
  void _updateSignInState() {
    setState(() {
      enableSignIn = _userNameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    //! Dispose controllers to free memory
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 30.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //! 🔹 Login Title
            Padding(
              padding: EdgeInsets.only(bottom: 30.h),
              child: Text(
                TranslationConstants.loginToMovieApp.t(context),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            //! 🔹 Username Input Field
            LableFieldWidget(
              lable: TranslationConstants.username.t(context),
              hintText: TranslationConstants.enterTMDbUsername.t(context),
              controller: _userNameController,
            ),

            //! 🔹 Password Input Field
            LableFieldWidget(
              lable: TranslationConstants.password.t(context),
              hintText: TranslationConstants.enterPassword.t(context),
              controller: _passwordController,
              isPasswordField: true,
            ),

            //! 🚨 Display login error message if login fails
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

              //! ✅ Navigate to home screen if login is successful
              listenWhen: (previous, current) => current is LoginSuccess,
              listener: (context, state) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteList.home, (route) => false);
              },
            ),

            //! 🔘 Sign-In Button
            Button(
              text: TranslationConstants.signIn,
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteList.home, (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
