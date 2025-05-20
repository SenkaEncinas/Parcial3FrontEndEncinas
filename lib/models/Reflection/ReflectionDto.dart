class ReflectionDto {
  final int id;
  final String content;
  final DateTime date;
  final int habitId;
  final String habitName;

  ReflectionDto({
    required this.id,
    required this.content,
    required this.date,
    required this.habitId,
    required this.habitName,
  });

  factory ReflectionDto.fromJson(Map<String, dynamic> json) => ReflectionDto(
        id: json['id'] as int,
        content: json['content'] as String,
        date: DateTime.parse(json['date'] as String),
        habitId: json['habitId'] as int,
        habitName: json['habitName'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'date': date.toIso8601String(),
        'habitId': habitId,
        'habitName': habitName,
      };
}