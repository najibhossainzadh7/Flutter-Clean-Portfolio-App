import 'package:flutter/material.dart';
import 'package:flutter_clean_portfolio_app/core/constants/color_block.dart';
import 'package:flutter_clean_portfolio_app/shared/spacer.dart';

class DrawerOptions extends StatelessWidget {
  final String title;
  final IconData icon;
  const DrawerOptions({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(color: ColorBlock.white),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
        const  WidthGap(12),
          Icon(icon, color: ColorBlock.white),
         const WidthGap(16),
          Text(
            title,
            style:const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: ColorBlock.white,
            ),
          ),
        ],
      ),
    );
  }
}
