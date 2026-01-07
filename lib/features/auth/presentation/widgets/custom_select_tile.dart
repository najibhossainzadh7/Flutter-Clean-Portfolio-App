import 'package:flutter/material.dart';
import 'package:flutter_clean_portfolio_app/core/constants/color_block.dart';
import 'package:flutter_clean_portfolio_app/shared/spacer.dart';

class CustomSelectTileWidget extends StatelessWidget {
  final String title;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final VoidCallback? onTap;

  final bool isSelected;

  const CustomSelectTileWidget({
    super.key,
    required this.title,
    this.leadingIcon,
    this.trailingIcon,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color:
              isSelected
                  ? ColorBlock.accent.withOpacity(0.15)
                  : Colors.white,
          border: Border.all(
            color: isSelected ? ColorBlock.accent : ColorBlock.black,
            width: isSelected ? 2 : 0.8,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const WidthGap(10),
                Icon(
                  leadingIcon,
                  color: isSelected ? ColorBlock.accent : ColorBlock.black,
                ),
                const WidthGap(10),
                Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? ColorBlock.accent : ColorBlock.black,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
