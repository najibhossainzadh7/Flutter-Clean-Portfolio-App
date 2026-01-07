import 'package:flutter/material.dart';

import 'package:flutter_clean_portfolio_app/core/routes/app_routes.dart';
import 'package:flutter_clean_portfolio_app/core/themes/themes.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Clean Portfolio App',
      theme: AppThemes.getLightTheme(context),
      debugShowCheckedModeBanner: false,
      routeInformationParser: AppRoutes.router.routeInformationParser,
      routeInformationProvider: AppRoutes.router.routeInformationProvider,
      routerDelegate: AppRoutes.router.routerDelegate,
    );
  }
}
