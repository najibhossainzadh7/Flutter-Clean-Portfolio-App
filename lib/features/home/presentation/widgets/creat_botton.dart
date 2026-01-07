import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_clean_portfolio_app/core/constants/color_block.dart';
import 'package:flutter_clean_portfolio_app/features/home/presentation/screens/forms_report.dart';

class CreatBotton extends StatelessWidget {
  const CreatBotton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 62,
      height: 62,
      margin: const EdgeInsets.only(bottom: 13),
      child: FloatingActionButton(
        onPressed: () {
          context.push(FormsReportScreen.route);
        },
        backgroundColor: ColorBlock.accent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        child: const Icon(
          Icons.add_outlined,
          size: 33,
          color: ColorBlock.white,
        ),
      ),
    );
  }
}
