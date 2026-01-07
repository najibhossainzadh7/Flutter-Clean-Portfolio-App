import 'package:flutter/material.dart';
import 'package:flutter_clean_portfolio_app/features/home/presentation/provider/home_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_clean_portfolio_app/features/home/presentation/screens/report_details.dart';
import 'package:flutter_clean_portfolio_app/core/constants/color_block.dart';
import 'package:flutter_clean_portfolio_app/shared/spacer.dart';
class ReportCardWidget extends ConsumerStatefulWidget {
  const ReportCardWidget({super.key});

  @override
  ConsumerState<ReportCardWidget> createState() => _ReportCardWidgetState();
}

class _ReportCardWidgetState extends ConsumerState<ReportCardWidget> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(reportViewModelProvider.notifier).fetchReports();
    });
  }

  void _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
      initialDate: selectedDate,
    );

    if (picked != null) {
      setState(() => selectedDate = picked);

      ref.read(reportViewModelProvider.notifier).updateDate(
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final reportsAsync = ref.watch(reportViewModelProvider);

    return Container(
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
                const Text('Full Name', style: TextStyle(fontWeight: FontWeight.bold)),
                Container(height: 20, width: 1, color: ColorBlock.black),
                const Text('Sign in', style: TextStyle(fontWeight: FontWeight.bold)),
                Container(height: 20, width: 1, color: ColorBlock.black),
                const Text('Sign out', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const Divider(color: ColorBlock.grey),

          Expanded(
            child: reportsAsync.when(
              loading: () => const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: ColorBlock.black,
                ),
              ),
              error: (e, st) => Center(child: Text("Error: $e")),
              data: (items) => items.isEmpty
                  ? const Center(child: Text("No report for this date"))
                  : ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (_, __) => Divider(color: Colors.grey.shade300),
                      itemBuilder: (context, index) {
                        final report = items[index];

                        return ListTile(
                          contentPadding: const EdgeInsets.only(left: 2, right: 2, bottom: 1),
                          leading: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              padding: EdgeInsets.zero,
                              shape: const CircleBorder(),
                            ),
                            onPressed: () {
                              context.push(
                                ReportDetailsScreen.route,
                                extra: report,
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: ColorBlock.accent, width: 1.5),
                              ),
                              child: CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.grey.shade300,
                                backgroundImage: report.profilePhotoUrl.isNotEmpty
                                    ? NetworkImage(report.profilePhotoUrl)
                                    : null,
                                child: report.profilePhotoUrl.isEmpty
                                    ? const Icon(Icons.person, color: Colors.white)
                                    : null,
                              ),
                            ),
                          ),
                          title: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Text(report.name),
                                const WidthGap(10),
                                Container(height: 20, width: 1, color: ColorBlock.black),
                                const WidthGap(10),
                                Text(report.signIn),
                                const WidthGap(10),
                                Container(height: 20, width: 1, color: ColorBlock.black),
                                const WidthGap(10),
                                Text(report.signOut),
                                const WidthGap(10),
                                Container(height: 20, width: 1, color: ColorBlock.black),
                                const WidthGap(10),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
