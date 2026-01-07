import 'package:flutter_clean_portfolio_app/features/auth/presentation/screens/splash.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_clean_portfolio_app/features/about_us/presentation/screens/about_us.dart';
import 'package:flutter_clean_portfolio_app/features/auth/presentation/screens/sign_in.dart';
import 'package:flutter_clean_portfolio_app/features/auth/presentation/screens/sign_out.dart';
import 'package:flutter_clean_portfolio_app/features/auth/presentation/screens/sign_up.dart';
import 'package:flutter_clean_portfolio_app/features/auth/presentation/screens/user_type.dart';
import 'package:flutter_clean_portfolio_app/features/auth/presentation/screens/welcome.dart';
import 'package:flutter_clean_portfolio_app/features/home/presentation/screens/home.dart';
import 'package:flutter_clean_portfolio_app/features/home/presentation/screens/report_details.dart';
import 'package:flutter_clean_portfolio_app/features/my_task/presentation/screens/profile_report_details.dart';
import 'package:flutter_clean_portfolio_app/features/navigation/bottom_navigation.dart';
import 'package:flutter_clean_portfolio_app/features/home/presentation/screens/forms_report.dart';

class AppRoutes {
  AppRoutes._();


  static final router = GoRouter(

    initialLocation:SplashScreen.route,

    routes: [
      GoRoute(
        path: BottomNavigation.route,
        builder: (context, state) => const BottomNavigation(),
      ),
        GoRoute(
        path: SplashScreen.route,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Welcome.route,
        builder: (context, state) => const Welcome(),
      ),

      GoRoute(
        path: SignInScreen.route,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: SignUpScreen.route,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: UserTypeScreen.route,
        builder: (context, state) => const UserTypeScreen(),
      ),
      GoRoute(
        path: FormsReportScreen.route,
        builder: (context, state) =>const  FormsReportScreen(),
      ),
      GoRoute(
        path: SignOutScreen.route,
        builder: (context, state) => const SignOutScreen(),
      ), GoRoute(
        path: HomeScreen.route,
        builder: (context, state) => const HomeScreen(),
      ), GoRoute(
        path: ReportDetailsScreen.route,
        builder: (context, state) =>  ReportDetailsScreen(),
      ), GoRoute(
        path:AboutUsScreen.route,
        builder: (context, state) =>const  AboutUsScreen(),
      ), GoRoute(
        path:ProfileReportDetails.route,
        builder: (context, state) =>  ProfileReportDetails(),
      ),
    ],
  );
}
