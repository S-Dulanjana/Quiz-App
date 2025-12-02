// lib/screens/quiz_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color primary = const Color(0xFF1392EC);

    return Scaffold(
      body: SafeArea(
        child: Consumer<QuizProvider>(
          builder: (context, quiz, _) {
            // Navigate to result if finished
            if (quiz.currentIndex == quiz.totalQuestions - 1 &&
                quiz.isAnswered) {
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
                children: [
                  // Header: Question + Progress + Timer
                  Row(
                    children: [
                      const Icon(Icons.close, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Question ${quiz.currentIndex + 1}/${quiz.totalQuestions}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            LinearProgressIndicator(
                              value: quiz.timeLeft / 10,
                              minHeight: 8,
                              color: primary,
                              backgroundColor: Colors.grey.shade300,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: primary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.timer, color: primary, size: 20),
                            const SizedBox(width: 4),
                            Text(
                              "${quiz.timeLeft}s",
                              style: TextStyle(
                                color: primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Question Text
                  Text(
                    q.question,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Options
                  Expanded(
                    child: ListView.builder(
                      itemCount: q.options.length,
                      itemBuilder: (context, i) {
                        final option = q.options[i];
                        final isSelected = quiz.selectedIndex == i;
                        final isCorrect = i == q.answerIndex;

                        Color? bgColor;
                        Color borderColor = Colors.grey.shade400;
                        Widget? trailing;

                        if (quiz.isAnswered) {
                          if (isCorrect) {
                            bgColor = Colors.green.withOpacity(0.2);
                            borderColor = Colors.green;
                            trailing = const Icon(
                              Icons.check,
                              color: Colors.green,
                              size: 20,
                            );
                          } else if (isSelected && !isCorrect) {
                            bgColor = Colors.red.withOpacity(0.2);
                            borderColor = Colors.red;
                            trailing = const Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 20,
                            );
                          } else {
                            bgColor =
                                Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey.shade800
                                : Colors.white;
                          }
                        } else {
                          bgColor = isSelected
                              ? primary.withOpacity(0.1)
                              : Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey.shade800
                              : Colors.white;
                          borderColor = isSelected
                              ? primary
                              : Colors.grey.shade400;
                        }

                        return GestureDetector(
                          onTap: quiz.isAnswered
                              ? null
                              : () => quiz.selectAnswer(i),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: borderColor),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    option,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black87,
                                    ),
                                  ),
                                ),
                                if (trailing != null) trailing,
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Bottom Row: Score + Next Button
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Score: ${quiz.score}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            if (quiz.currentIndex < quiz.totalQuestions - 1) {
                              quiz.nextQuestion();
                            } else {
                              quiz.saveHighScoreIfNeeded();
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => const ResultScreen(),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            'Next',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
