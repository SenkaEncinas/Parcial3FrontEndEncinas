class HabitDto {
  final int id;
  final String name;
  final DateTime createdAt;

  HabitDto({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory HabitDto.fromJson(Map<String, dynamic> json) => HabitDto(
        id: json['id'] as int,
        name: json['name'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'createdAt': createdAt.toIso8601String(),
      };
}