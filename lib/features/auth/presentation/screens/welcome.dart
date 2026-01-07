import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_clean_portfolio_app/core/constants/extensions.dart';
import 'package:flutter_clean_portfolio_app/core/constants/images.dart';
import 'package:flutter_clean_portfolio_app/features/auth/presentation/screens/sign_in.dart';
import 'package:flutter_clean_portfolio_app/features/auth/presentation/screens/sign_up.dart';
import 'package:flutter_clean_portfolio_app/shared/primary_button.dart';
import 'package:flutter_clean_portfolio_app/shared/spacer.dart';

class Welcome extends StatefulWidget {
  static const String route = '/welcome';
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'welcome Back',
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              'Here you log in securely',
              style: context.textTheme.bodyMedium,
            ),
            const HeightGap(50),

            const Image(image: AppImages.welcome),
            const HeightGap(40),

            PrimaryButton(
              title: 'Sign in',
              onPressed: () => context.push(SignInScreen.route),
            ),
            const HeightGap(20),

            PrimaryButton(
              title: 'Sign up',
              onPressed: () => context.push(SignUpScreen.route),
            ),
          ],
        ),
      ),
    );
  }
}
