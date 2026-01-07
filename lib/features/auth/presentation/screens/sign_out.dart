import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_clean_portfolio_app/core/constants/color_block.dart';
import 'package:flutter_clean_portfolio_app/core/constants/constants.dart';
import 'package:flutter_clean_portfolio_app/core/utils/utils.dart';
import 'package:flutter_clean_portfolio_app/features/auth/presentation/screens/sign_up.dart';
import 'package:flutter_clean_portfolio_app/features/auth/presentation/viewmodel/sign_out_viewmodel.dart';
import 'package:flutter_clean_portfolio_app/shared/spacer.dart';

class SignOutScreen extends ConsumerWidget {
  static const String route = '/sign-out';

  const SignOutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signOutState = ref.watch(signOutViewModelProvider);

    return Scaffold(
      body: Padding(
        padding: paddingMedium,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Logout',
              style: TextStyle(
                color: ColorBlock.black,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            const HeightGap(250),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorBlock.fill,
                      border: Border.all(color: ColorBlock.grey, width: 0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        'Do you want to log out?',
                        style: TextStyle(
                          color: ColorBlock.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const HeightGap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: signOutState.isLoading
                          ? null
                          : () async {
                              final notifier =
                                  ref.read(signOutViewModelProvider.notifier);

                              await notifier.signOut();

                              if (notifier.state.hasError) {
                                showErrorMessage(
                                  context,
                                  message:
                                      notifier.state.error.toString(),
                                );
                              } else {
                                context.go(SignUpScreen.route);
                                showSuccessMessage(
                                  context,
                                  message: 'Signed out successfully',
                                );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorBlock.accent,
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: signOutState.isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Icon(
                              Icons.check_circle_outline,
                              size: 30,
                              color: ColorBlock.white,
                            ),
                    ),
                    const WidthGap(10),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
