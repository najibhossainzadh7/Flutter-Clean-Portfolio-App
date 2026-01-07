class MentorModel {
  final String id;
  final String name;

  MentorModel({
    required this.id,
    required this.name,
  });

  factory MentorModel.fromJson(Map<String, dynamic> json) {
    return MentorModel(
      id: json['_id'],
      name: json['name'],
    );
  }
}
