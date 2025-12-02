// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/screens/start_screen.dart';
import 'providers/quiz_provider.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Quiz',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: const QuizSparkApp(),
      ),
    );
  }
}
