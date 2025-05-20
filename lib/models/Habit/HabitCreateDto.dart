class HabitCreateDto {
  final String name;

  HabitCreateDto({
    required this.name,
  });

  factory HabitCreateDto.fromJson(Map<String, dynamic> json) => HabitCreateDto(
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}