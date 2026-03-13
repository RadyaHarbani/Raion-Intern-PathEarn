class QuizAnswer {
  final int questionId;
  final int selectedAnswerIndex;
  final bool isCorrect;
  final int earnedPoints;

  QuizAnswer({
    required this.questionId,
    required this.selectedAnswerIndex,
    required this.isCorrect,
    required this.earnedPoints,
  });

  factory QuizAnswer.fromJson(Map<String, dynamic> json) {
    return QuizAnswer(
      questionId: json['question_id'] as int,
      selectedAnswerIndex: json['selected_answer_index'] as int,
      isCorrect: json['is_correct'] as bool,
      earnedPoints: json['earned_points'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'question_id': questionId,
    'selected_answer_index': selectedAnswerIndex,
    'is_correct': isCorrect,
    'earned_points': earnedPoints,
  };
}

class QuizResult {
  final int stage;
  final int section;
  final int totalQuestions;
  final int correctCount;
  final int wrongCount;
  final int emptyCount;
  final int totalScore;
  final List<QuizAnswer> answers;
  final DateTime completedAt;

  QuizResult({
    required this.stage,
    required this.section,
    required this.totalQuestions,
    required this.correctCount,
    required this.wrongCount,
    required this.emptyCount,
    required this.totalScore,
    required this.answers,
    required this.completedAt,
  });

  int get scorePercentage =>
      ((totalScore / (totalQuestions * 5)) * 100).toInt();

  String get scoreLabel {
    if (scorePercentage >= 90) return 'Sempurna';
    if (scorePercentage >= 80) return 'Bagus';
    if (scorePercentage >= 70) return 'Cukup';
    if (scorePercentage >= 60) return 'Kurang';
    return 'Gagal';
  }

  factory QuizResult.fromJson(Map<String, dynamic> json) {
    return QuizResult(
      stage: json['stage'] as int,
      section: json['section'] as int,
      totalQuestions: json['total_questions'] as int,
      correctCount: json['correct_count'] as int,
      wrongCount: json['wrong_count'] as int,
      emptyCount: json['empty_count'] as int,
      totalScore: json['total_score'] as int,
      answers: (json['answers'] as List)
          .map((e) => QuizAnswer.fromJson(e as Map<String, dynamic>))
          .toList(),
      completedAt: DateTime.parse(json['completed_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'stage': stage,
    'section': section,
    'total_questions': totalQuestions,
    'correct_count': correctCount,
    'wrong_count': wrongCount,
    'empty_count': emptyCount,
    'total_score': totalScore,
    'answers': answers.map((e) => e.toJson()).toList(),
    'completed_at': completedAt.toIso8601String(),
  };
}
