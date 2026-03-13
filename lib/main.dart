import 'package:flutter/material.dart';

void main() {
  runApp(FlashcardQuizApp());
}

class FlashcardQuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcard Quiz - Quiz Mode',
      debugShowCheckedModeBanner: false,
      home: QuizHome(),
    );
  }
}

class Flashcard {
  String question;
  String answer;
  Flashcard({required this.question, required this.answer});
}

class QuizHome extends StatefulWidget {
  @override
  _QuizHomeState createState() => _QuizHomeState();
}

class _QuizHomeState extends State<QuizHome> {
  List<Flashcard> cards = [
    Flashcard(question: 'What is the capital of Pakistan?', answer: 'Islamabad'),
    Flashcard(question: 'Flutter is developed by?', answer: 'Google'),
    Flashcard(question: 'What is 2 + 2?', answer: '4'),
  ];

  int currentIndex = 0;
  TextEditingController _answerController = TextEditingController();
  String resultMessage = '';

  void checkAnswer() {
    String userAnswer = _answerController.text.trim();
    String correctAnswer = cards[currentIndex].answer.trim();
    setState(() {
      if (userAnswer.toLowerCase() == correctAnswer.toLowerCase()) {
        resultMessage = '✅ Correct!';
      } else {
        resultMessage = '❌ Incorrect! Answer: $correctAnswer';
      }
    });
  }

  void nextCard() {
    if (currentIndex < cards.length - 1) {
      setState(() {
        currentIndex++;
        _answerController.clear();
        resultMessage = '';
      });
    } else {
      setState(() {
        resultMessage = '🎉 Quiz Finished!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final card = cards[currentIndex];
    return Scaffold(
      appBar: AppBar(title: Text('Flashcard Quiz - Quiz Mode')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('Question ${currentIndex + 1}/${cards.length}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(card.question, style: TextStyle(fontSize: 22)),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _answerController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Your Answer'),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: checkAnswer, child: Text('Submit Answer')),
            SizedBox(height: 20),
            Text(resultMessage, style: TextStyle(fontSize: 18, color: Colors.blue)),
            SizedBox(height: 20),
            ElevatedButton(onPressed: nextCard, child: Text('Next Question')),
          ],
        ),
      ),
    );
  }
}
