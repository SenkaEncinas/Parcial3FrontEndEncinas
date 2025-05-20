class UserInfoDto {
  final int id;
  final String email;
  final String role;
  final String token;

  UserInfoDto({
    required this.id,
    required this.email,
    required this.role,
    required this.token,
  });

  factory UserInfoDto.fromJson(Map<String, dynamic> json) => UserInfoDto(
        id: json['id'] as int,
        email: json['email'] as String,
        role: json['role'] as String,
        token: json['token'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'role': role,
        'token': token,
      };
}