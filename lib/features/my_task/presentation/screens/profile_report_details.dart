import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_clean_portfolio_app/core/constants/color_block.dart';
import 'package:flutter_clean_portfolio_app/core/constants/constants.dart';
import 'package:flutter_clean_portfolio_app/features/my_task/data/models/report.dart';
import 'package:flutter_clean_portfolio_app/shared/spacer.dart';
import 'package:flutter_clean_portfolio_app/shared/text_input.dart';

class ProfileReportDetails extends ConsumerWidget {
  static const String route = '/profile-report-details';
  ProfileReportDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GoRouterState data = GoRouterState.of(context);
    final report = data.extra as ProfileReport;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorBlock.accent,

          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Report Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: ColorBlock.white,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      DateFormat(
                        'yyyy-MM-dd',
                      ).format(DateTime.parse(report.date).toLocal()),
                      style: const TextStyle(
                        color: ColorBlock.white,
                        fontSize: 16,
                      ),
                    ),
                    const WidthGap(10),
                    const Icon(
                      Icons.calendar_month_outlined,
                      color: ColorBlock.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: paddingMedium,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(1.5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorBlock.accent,
                          width: 1.5,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 48,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage:
                            report.profilePhotoUrl.isNotEmpty
                                ? NetworkImage(report.profilePhotoUrl)
                                : null,
                        child:
                            report.profilePhotoUrl.isEmpty
                                ? const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 48,
                                )
                                : null,
                      ),
                    ),
                    const WidthGap(20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(report.name, style: const TextStyle(fontSize: 18)),
                        Text(
                          report.stack,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const HeightGap(10),
                Divider(color: Colors.grey.shade500),
                const HeightGap(10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50,
                      width: 160,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('Sign in', style: TextStyle(fontSize: 16)),
                          Container(
                            height: 25,
                            width: 1,
                            color: ColorBlock.grey,
                          ),
                          Text(
                            report.signIn,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      height: 50,
                      width: 160,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'Sign out',
                            style: TextStyle(fontSize: 16),
                          ),
                          Container(
                            height: 25,
                            width: 1,
                            color: ColorBlock.grey,
                          ),
                          Text(
                            report.signOut,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const HeightGap(20),

                TextInput(
                  enabled: false,
                  hintText: 'TRAINER :  ${report.trainer}',
                  maxLines: 1,
                ),
                const HeightGap(20),

                TextInput(
                  enabled: false,
                  hintText: 'TASK :  ${report.task}',
                  maxLines: 3,
                ),

                const HeightGap(10),

                TextInput(
                  enabled: false,
                  hintText: 'REPORT :  ${report.reportText}',
                  maxLines: 7,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
