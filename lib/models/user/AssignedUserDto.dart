class AssignedUserDto {
  final int id;
  final String email;
  final String fullName;

  AssignedUserDto({
    required this.id,
    required this.email,
    required this.fullName,
  });

  factory AssignedUserDto.fromJson(Map<String, dynamic> json) {
    return AssignedUserDto(
      id: json['id'],
      email: json['email'],
      fullName: json['fullName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
    };
  }
}