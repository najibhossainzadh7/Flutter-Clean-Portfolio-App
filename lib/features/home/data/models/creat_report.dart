import 'dart:io';

class CreateReportModel {
  final String mentorId;
  final String internId;
  final String signIn;
  final String signOut;
  final String task;
  final String report;
  final File? profilePhoto;

  CreateReportModel({
    required this.mentorId,
    required this.internId,
    required this.signIn,
    required this.signOut,
    required this.task,
    required this.report,
    this.profilePhoto,
  });

  Map<String, dynamic> toJson() => {
    "trainer": mentorId,
    "creator": internId,
    "signIn": signIn,
    "signOut": signOut,
    "task": task,
    "report": report,
  };

  Future toFormData() async {
    final data = Map<String, dynamic>.from(toJson());
    return data;
  }
}
