import 'package:flutter/material.dart';

import 'package:flutter_clean_portfolio_app/core/constants/color_block.dart';
import 'package:flutter_clean_portfolio_app/shared/loading_indicator.dart';
import 'package:flutter_clean_portfolio_app/shared/spacer.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.dense = false,
    this.isLoading = false,
    this.prefix,
    this.sufix,
  });
  final Icon? prefix;
  final Icon? sufix;

  final String title;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 55,
      child: MaterialButton(
        onPressed: isLoading ? () {} : onPressed,
        elevation: 0,
        highlightElevation: 0,
        animationDuration: Duration.zero,
        color: Colors.grey.shade200,
        splashColor: Colors.brown.shade50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: ColorBlock.black),
        ),
        child:
            isLoading
                ? const LoadingIndicator(color: ColorBlock.grey)
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (prefix != null) ...[prefix!, const SizedBox(width: 8)],
                    const WidthGap(8),

                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ColorBlock.black,
                        fontSize: dense ? 12 : 14,
                        height: 1,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const WidthGap(8),
                    if (sufix != null) ...[sufix!, const SizedBox(width: 8)],
                  ],
                ),
      ),
    );
  }
}
