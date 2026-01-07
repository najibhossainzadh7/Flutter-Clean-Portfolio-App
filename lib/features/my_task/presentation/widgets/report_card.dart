import 'package:flutter/material.dart';
import 'package:flutter_clean_portfolio_app/features/my_task/presentation/provider/my_task_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_clean_portfolio_app/core/constants/color_block.dart';
import 'package:flutter_clean_portfolio_app/features/my_task/presentation/screens/profile_report_details.dart';
import 'package:flutter_clean_portfolio_app/shared/spacer.dart';

class ProfileReportCardScreen extends ConsumerStatefulWidget {
  const ProfileReportCardScreen({super.key});

  @override
  ConsumerState<ProfileReportCardScreen> createState() =>
      _ProfileReportCardScreenState();
}

class _ProfileReportCardScreenState
    extends ConsumerState<ProfileReportCardScreen> {
  DateTime selectedDate = DateTime.now();

  void _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
      initialDate: selectedDate,
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });

      final query =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";

      await ref
          .read(profileReportViewModelProvider.notifier)
          .fetchFilterReports(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncReports = ref.watch(profileReportViewModelProvider);

    return Column(
      children: [
        Container(
          height: 540,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(),
            color: ColorBlock.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: ColorBlock.accent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Reports',
                        style: TextStyle(
                          color: ColorBlock.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      GestureDetector(
                        onTap: _selectDate,
                        child: Row(
                          children: [
                            Text(
                              "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}",
                              style: const TextStyle(
                                color: ColorBlock.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const WidthGap(10),
                            const Icon(
                              Icons.tune_outlined,
                              color: ColorBlock.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const HeightGap(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Full Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(height: 20, width: 1, color: ColorBlock.black),
                    const Text(
                      'Sign in',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(height: 20, width: 1, color: ColorBlock.black),
                    const Text(
                      'Sign out',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Divider(color: ColorBlock.grey),

              Expanded(
                child: asyncReports.when(
                  data: (reports) {
                    if (reports.isEmpty) {
                      return const Center(child: Text("No reports for this date"));
                    }

                    return ListView.separated(
                      itemCount: reports.length,
                      separatorBuilder: (_, __) =>
                          Divider(color: Colors.grey.shade300),
                      itemBuilder: (context, index) {
                        final report = reports[index];
                        final postId = report.id;

                        return ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          leading: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              padding: EdgeInsets.zero,
                              shape: const CircleBorder(),
                            ),
                            onPressed: () {
                              context.push(
                                ProfileReportDetails.route,
                                extra: report,
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: ColorBlock.accent,
                                  width: 1.5,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.grey.shade300,
                                backgroundImage: NetworkImage(
                                  report.profilePhotoUrl,
                                ),
                              ),
                            ),
                          ),
                          title: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Text(report.name),
                                const WidthGap(10),
                                Container(
                                  height: 20,
                                  width: 1,
                                  color: ColorBlock.black,
                                ),
                                const WidthGap(10),
                                Text(report.signIn),
                                const WidthGap(10),
                                Container(
                                  height: 20,
                                  width: 1,
                                  color: ColorBlock.black,
                                ),
                                const WidthGap(10),
                                Text(report.signOut),
                                const WidthGap(10),
                                Container(
                                  height: 20,
                                  width: 1,
                                  color: ColorBlock.black,
                                ),
                              ],
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Delete Report"),
                                  content: const Text(
                                    "Are you sure you want to delete this report?",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text(
                                        "No",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: ColorBlock.accent,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: const Text(
                                        "Yes",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: ColorBlock.accent,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );

                              if (confirm != null && confirm) {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (_) => const Center(
                                    child: CircularProgressIndicator(
                                      color: ColorBlock.black,
                                    ),
                                  ),
                                );

                                try {
                                  await ref
                                      .read(deleteReportProvider.notifier)
                                      .deleteReport(postId);
                                  Navigator.of(context).pop(); 
                                  ref
                                      .read(profileReportViewModelProvider.notifier)
                                      .fetchReports();
                                } catch (e) {
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Failed to delete report: $e",
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: ColorBlock.red,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(
                      color: ColorBlock.black,
                      strokeWidth: 2,
                    ),
                  ),
                  error: (err, _) => Center(
                    child: Text("Error loading reports: $err"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
