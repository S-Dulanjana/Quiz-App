// lib/screens/result_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuizProvider>(context, listen: false);
    final score = provider.score;
    final total = provider.totalQuestions;
    final highScore = provider.highScore;

    return Scaffold(
      appBar: AppBar(title: const Text('Result')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Text('Your Score', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            Text(
              '$score / $total',
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'High Score: $highScore',
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                provider.restart();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const QuizScreenWrapper()),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
                child: Text('Retry Quiz', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () {
                provider.restart();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              },
              child: const Text('Back to Home'),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// Wrapper to avoid import cycle with home -> quiz -> result
class QuizScreenWrapper extends StatelessWidget {
  const QuizScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Center(child: Text(''))),
    );
  }
}
