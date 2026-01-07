import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_clean_portfolio_app/core/constants/color_block.dart';
import 'package:flutter_clean_portfolio_app/core/constants/constants.dart';
import 'package:flutter_clean_portfolio_app/core/constants/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

String? requiredValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Field Required';
  }
  return null;
}

String roundOff(double? value) {
  return value == null
      ? ''
      : value.toString().replaceAll(RegExp(r'([.]*0)(?!.*\d)'), '');
}

String getCustomDateFormat(DateTime? date) {
  if (date == null) {
    return '';
  }
  return DateFormat('MMM d, yyyy').format(date);
}

void dismissKeyboard(BuildContext context) {
  final FocusScopeNode currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

void launchURL(Uri url) async {
  await canLaunchUrl(url)
      ? await launchUrl(url)
      : throw 'Could not launch $url';
}

String getCapitalizedName(String? value) {
  if (value == null) return '';
  return value[0].toUpperCase() + value.substring(1).toLowerCase();
}

void showErrorMessage(BuildContext context, {required String message}) {
  context.showFlash(
    duration: const Duration(seconds: 4),
    persistent: true,
    builder: (context, ctrl) {
      return FlashBar(
        controller: ctrl,
        margin: paddingMedium,
        backgroundColor: ColorBlock.white,
        clipBehavior: Clip.hardEdge,
        icon: const Icon(Icons.cancel_outlined, size: 24),
        iconColor: ColorBlock.red,
        shouldIconPulse: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        content: Text(
          message,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: ColorBlock.red,
          ),
        ),
        contentTextStyle: context.textTheme.bodyMedium,
        behavior: FlashBehavior.floating,
      );
    },
  );
}

void showWarningMessage(BuildContext context, {required String message}) {
  context.showFlash(
    duration: const Duration(seconds: 4),
    persistent: true,
    builder: (context, ctrl) {
      return FlashBar(
        controller: ctrl,
        margin: paddingMedium,
        backgroundColor: ColorBlock.white,
        clipBehavior: Clip.hardEdge,
        icon: const Icon(Icons.error_outline, size: 24),
        iconColor: Colors.yellow.shade800,
        shouldIconPulse: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        content: Text(
          message,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.yellow.shade800,
          ),
        ),
        contentTextStyle: context.textTheme.bodyMedium,
        behavior: FlashBehavior.floating,
      );
    },
  );
}

void showSuccessMessage(BuildContext context, {required String message}) {
  context.showFlash(
    duration: const Duration(seconds: 4),
    persistent: true,
    builder: (context, ctrl) {
      return FlashBar(
        controller: ctrl,
        margin: paddingMedium,
        backgroundColor: ColorBlock.white,
        clipBehavior: Clip.hardEdge,
        icon: const Icon(Icons.check_circle_outline_outlined, size: 24),
        shouldIconPulse: false,
        iconColor: Colors.green,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        content: Text(
          message,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.green,
          ),
        ),
        contentTextStyle: context.textTheme.bodyMedium,
        behavior: FlashBehavior.floating,
      );
    },
  );
}
