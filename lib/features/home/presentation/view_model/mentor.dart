import 'package:flutter_riverpod/flutter_riverpod.dart';

class MentorSelectViewModel extends StateNotifier<String?> {
  MentorSelectViewModel() : super(null);

  void setMentor(String id) {
    state = id;
  }
}

final mentorSelectProvider =
    StateNotifierProvider<MentorSelectViewModel, String?>(
  (ref) => MentorSelectViewModel(),
);
