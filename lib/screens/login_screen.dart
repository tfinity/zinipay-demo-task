import 'package:flutter/material.dart';
import 'package:zini_pay_demo/core/colors.dart';
import 'package:zini_pay_demo/core/extensions.dart';
import 'package:zini_pay_demo/core/router.dart';
import 'package:zini_pay_demo/core/strings.dart';
import 'package:zini_pay_demo/core/typography.dart';
import 'package:zini_pay_demo/screens/home_screen.dart';
import 'package:zini_pay_demo/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _apiKey = '';

  bool _isLoading = false;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      toggleLoading();
      bool success = await AuthService.login(_email, _apiKey);
      if (success) {
        await AuthService.setLoggedIn();
        AppRouter.navigateTo(const HomeScreen());
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(Strings.loginFailed)),
        );
      }
      toggleLoading();
    }
  }

  void toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/login.png',
              height: 348,
            ),
            14.0.height,
            Text(
              Strings.login,
              style: AppTypography.h1,
            ),
            32.0.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(Strings.email, style: AppTypography.medium),
                  8.0.height,
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: Strings.exampleEmail,
                    ),
                    validator: (value) {
                      return value!.isEmpty ? 'Please enter your email' : null;
                    },
                    onSaved: (value) => _email = value!,
                  ),
                  16.0.height,
                  Text(Strings.apiKey, style: AppTypography.medium),
                  8.0.height,
                  TextFormField(
                    obscureText: true,
                    validator: (value) {
                      return value!.isEmpty
                          ? 'Please enter your API key'
                          : null;
                    },
                    onSaved: (value) => _apiKey = value!,
                  ),
                  32.0.height,
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        backgroundColor: AppColors.primary,
                      ),
                      onPressed: _login,
                      child: _isLoading
                          ? const SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                color: AppColors.white,
                                strokeWidth: 3,
                              ),
                            )
                          : Text(
                              Strings.login,
                              style: AppTypography.medium
                                  .copyWith(color: AppColors.silver),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
