import '../models/question.dart';

final List<Question> sampleQuestions = [
  Question(
    question: "What is Flutter?",
    options: ["Game Engine", "Programming Language", "UI Toolkit", "Database"],
    answerIndex: 2,
    category: "Programming & Computer Science",
  ),
  Question(
    question: "Which company developed Flutter?",
    options: ["Apple", "Google", "Microsoft", "Facebook"],
    answerIndex: 1,
    category: "Programming & Computer Science",
  ),
  Question(
    question: "Who discovered gravity?",
    options: ["Newton", "Einstein", "Tesla", "Galileo"],
    answerIndex: 0,
    category: "Science & Technology",
  ),
  Question(
    question: "Capital of France?",
    options: ["Paris", "Berlin", "Madrid", "Rome"],
    answerIndex: 0,
    category: "Geography",
  ),
  // Add more questions with proper categories
];
