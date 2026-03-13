class Question {
  final int id;
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  final int points;

  Question({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    required this.points,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as int,
      questionText: json['question_text'] as String,
      options: List<String>.from(json['options'] as List),
      correctAnswerIndex: json['correct_answer_index'] as int,
      points: json['points'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'question_text': questionText,
    'options': options,
    'correct_answer_index': correctAnswerIndex,
    'points': points,
  };
}
