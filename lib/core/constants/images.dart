import 'package:flutter/material.dart';

const String _imagePath = 'assets/images';

class _Image extends AssetImage {
  const _Image(String fileName) : super('$_imagePath/$fileName');
}

class AppImages {
  AppImages._();

  static const logo = _Image('logo.png');
  static const welcome = _Image('welcome.png');
  static const avatar = _Image('avatar.png');
  static const aboutUs = _Image('about_us.png');
  static const appIcon = _Image('app_icon.png');

  static Future<void> precacheAssets(BuildContext context) async {}
}
