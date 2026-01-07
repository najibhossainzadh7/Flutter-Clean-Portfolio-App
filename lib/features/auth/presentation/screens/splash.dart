import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_clean_portfolio_app/core/constants/color_block.dart';
import 'package:flutter_clean_portfolio_app/core/constants/images.dart';
import 'package:flutter_clean_portfolio_app/features/auth/presentation/screens/welcome.dart';
import 'package:flutter_clean_portfolio_app/features/navigation/bottom_navigation.dart';

import 'package:flutter_clean_portfolio_app/shared/spacer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  static const String route = '/splash';

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateNext();
  }

  Future<void> _navigateNext() async {
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final isLoggedIn = token != null && token.isNotEmpty;

    if (isLoggedIn) {
      context.go(BottomNavigation.route);
    } else {
      context.go(Welcome.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 16, 5, 47),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [_buildLogoSection(context), const HeightGap(20)],
            ),
          ],
        ),
      ),
    );
  }

  Align _buildLogoSection(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 50),
            child: CircleAvatar(
              backgroundImage: AppImages.logo,
              radius: 70,
              backgroundColor: Color.fromARGB(255, 16, 5, 47),
            ),
          ),
          const HeightGap(320),
          Text(
            'Task-Manager',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: ColorBlock.white,
            ),
          ),
        ],
      ),
    );
  }
}
