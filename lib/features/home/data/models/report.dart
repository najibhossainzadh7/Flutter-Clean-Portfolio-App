class ReportModel{
  final String id;
  final String task;
  final String reportText;
  final String name;
  final String signIn;
  final String signOut;
  final String date;
  final String stack;
  final String trainer;
  final String profilePhotoUrl;
  final String totur;

  ReportModel({
    required this.profilePhotoUrl,
    required this.trainer,
    required this.totur,
    required this.stack,
    required this.id,
    required this.task,
    required this.reportText,
    required this.name,
    required this.signIn,
    required this.signOut,
    required this.date,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    final creator = json['creator'] ?? {};
    final trainer = json['trainer'] ?? {};

    final profilePath = creator['profilePhoto'];

    return ReportModel(
      id: json['id'] ?? '',
      task: json['task'] ?? '',
      totur: json['totur'] ?? '',
      reportText: json['report'] ?? '',
      name: creator['name'] ?? '',
      profilePhotoUrl: profilePath,
      stack: creator['stack'] ?? '',
      trainer: trainer['name'] ?? '',
      signIn: json['signIn'] ?? '',
      signOut: json['signOut'] ?? '',
      date: json['date'] ?? '',
    );
  }
}
