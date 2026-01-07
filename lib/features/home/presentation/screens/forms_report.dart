import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_clean_portfolio_app/core/constants/color_block.dart';
import 'package:flutter_clean_portfolio_app/core/constants/constants.dart';
import 'package:flutter_clean_portfolio_app/core/network/token_storage.dart';
import 'package:flutter_clean_portfolio_app/core/utils/utils.dart';
import 'package:flutter_clean_portfolio_app/features/home/presentation/provider/home_providers.dart';
import 'package:flutter_clean_portfolio_app/features/home/presentation/view_model/mentor.dart';
import 'package:flutter_clean_portfolio_app/features/navigation/bottom_navigation.dart';
import 'package:flutter_clean_portfolio_app/shared/spacer.dart';
import 'package:flutter_clean_portfolio_app/shared/text_input.dart';

class FormsReportScreen extends ConsumerStatefulWidget {
  const FormsReportScreen({super.key});

  static const String route = '/forms-report';

  @override
  ConsumerState<FormsReportScreen> createState() => FormsReportScreenState();
}

class FormsReportScreenState extends ConsumerState<FormsReportScreen> {
  TextEditingController taskControler = TextEditingController();
  TextEditingController tutorControler = TextEditingController();
  TextEditingController reportControler = TextEditingController();

  static const String route = '/forms-report';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
final userAsync = ref.watch(userViewModelProvider); 
final formVmNotifier = ref.read(formsReportProvider.notifier);

    final mentorsAsync = ref.watch(mentorsProvider);
    final selectedMentor = ref.watch(mentorSelectProvider);

    Future<void> _pickSignInTime() async {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (picked != null) {
        formVmNotifier.pickSignIn(picked);
      }
    }

    Future<void> _pickSignOutTime() async {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (picked != null) {
        formVmNotifier.pickSignOut(picked);
      }
    }

    Future<void> _pickDate() async {
      final picked = await showDatePicker(
        context: context,
        initialDate: formVmNotifier.selectedDate,
        firstDate: DateTime(2024),
        lastDate: DateTime(2030),
      );
      if (picked != null) {
        formVmNotifier.pickDate(picked);
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorBlock.accent,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Form\'s Report',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: ColorBlock.white,
                  ),
                ),
                GestureDetector(
                  onTap: _pickDate,
                  child: Row(
                    children: [
                      Text(
                        "${formVmNotifier.selectedDate.year} / ${formVmNotifier.selectedDate.month} / ${formVmNotifier.selectedDate.day}",
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
                ),
              ],
            ),
          ),
        ),
      
          body: userAsync.when(
  loading: () => const Center(
    child: CircularProgressIndicator(color: ColorBlock.accent),
  ),
  error: (e, _) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error, color: Colors.red, size: 50),
        const SizedBox(height: 10),
        Text("Failed to load user: $e"),
      ],
    ),
  ),
  data: (user) {final 
  profileUrl = user.profilePhoto;
final name = user.name;
final stack = user.role ?? ''; 

    return SingleChildScrollView(
      padding: paddingMedium,
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          Row(
            children: [
              const WidthGap(20),
              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorBlock.accent,
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage:
                      profileUrl != null ? NetworkImage(profileUrl) : null,
                  child: profileUrl == null
                      ? const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.grey,
                        )
                      : null,
                ),
              ),
              const WidthGap(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    stack,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: _pickSignInTime,
                child: Container(
                  height: 50,
                  width: 165,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Sign in', style: TextStyle(fontSize: 16)),
                        Container(height: 25, width: 1, color: ColorBlock.grey),
                        Text(
                          formVmNotifier.signInTime != null
                              ? formVmNotifier.signInTime!.format(context)
                              : '00:00',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: _pickSignOutTime,
                child: Container(
                  height: 50,
                  width: 165,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Sign out', style: TextStyle(fontSize: 16)),
                        Container(height: 25, width: 1, color: ColorBlock.grey),
                        Text(
                          formVmNotifier.signOutTime != null
                              ? formVmNotifier.signOutTime!.format(context)
                              : '00:00',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          const HeightGap(24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: mentorsAsync.when(
                  data: (mentors) => DropdownButtonFormField<String>(
                    value: selectedMentor,
                    decoration: InputDecoration(
                      labelText: "Select Mentor",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    items: mentors
                        .map((m) => DropdownMenuItem(
                              value: m.id,
                              child: Text(m.name),
                            ))
                        .toList(),
                    onChanged: (val) {
                      ref.read(mentorSelectProvider.notifier).setMentor(val!);
                    },
                  ),
                  loading: () => const Center(
                      child: CircularProgressIndicator(color: ColorBlock.accent)),
                  error: (e, s) => Row(
                    children: [
                      const Text(
                        "Check your network and try again!",
                        style: TextStyle(color: ColorBlock.red),
                      ),
                      IconButton(
                        onPressed: () => ref.invalidate(mentorsProvider),
                        icon: const Icon(Icons.refresh),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const HeightGap(8),

          TextInput(
            onChanged: (v) => setState(() {}),
            hintText: 'task...',
            maxLines: 4,
            controller: taskControler,
          ),
          TextInput(
            onChanged: (v) => setState(() {}),
            hintText: 'report...',
            maxLines: 7,
            controller: reportControler,
          ),
          const HeightGap(30),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () => context.pop(),
                child: const Text('Cancel',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: ColorBlock.black)),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 25),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  side: const BorderSide(color: ColorBlock.grey),
                ),
              ),
              const WidthGap(180),
              ElevatedButton(
                onPressed: () async {
                  if (taskControler.text.isEmpty ||
                      reportControler.text.isEmpty ||
                      selectedMentor == null) {
                    return showWarningMessage(
                        context, message: 'Please fill in all required fields.');
                  }

                  setState(() => isLoading = true);

                  final userId = await getid();

                  await formVmNotifier.submitReport(
                    internId: userId,
                    task: taskControler.text.trim(),
                    tutor: tutorControler.text.trim(),
                    reportText: reportControler.text.trim(),
                    mentorId: selectedMentor,
                  );
try {
  await formVmNotifier.submitReport(
    internId: userId,
    task: taskControler.text.trim(),
    tutor: tutorControler.text.trim(),
    reportText: reportControler.text.trim(),
    mentorId: selectedMentor,
  );

  taskControler.clear();
  reportControler.clear();
  ref.read(homeRefreshTriggerProvider.notifier).state++;

  showSuccessMessage(context, message: 'Submitted Successfully');
  context.go(BottomNavigation.route);
} catch (e) {
  showErrorMessage(context,
      message: 'Submission failed. Please try again.');
}


                  setState(() => isLoading = false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: taskControler.text.isNotEmpty &&
                          reportControler.text.isNotEmpty &&
                          selectedMentor != null
                      ? ColorBlock.accent
                      : Colors.grey.shade400,
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(57, 57),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: ColorBlock.white, strokeWidth: 2)
                    : const Icon(Icons.check_circle_outline,
                        size: 30, color: ColorBlock.white),
              ),
            ],
          ),
        ],
      ),
    );
  },
),

                      
                    ),
                  
    );
  }

  Future getid() async {
    TokenStorage tokenStorage = TokenStorage();
    final userid = tokenStorage.getUserId();
    return userid;
  }
}
