class SeaechReportsModel {
  final String id;
  final String task;
  final String reportText;
  final String intern;
  final String signIn;
  final String signOut;

  SeaechReportsModel({
    required this.id,
    required this.task,
    required this.reportText,
    required this.signIn,
    required this.signOut,
    required this.intern,
  });

  factory SeaechReportsModel.fromJson(Map<String, dynamic> json) {
    return SeaechReportsModel(
      id: json['id'] ?? '',
      task: json['task'] ?? '',
      reportText: json['report'] ?? '',
      signIn: json['signIn'] ?? '',
      signOut: json['signOut'] ?? '',
      intern: json['creator'] ?? '',
    );
  }
}
