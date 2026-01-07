import 'package:flutter/material.dart';
import 'package:flutter_clean_portfolio_app/features/home/presentation/provider/home_providers.dart';
import 'package:flutter_clean_portfolio_app/features/my_task/presentation/provider/my_task_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_portfolio_app/core/constants/color_block.dart';
import 'package:flutter_clean_portfolio_app/features/my_task/presentation/screens/time_schedule.dart';
import 'package:flutter_clean_portfolio_app/features/my_task/presentation/widgets/report_card.dart';
import 'package:flutter_clean_portfolio_app/shared/spacer.dart';

class MyTaskScreen extends ConsumerStatefulWidget {
  const MyTaskScreen({super.key});

  @override
  ConsumerState<MyTaskScreen> createState() => _MyTaskScreenState();
}

class _MyTaskScreenState extends ConsumerState<MyTaskScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userViewModelProvider.notifier).fetchUser();
      ref.read(profileReportViewModelProvider.notifier).fetchReports();
    });
  }

  Future<void> _refreshAll() async {
    await Future.wait([
      ref.read(userViewModelProvider.notifier).refreshUser(),
      ref.read(profileReportViewModelProvider.notifier).fetchReports(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final asyncUser = ref.watch(userViewModelProvider);
    return SafeArea(
      child: asyncUser.when(
        data: (user) => RefreshIndicator(
          color: ColorBlock.accent,
          onRefresh: _refreshAll,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(
              top: 0,
              left: 15,
              right: 15,
              bottom: 50,
            ),
            child: Column(
              children: [
                const HeightGap(20),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorBlock.accent,
                          width: 1.5,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage: user.profilePhoto != null
                            ? NetworkImage(user.profilePhoto!)
                            : null,
                        child: user.profilePhoto == null
                            ? const Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                    ),
                    const WidthGap(10),
                    SizedBox(
                      width: 235,
                      height: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hello!',
                            style: TextStyle(
                              color: ColorBlock.grey,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontSize: 16,
                              color: ColorBlock.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(10),
                        side: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        minimumSize: Size.zero,
                      ),
                      child: const Icon(
                        Icons.notifications_outlined,
                        size: 23,
                        color: ColorBlock.black,
                      ),
                    ),
                  ],
                ),
                const HeightGap(30),
                const ProfleTimeScheduleScreen(),
                const HeightGap(30),
                const ProfileReportCardScreen(),
              ],
            ),
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: ColorBlock.accent,
            strokeWidth: 3,
          ),
        ),
        error: (err, _) => Center(
          child: Text("Error loading user: $err"),
        ),
      ),
    );
  }
}
