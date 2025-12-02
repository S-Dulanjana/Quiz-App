// lib/screens/quiz_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        leading: BackButton(
          onPressed: () {
            Provider.of<QuizProvider>(context, listen: false).restart();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Consumer<QuizProvider>(
        builder: (context, quiz, _) {
          // If finished and last question answered, go to result
          if (quiz.currentIndex == quiz.totalQuestions - 1 && quiz.isAnswered) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const ResultScreen()),
              );
            });
          }

          final q = quiz.currentQuestion;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Question ${quiz.currentIndex + 1}/${quiz.totalQuestions}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: quiz.timeLeft / 10,
                  minHeight: 8,
                ),
                const SizedBox(height: 10),
                Text(
                  'Time left: ${quiz.timeLeft}s',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 20),
                Text(
                  q.question,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ...List.generate(q.options.length, (i) {
                  final option = q.options[i];
                  final isSelected = quiz.selectedIndex == i;
                  final isCorrect = i == q.answerIndex;
                  Color? tileColor;

                  if (quiz.isAnswered) {
                    if (isCorrect) {
                      tileColor = Colors.green[200];
                    } else if (isSelected && !isCorrect) {
                      tileColor = Colors.red[200];
                    } else {
                      tileColor = null;
                    }
                  }

                  return Card(
                    color: tileColor,
                    child: ListTile(
                      onTap: () => quiz.selectAnswer(i),
                      title: Text(option),
                      trailing: quiz.isAnswered && isCorrect
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : quiz.isAnswered && isSelected && !isCorrect
                          ? const Icon(Icons.cancel, color: Colors.red)
                          : null,
                    ),
                  );
                }),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Score: ${quiz.score}'),
                    ElevatedButton(
                      onPressed: () {
                        if (quiz.currentIndex < quiz.totalQuestions - 1) {
                          quiz.nextQuestion();
                        } else {
                          quiz.saveHighScoreIfNeeded(); // ignore: invalid_use_of_protected_member
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => const ResultScreen(),
                            ),
                          );
                        }
                      },
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
