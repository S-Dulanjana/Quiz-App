// lib/data/sample_questions.dart
import '../models/question.dart';

final List<Question> sampleQuestions = [
  Question(
    question: "What is Flutter?",
    options: ["Game Engine", "Programming Language", "UI Toolkit", "Database"],
    answerIndex: 2,
  ),
  Question(
    question: "Which company developed Flutter?",
    options: ["Apple", "Google", "Microsoft", "Facebook"],
    answerIndex: 1,
  ),
  Question(
    question: "Dart is mainly used for?",
    options: [
      "Web backend",
      "System drivers",
      "Client apps (mobile/web)",
      "Databases",
    ],
    answerIndex: 2,
  ),
  Question(
    question: "Which widget is used for layouts in Flutter?",
    options: ["Container", "Column/Row", "Text", "Icon"],
    answerIndex: 1,
  ),
  Question(
    question: "Which method builds the widget tree?",
    options: ["initState", "build", "dispose", "createState"],
    answerIndex: 1,
  ),
];
