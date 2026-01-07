class UserModel {
  final String id;
  final String name;
  final String? profilePhoto;
  final String? email;
  final String? role;

  const UserModel({
    required this.id,
    required this.name,
    this.profilePhoto,
    this.email,
    this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Unknown',
      profilePhoto: json['profilePhoto'] as String?,
      email: json['email'] as String?,
      role: json['role'] as String?,
    );
  }

  UserModel copyWith({
    String? name,
    String? profilePhoto,
    String? email,
    String? role,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      email: email ?? this.email,
      role: role ?? this.role,
    );
  }
}
