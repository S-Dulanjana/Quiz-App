import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:quiz_app/screens/home_screen.dart';

void main() {
  runApp(const QuizSparkApp());
}

class QuizSparkApp extends StatelessWidget {
  const QuizSparkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuizSpark',
      theme: ThemeData(
        fontFamily: 'Arial',
        scaffoldBackgroundColor: const Color(
          0xFFE0F2FF,
        ), // light blue background
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  final Color primary = const Color(
    0xFF0DF26C,
  ); // You can keep primary green or change to blue

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            // LIGHT BLUE BACKGROUND GRADIENT
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFB3E5FC), // light blue
                    Color(0xFF81D4FA),
                    Color(0xFF4FC3F7),
                  ],
                ),
              ),
            ),

            // BLURRED CIRCLE
            Positioned(
              top: MediaQuery.of(context).size.height / 2 - 150,
              left: MediaQuery.of(context).size.width / 2 - 150,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                  child: const SizedBox(),
                ),
              ),
            ),

            // LOGO, TEXT, AND BUTTON
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // LOGO CIRCLE
                Container(
                  width: 128,
                  height: 128,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.5),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                    border: Border.all(
                      color: Colors.blue.withOpacity(0.5),
                      width: 2,
                    ),
                  ),
                  child: Icon(Icons.quiz, color: Colors.blue, size: 64),
                ),
                const SizedBox(height: 20),
                // APP NAME
                const Text(
                  "QuizSpark",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 8),
                // TAGLINE
                Text(
                  "Test Your Knowledge",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 30),

                // GET START BUTTON
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ), // existing HomeScreen
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    "Get Start",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            // LOADING BAR (optional)
            Positioned(
              bottom: 60,
              left: MediaQuery.of(context).size.width * 0.125,
              right: MediaQuery.of(context).size.width * 0.125,
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: FractionallySizedBox(
                  widthFactor: 0.4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
