import 'package:flutter/material.dart';
import 'package:flutter_clean_portfolio_app/core/constants/color_block.dart';
import 'package:flutter_clean_portfolio_app/core/constants/images.dart';

class AboutUsScreen extends StatelessWidget {
  static const String route = "/about-us";
  const AboutUsScreen({super.key});

  final String aboutText =
      "This application is a clean and scalable Flutter project built as a real-world example of Clean Architecture with MVVM. The main goal of this app is to demonstrate how a production-ready Flutter application can be structured using proper architectural principles and modern state management. The project is based on Clean Architecture with clear separation of presentation, domain, and data layers, MVVM pattern using Riverpod, AsyncValue for state handling without ChangeNotifier, and a scalable and maintainable folder structure. This project focuses on code quality, clean logic, and real-world architecture practices rather than just UI, making it suitable as a reference for professional Flutter applications.";

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width * 0.9;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 3, 47),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AppImages.logo,
                backgroundColor: Color.fromARGB(255, 38, 29, 72),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: Container(
                      width: maxWidth,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 33, 30, 52),

                        border: Border.all(width: 0.3, color: ColorBlock.grey),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        aboutText,
                        textAlign: TextAlign.left,
                        softWrap: true,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.6,
                          color: ColorBlock.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
