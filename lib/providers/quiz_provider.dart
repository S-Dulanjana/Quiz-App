// lib/providers/quiz_provider.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/question.dart';
import '../data/sample_questions.dart';

class QuizProvider with ChangeNotifier {
  final List<Question> questions;
  int _currentIndex = 0;
  int _score = 0;
  bool _isAnswered = false;
  int? _selectedIndex;
  Timer? _timer;
  int _timeLeft = 10; // seconds per question
  int _highScore = 0;

  var correctAnswers;

  var incorrectAnswers;

  var timeTaken;

  QuizProvider({List<Question>? questions})
    : questions = questions ?? sampleQuestions {
    _loadHighScore();
    _startTimer();
  }

  int get currentIndex => _currentIndex;
  int get score => _score;
  bool get isAnswered => _isAnswered;
  int? get selectedIndex => _selectedIndex;
  int get timeLeft => _timeLeft;
  int get highScore => _highScore;
  int get totalQuestions => questions.length;
  Question get currentQuestion => questions[_currentIndex];

  void _startTimer() {
    _timer?.cancel();
    _timeLeft = 10;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_timeLeft > 0) {
        _timeLeft--;
        notifyListeners();
      } else {
        // auto move next when time's up
        t.cancel();
        _onTimeUp();
      }
    });
  }

  void _onTimeUp() {
    _isAnswered = true;
    _selectedIndex = null;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 800), nextQuestion);
  }

  void selectAnswer(int index) {
    if (_isAnswered) return;
    _isAnswered = true;
    _selectedIndex = index;
    if (index == currentQuestion.answerIndex) {
      _score++;
    }
    _timer?.cancel();
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 700), nextQuestion);
  }

  void nextQuestion() {
    _isAnswered = false;
    _selectedIndex = null;
    if (_currentIndex < questions.length - 1) {
      _currentIndex++;
      _startTimer();
    } else {
      _timer?.cancel();
      saveHighScoreIfNeeded();
      notifyListeners(); // final update for result screen
    }
    notifyListeners();
  }

  void restart() {
    _timer?.cancel();
    _currentIndex = 0;
    _score = 0;
    _isAnswered = false;
    _selectedIndex = null;
    _startTimer();
    notifyListeners();
  }

  bool get isFinished => _currentIndex >= questions.length - 1 && _isAnswered;

  Future<void> _loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    _highScore = prefs.getInt('highScore') ?? 0;
    notifyListeners();
  }

  Future<void> saveHighScoreIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    if (_score > _highScore) {
      _highScore = _score;
      await prefs.setInt('highScore', _highScore);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
