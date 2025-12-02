class Question {
  final String question;
  final List<String> options;
  final int answerIndex;
  final String category; // <-- new field

  Question({
    required this.question,
    required this.options,
    required this.answerIndex,
    required this.category,
  });
}
