import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:path_earn_app/features/quiz/data/models/question_model.dart';
import 'package:path_earn_app/features/quiz/data/models/quiz_result_model.dart';
import 'package:path_earn_app/features/quiz/data/services/quiz_service.dart';

class QuizController extends GetxController {
  final QuizService _quizService = QuizService();

  // Quiz state
  RxList<Question> questions = <Question>[].obs;
  RxInt currentQuestionIndex = 0.obs;
  RxInt stage = 1.obs;
  RxInt section = 1.obs;

  // Answer tracking
  RxList<int?> selectedAnswers = <int?>[].obs; // null = not answered
  RxList<int> confirmCount = <int>[].obs; // count how many times confirmed

  // Loading state
  RxBool isLoading = false.obs;
  RxBool isSubmitting = false.obs;

  // Quiz result
  late QuizResult? quizResult;

  @override
  void onInit() {
    super.onInit();
    print('🎯 QuizController initializing...');
    loadQuizQuestions();
  }

  Future<void> loadQuizQuestions() async {
    try {
      isLoading.value = true;
      print('📚 Loading quiz questions...');

      // Load mock quiz data (Stage 1, Section 1)
      final fetchedQuestions = _quizService.getMockQuizQuestions();
      print('✅ Fetched ${fetchedQuestions.length} questions');

      questions.value = fetchedQuestions;
      print('✅ Questions assigned to controller');

      // Initialize answer tracking
      selectedAnswers.value = List<int?>.filled(fetchedQuestions.length, null);
      confirmCount.value = List<int>.filled(fetchedQuestions.length, 0);
      print('✅ Answer tracking initialized');

      isLoading.value = false;
      print('✅ Quiz loaded successfully!');
    } catch (e) {
      isLoading.value = false;
      print('❌ Error loading quiz: $e');
      Get.snackbar('Error', 'Failed to load quiz questions: $e');
    }
  }

  // Select an answer
  void selectAnswer(int answerIndex) {
    if (currentQuestionIndex.value < selectedAnswers.length) {
      selectedAnswers[currentQuestionIndex.value] = answerIndex;
      selectedAnswers.refresh();
    }
  }

  // Confirm answer (second click)
  void confirmAnswer() {
    if (currentQuestionIndex.value < confirmCount.length) {
      confirmCount[currentQuestionIndex.value]++;

      // Move to next question after confirm
      if (currentQuestionIndex.value < questions.length - 1) {
        currentQuestionIndex.value++;
      } else {
        // All questions answered, show submit dialog
        _showSubmitDialog();
      }
    }
  }

  // Move to next question
  void nextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
    }
  }

  // Move to previous question
  void previousQuestion() {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;
    }
  }

  // Calculate quiz results
  QuizResult calculateResults() {
    int correctCount = 0;
    int wrongCount = 0;
    int emptyCount = 0;
    int totalScore = 0;
    List<QuizAnswer> answers = [];

    for (int i = 0; i < questions.length; i++) {
      final question = questions[i];
      final selectedIndex = selectedAnswers[i];

      if (selectedIndex == null) {
        // Not answered
        emptyCount++;
        answers.add(
          QuizAnswer(
            questionId: question.id,
            selectedAnswerIndex: -1,
            isCorrect: false,
            earnedPoints: 0,
          ),
        );
      } else if (selectedIndex == question.correctAnswerIndex) {
        // Correct answer
        correctCount++;
        totalScore += question.points;
        answers.add(
          QuizAnswer(
            questionId: question.id,
            selectedAnswerIndex: selectedIndex,
            isCorrect: true,
            earnedPoints: question.points,
          ),
        );
      } else {
        // Wrong answer
        wrongCount++;
        answers.add(
          QuizAnswer(
            questionId: question.id,
            selectedAnswerIndex: selectedIndex,
            isCorrect: false,
            earnedPoints: 0,
          ),
        );
      }
    }

    return QuizResult(
      stage: stage.value,
      section: section.value,
      totalQuestions: questions.length,
      correctCount: correctCount,
      wrongCount: wrongCount,
      emptyCount: emptyCount,
      totalScore: totalScore,
      answers: answers,
      completedAt: DateTime.now(),
    );
  }

  // Submit quiz
  Future<void> submitQuiz() async {
    try {
      isSubmitting.value = true;

      final userId = _quizService.getCurrentUserId();
      if (userId == null) {
        Get.snackbar('Error', 'User not logged in');
        isSubmitting.value = false;
        return;
      }

      // Calculate results
      quizResult = calculateResults();

      // Save to database
      await _quizService.saveQuizResult(userId, quizResult!);

      // Update user progress
      await _quizService.updateUserProgress(
        userId,
        stage.value,
        section.value,
        quizResult!.scorePercentage,
      );

      isSubmitting.value = false;

      // Navigate to score page with result
      Get.offNamed(
        '/score',
        arguments: {'quizResult': quizResult, 'questions': questions},
      );
    } catch (e) {
      isSubmitting.value = false;
      Get.snackbar('Error', 'Failed to submit quiz: $e');
      print('Error submitting quiz: $e');
    }
  }

  void _showSubmitDialog() {
    Get.defaultDialog(
      title: 'Selesaikan Quiz?',
      content: const Text(
        'Anda sudah menjawab semua pertanyaan. Apakah Anda yakin ingin menyelesaikan quiz ini?',
      ),
      confirm: ElevatedButton(
        onPressed: () {
          Get.back();
          submitQuiz();
        },
        child: const Text('Ya, Selesaikan'),
      ),
      cancel: ElevatedButton(
        onPressed: () => Get.back(),
        child: const Text('Batal'),
      ),
    );
  }

  // Get current question
  Question? get currentQuestion {
    if (currentQuestionIndex.value < questions.length) {
      return questions[currentQuestionIndex.value];
    }
    return null;
  }

  // Get current selected answer
  int? get currentSelectedAnswer {
    if (currentQuestionIndex.value < selectedAnswers.length) {
      return selectedAnswers[currentQuestionIndex.value];
    }
    return null;
  }

  // Check if current answer is confirmed
  bool get isCurrentAnswerConfirmed {
    if (currentQuestionIndex.value < confirmCount.length) {
      return confirmCount[currentQuestionIndex.value] > 0;
    }
    return false;
  }

  // Progress percentage
  double get progressPercentage =>
      (currentQuestionIndex.value + 1) / questions.length;
}
