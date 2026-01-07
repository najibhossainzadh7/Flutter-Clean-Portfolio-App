import 'package:flutter/material.dart';
import 'package:flutter_clean_portfolio_app/features/auth/presentation/provider/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_clean_portfolio_app/core/constants/constants.dart';
import 'package:flutter_clean_portfolio_app/core/constants/extensions.dart';
import 'package:flutter_clean_portfolio_app/core/utils/utils.dart';
import 'package:flutter_clean_portfolio_app/features/auth/presentation/screens/sign_up.dart';
import 'package:flutter_clean_portfolio_app/features/auth/presentation/widgets/custom_select_tile.dart';
import 'package:flutter_clean_portfolio_app/shared/primary_button.dart';
import 'package:flutter_clean_portfolio_app/shared/spacer.dart';

class UserTypeScreen extends ConsumerStatefulWidget {
  static const String route = '/user-type';

  const UserTypeScreen({super.key});

  @override
  ConsumerState<UserTypeScreen> createState() => _UserTypeState();
}

class _UserTypeState extends ConsumerState<UserTypeScreen> {
  String? selectedType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingHorizontalMedium,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const HeightGap(70),
              Text(
                'What\'s Your Field?',
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Choose your area to get started',
                style: context.textTheme.bodyMedium,
              ),
              const HeightGap(48),

              CustomSelectTileWidget(
                title: 'Front-end Developer',
                leadingIcon: Icons.check_circle_outline,
                isSelected: selectedType == 'Front-end Developer',
                onTap: () {
                  setState(() {
                    selectedType = 'Front-end Developer';
                  });
                },
              ),
              const HeightGap(20),

              CustomSelectTileWidget(
                title: 'Back-end Developer',
                leadingIcon: Icons.check_circle_outline,
                isSelected: selectedType == 'Back-end Developer',
                onTap: () {
                  setState(() {
                    selectedType = 'Back-end Developer';
                  });
                },
              ),
              const HeightGap(20),

              CustomSelectTileWidget(
                title: 'Full-stack Developer',
                leadingIcon: Icons.check_circle_outline,
                isSelected: selectedType == 'Full-stack Developer',
                onTap: () {
                  setState(() {
                    selectedType = 'Full-stack Developer';
                  });
                },
              ),
              const HeightGap(20),

              CustomSelectTileWidget(
                title: 'UI/UX designer',
                leadingIcon: Icons.check_circle_outline,
                isSelected: selectedType == 'UI/UX designer',
                onTap: () {
                  setState(() {
                    selectedType = 'UI/UX designer';
                  });
                },
              ),
              const HeightGap(20),

              CustomSelectTileWidget(
                title: 'Mobile',
                leadingIcon: Icons.check_circle_outline,
                isSelected: selectedType == 'Mobile',
                onTap: () {
                  setState(() {
                    selectedType = 'Mobile';
                  });
                },
              ),
              const HeightGap(20),

              CustomSelectTileWidget(
                title: 'Media',
                leadingIcon: Icons.check_circle_outline,
                isSelected: selectedType == 'Media',
                onTap: () {
                  setState(() {
                    selectedType = 'Media';
                  });
                },
              ),

              const HeightGap(48),

              PrimaryButton(
                title: 'Continue',
                onPressed: () {
                  if (selectedType != null) {
                    ref.read(userTypeProvider.notifier).state =
                        selectedType ?? '';

                    context.pop(SignUpScreen.route);
                  } else {
                    showWarningMessage(context, message: 'Choose Your Stack');
                  }
                },
                sufix: const Icon(Icons.arrow_forward),
              ),
              const HeightGap(16),

              PrimaryButton(
                title: 'Back',
                onPressed: () => context.pop(SignUpScreen.route),
                prefix: const Icon(Icons.arrow_back),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
