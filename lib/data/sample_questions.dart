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
  Question(
    question: "What is the purpose of the setState() method?",
    options: [
      "Initialize variables",
      "Rebuild widget with updated state",
      "Dispose widget",
      "Navigate to another screen",
    ],
    answerIndex: 1,
  ),
  Question(
    question: "Which widget allows scrolling in Flutter?",
    options: ["Column", "ListView", "Stack", "Row"],
    answerIndex: 1,
  ),
  Question(
    question: "What is a StatelessWidget?",
    options: [
      "Widget with mutable state",
      "Widget with no state changes",
      "Widget that can be updated dynamically",
      "Widget only for animations",
    ],
    answerIndex: 1,
  ),
  Question(
    question: "Which widget is used for user input?",
    options: ["TextField", "Text", "Button", "Container"],
    answerIndex: 0,
  ),
  Question(
    question: "What is hot reload in Flutter?",
    options: [
      "Restarting the app completely",
      "Updating code and UI instantly without full restart",
      "Refreshing the backend",
      "Updating only the theme",
    ],
    answerIndex: 1,
  ),
  Question(
    question: "Which widget overlays children on top of each other?",
    options: ["Column", "Row", "Stack", "Container"],
    answerIndex: 2,
  ),
  Question(
    question: "Which property is used to change text style in a Text widget?",
    options: ["font", "style", "decoration", "theme"],
    answerIndex: 1,
  ),
  Question(
    question: "What is the main entry point of a Flutter app?",
    options: ["main()", "initState()", "build()", "runApp()"],
    answerIndex: 3,
  ),
  Question(
    question: "Which widget is used to detect gestures?",
    options: ["GestureDetector", "InkWell", "Listener", "All of the above"],
    answerIndex: 3,
  ),
  Question(
    question: "Which widget allows stacking of widgets with alignment?",
    options: ["Stack", "Column", "Row", "Align"],
    answerIndex: 0,
  ),
];
