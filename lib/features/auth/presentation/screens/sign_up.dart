import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_clean_portfolio_app/core/constants/color_block.dart';
import 'package:flutter_clean_portfolio_app/core/constants/extensions.dart';
import 'package:flutter_clean_portfolio_app/core/failure.dart';
import 'package:flutter_clean_portfolio_app/features/auth/presentation/provider/auth_providers.dart';
import 'package:flutter_clean_portfolio_app/core/utils/utils.dart';
import 'package:flutter_clean_portfolio_app/features/auth/presentation/screens/sign_in.dart';
import 'package:flutter_clean_portfolio_app/features/auth/presentation/screens/user_type.dart';
import 'package:flutter_clean_portfolio_app/features/navigation/bottom_navigation.dart';
import 'package:flutter_clean_portfolio_app/shared/primary_button.dart';
import 'package:flutter_clean_portfolio_app/shared/spacer.dart';
import 'package:flutter_clean_portfolio_app/shared/text_input.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static const String route = '/sign-up';
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _emailController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? _profileImage;

  @override
  Widget build(BuildContext context) {
    final _userType = ref.watch(userTypeProvider);
final signUpState = ref.watch(signUpViewModelProvider);
    final avatarBytes = ref.watch(avatarProvider);

    return WillPopScope(
      onWillPop: () async {
        context.go('/welcome');
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                right: 20,
                left: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create Account',
                      style: context.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Join as and manage your daily task easily',
                      style: context.textTheme.bodyMedium,
                    ),
                    const HeightGap(30),
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage:
                              avatarBytes != null
                                  ? MemoryImage(avatarBytes)
                                  : null,
                          child:
                              avatarBytes == null
                                  ? const Icon(Icons.person, size: 50)
                                  : null,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: CircleAvatar(
                            backgroundColor: ColorBlock.grey,
                            child: IconButton(
                              onPressed: _pickImage,
                              icon: const Icon(
                                Icons.edit,
                                color: ColorBlock.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextInput(
                            hintText: "Enter your full name",
                            controller: _fullNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Full name is required";
                              }
                              if (value.length > 20) {
                                return "Full Name must be maximum 20 characters";
                              }
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          const HeightGap(8),
                          TextInput(
                            hintText: "Enter your email",
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Email is required";
                              }
                              if (!value.contains('@')) {
                                return "Enter a valid email";
                              }
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          const HeightGap(8),
                          TextInput(
                            hintText: "Enter your password",
                            controller: _passwordController,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password is required";
                              }
                              if (value.length < 8) {
                                return "Password must be at least 8 characters";
                              }
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          const HeightGap(8),
                          TextInput(
                            hintText: "Re-enter your password",
                            controller: _confirmPasswordController,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Confirm password is required";
                              }
                              if (value != _passwordController.text) {
                                return "Passwords do not match";
                              }
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                        ],
                      ),
                    ),
                    const HeightGap(25),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorBlock.fill,
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 0.8,
                        ),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              _userType.isNotEmpty ? _userType : '',
                              style: const TextStyle(color: ColorBlock.black),
                            ),
                          ),
                          IconButton(
                            onPressed: () => context.push(UserTypeScreen.route),
                            icon: const Icon(Icons.keyboard_arrow_right),
                          ),
                        ],
                      ),
                    ),
                    const HeightGap(35),
                  PrimaryButton(
  title: 'Sign up',
  isLoading: signUpState is AsyncLoading,
  onPressed: () async {
    if (!_formKey.currentState!.validate() ||
        ref.read(userTypeProvider) == "Choose Your Stack") {
      showWarningMessage(context, message: 'Please fill out the form');
      return;
    }

    await ref.read(signUpViewModelProvider.notifier).signUp(
          name: _fullNameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          passwordConfirm: _confirmPasswordController.text.trim(),
          stack: ref.read(userTypeProvider),
          profilePhoto: _profileImage,
        );

    final state = ref.read(signUpViewModelProvider);
    state.when(
      data: (_) {
        context.go(BottomNavigation.route);
        showSuccessMessage(context, message: "Account created successfully!");
      },
      loading: () {},
      error: (err, _) {
        final msg = err is Failure ? err.message : err.toString();
        showErrorMessage(context, message: msg);
      },
    );
  },
),

                    const HeightGap(16),
                    Text.rich(
                      TextSpan(
                        text: 'Already have an account? ',
                        children: [
                          TextSpan(
                            text: 'Sign in',
                            style: TextStyle(
                              color: Colors.blue.shade500,
                              fontWeight: FontWeight.w700,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    context.go(SignInScreen.route);
                                  },
                          ),
                        ],
                      ),
                    ),
                 const   HeightGap(10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }



  Future<void> _pickImage() async {
    try {
      final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picked == null) return;

      final file = File(picked.path);
      final bytes = await file.readAsBytes();

      await ref.read(avatarProvider.notifier).setAvatar(bytes);

      setState(() {
        _profileImage = file;
      });
    } catch (e) {
      debugPrint("Image pick error: $e");
    }
  }
}
