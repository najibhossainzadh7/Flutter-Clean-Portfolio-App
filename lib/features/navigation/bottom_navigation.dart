import 'package:flutter/material.dart';
import 'package:flutter_clean_portfolio_app/core/constants/color_block.dart';
import 'package:flutter_clean_portfolio_app/features/home/presentation/screens/home.dart';
import 'package:flutter_clean_portfolio_app/features/about_us/presentation/screens/about_us.dart';
import 'package:flutter_clean_portfolio_app/features/auth/presentation/screens/sign_out.dart';
import 'package:flutter_clean_portfolio_app/features/home/presentation/widgets/creat_botton.dart';
import 'package:flutter_clean_portfolio_app/features/my_task/presentation/screens/my_task.dart';
import 'package:flutter_clean_portfolio_app/shared/spacer.dart';

class BottomNavigation extends StatefulWidget {
  static const String route = '/dashboard';
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<BottomNavigation> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(),
    MyTaskScreen(),
    AboutUsScreen(),
    SignOutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pages[selectedIndex],
        bottomNavigationBar: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 63,
              padding: const EdgeInsets.symmetric(horizontal: 25),
              decoration: const BoxDecoration(
                color: ColorBlock.fill,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(20),
                  right: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  bottomItem(
                    outlinedIcon: Icons.home_outlined,
                    filledIcon: Icons.home,
                    index: 0,
                    label: 'Home',
                  ),
                  bottomItem(
                    outlinedIcon: Icons.library_books_outlined,
                    filledIcon: Icons.library_books,
                    index: 1,
                    label: 'My Task',
                  ),
                  const WidthGap(20),
                  bottomItem(
                    outlinedIcon: Icons.info_outline,
                    filledIcon: Icons.info,
                    index: 2,
                    label: 'About Us',
                  ),
                  bottomItem(
                    outlinedIcon: Icons.logout_outlined,
                    filledIcon: Icons.logout,
                    index: 3,
                    label: 'Logout',
                  ),
                ],
              ),
            ),
            Positioned(
              top: -30,
              left: MediaQuery.of(context).size.width / 2 - 35,
              child: const CreatBotton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomItem({
    required IconData outlinedIcon,
    required IconData filledIcon,
    required int index,
    required String label,
  }) {
    final bool isActive = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isActive ? filledIcon : outlinedIcon,
            size: 28,
            color: isActive ? ColorBlock.accent : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isActive ? ColorBlock.accent : ColorBlock.grey,
            ),
          ),
        ],
      ),
    );
  }
}
