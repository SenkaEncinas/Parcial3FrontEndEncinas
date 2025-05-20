class ReflectionCreateDto {
  final String content;
  final int habitId;

  ReflectionCreateDto({
    required this.content,
    required this.habitId,
  });

  factory ReflectionCreateDto.fromJson(Map<String, dynamic> json) => ReflectionCreateDto(
        content: json['content'] as String,
        habitId: json['habitId'] as int,
      );

  Map<String, dynamic> toJson() => {
        'content': content,
        'habitId': habitId,
      };
}