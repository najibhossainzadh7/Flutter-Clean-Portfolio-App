import 'package:flutter/material.dart';
import 'package:flutter_clean_portfolio_app/features/home/presentation/provider/home_providers.dart';
import 'package:flutter_clean_portfolio_app/features/home/presentation/screens/time_schedule.dart';
import 'package:flutter_clean_portfolio_app/features/home/presentation/widgets/report_card.dart';
import 'package:flutter_clean_portfolio_app/shared/search.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_portfolio_app/core/constants/color_block.dart';
import 'package:flutter_clean_portfolio_app/shared/spacer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String route = '/home-screen';
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<HomeScreen> {
 @override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    ref.read(reportViewModelProvider.notifier).fetchReports();
  });
}


  @override
  Widget build(BuildContext context) {

   Future<void> _refreshAll() async {
  await Future.wait([
    ref.read(userViewModelProvider.notifier).refreshUser(),
    ref.read(reportViewModelProvider.notifier).fetchReports(),
  ]);
}

final userState = ref.watch(userViewModelProvider);

    return Scaffold(
      body: SafeArea(
        child:userState.when(
  loading: () => const Center(
    child: CircularProgressIndicator(
      color: ColorBlock.accent,
      strokeWidth: 3,
    ),
  ),
  error: (e, _) => Center(
    child: Text('Error: ${e.toString()}'),
  ),
  data: (user) {
    return
    
     RefreshIndicator(
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
        child:
        Column(
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
                  backgroundImage:
                      user.profilePhoto != null
                          ? NetworkImage(user.profilePhoto!)
                          : null,
                  child:
                      user.profilePhoto == null
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                                  const TimeScheduleScreen(),
                                  const HeightGap(30),
                                  Search(
                                    onSearch: (query) {
                                      ref
                                          .read(reportViewModelProvider.notifier)
                                          .updateSearch(query);
                                    },
                                  ),
                                  const HeightGap(10),
                                   ReportCardWidget(),
        ],
           ), )
     );
  },


                  ),
                ),
    
    );
  }
}
