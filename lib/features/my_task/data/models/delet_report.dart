class DeleteReport {
  final String idPost;

  DeleteReport({
    required this.idPost,
  });

  factory DeleteReport.fromJson(Map<String, dynamic> json) {
    return DeleteReport(
      idPost: json['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": idPost,
    };
  }
}
