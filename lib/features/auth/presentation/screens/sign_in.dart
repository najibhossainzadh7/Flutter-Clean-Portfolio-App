import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_portfolio_app/features/auth/presentation/provider/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_clean_portfolio_app/core/constants/extensions.dart';
import 'package:flutter_clean_portfolio_app/core/failure.dart';
import 'package:flutter_clean_portfolio_app/features/navigation/bottom_navigation.dart';
import 'package:flutter_clean_portfolio_app/shared/primary_button.dart';
import 'package:flutter_clean_portfolio_app/shared/spacer.dart';
import 'package:flutter_clean_portfolio_app/shared/text_input.dart';
import 'package:flutter_clean_portfolio_app/core/utils/utils.dart';

import 'sign_up.dart';
class SignInScreen extends ConsumerStatefulWidget {
  static const String route = '/sign-in';
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final signInState = ref.watch(signInProvider);

    ref.listen<AsyncValue<void>>(signInProvider, (_, state) {
      state.whenOrNull(
        data: (_) {
          context.go(BottomNavigation.route);
          showSuccessMessage(context, message: 'Login successfully!');
        },
        error: (err, _) {
          final msg = err is Failure ? err.message : err.toString();
          showErrorMessage(context, message: msg);
        },
      );
    });

    return WillPopScope(
      onWillPop: () async {
        context.go('/welcome');
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const HeightGap(150),
                  Text(
                    'Sign in',
                    style: context.textTheme.headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Sign in to your account',
                    style: context.textTheme.bodyMedium,
                  ),
                  const HeightGap(48),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextInput(
                          hintText: "Enter your email",
                          controller: _emailController,
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                        ),
                        const HeightGap(8),
                        TextInput(
                          hintText: "Enter your password",
                          controller: _passwordController,
                          obscureText: true,
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                        ),
                        const HeightGap(48),
                        PrimaryButton(
                          title: 'Sign in',
                          isLoading: signInState is AsyncLoading,
                          onPressed: _onSignInPressed,
                        ),
                      ],
                    ),
                  ),
                  const HeightGap(16),
                  Text.rich(
                    TextSpan(
                      text: 'or create a new ',
                      children: [
                        TextSpan(
                          text: 'account',
                          style: TextStyle(color: Colors.blue.shade500),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => context.go(SignUpScreen.route),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSignInPressed() {
    if (!_formKey.currentState!.validate()) {
      showWarningMessage(context, message: 'Please fill out the form');
      return;
    }

    ref.read(signInProvider.notifier).signIn(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
  }
}
