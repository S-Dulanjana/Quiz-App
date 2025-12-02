// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuizProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz App')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Welcome to the Flutter Quiz',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Questions: ${provider.totalQuestions}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Consumer<QuizProvider>(
              builder: (_, p, __) => Text('High Score: ${p.highScore}'),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                provider.restart();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const QuizScreen()),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
                child: Text('Start Quiz', style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
