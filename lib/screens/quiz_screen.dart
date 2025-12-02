// lib/screens/quiz_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import 'result_screen.dart';
import 'home_screen.dart'; // ✅ Import HomeScreen

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFF1392EC);

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF101A22)
          : const Color(0xFFF6F7F8),
      body: SafeArea(
        child: Consumer<QuizProvider>(
          builder: (context, quiz, _) {
            // Navigate to result when finished
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
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // ================= HEADER =================
                  Row(
                    children: [
                      // ✅ FIXED CLOSE BUTTON
                      IconButton(
                        icon: const Icon(Icons.close),
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black87,
                        onPressed: () {
                          // Reset quiz state
                          quiz.restart();

                          // Navigate to HomeScreen
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomeScreen(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(width: 8),

                      // Progress & Question Count
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Question ${quiz.currentIndex + 1}/${quiz.totalQuestions}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: LinearProgressIndicator(
                                value: quiz.timeLeft / 10,
                                minHeight: 8,
                                color: primary,
                                backgroundColor:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.grey.shade800
                                    : Colors.grey.shade300,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Timer pill
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: primary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.timer, size: 18, color: primary),
                            const SizedBox(width: 5),
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

                  const SizedBox(height: 100),

                  // ================= QUESTION =================
                  Text(
                    q.question,
                    style: TextStyle(
                      fontSize: 32,
                      height: 1.3,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 50),

                  // ================= ANSWERS =================
                  Expanded(
                    child: ListView.builder(
                      itemCount: q.options.length,
                      itemBuilder: (context, i) {
                        final option = q.options[i];
                        final isSelected = quiz.selectedIndex == i;
                        final isCorrect = i == q.answerIndex;

                        Color border = Colors.grey.shade400;
                        Color background = Colors.white;
                        Widget? trailing;

                        if (Theme.of(context).brightness == Brightness.dark) {
                          background = Colors.grey.shade900;
                        }

                        if (quiz.isAnswered) {
                          if (isCorrect) {
                            border = Colors.green;
                            background = Colors.green.withOpacity(.15);
                            trailing = const Icon(
                              Icons.check,
                              color: Colors.green,
                            );
                          } else if (isSelected) {
                            border = Colors.red;
                            background = Colors.red.withOpacity(.15);
                            trailing = const Icon(
                              Icons.close,
                              color: Colors.red,
                            );
                          }
                        } else if (isSelected) {
                          border = primary;
                          background = primary.withOpacity(.12);
                        }

                        return GestureDetector(
                          onTap: quiz.isAnswered
                              ? null
                              : () => quiz.selectAnswer(i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: background,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: border, width: 1.5),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    option,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
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

                  // ================= FOOTER =================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Score: ${quiz.score}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
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
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18),
                            child: Text(
                              'Next',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
