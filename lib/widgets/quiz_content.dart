import 'package:aplikasi_aksun/utils/colors.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class QuizContent extends StatefulWidget {
  final int level;
  final List<Map<String, dynamic>> questions;
  final Function(int) updateRemainingTime;

  const QuizContent({
    required this.level,
    required this.questions,
    required this.updateRemainingTime,
  });

  @override
  _QuizContentState createState() => _QuizContentState();
}

class _QuizContentState extends State<QuizContent> {
  int currentQuestionIndex = 0;
  Map<int, String> selectedAnswers = {};
  bool showScoreboard = false;
  int remainingTime = 30; // Set timer to 30 seconds
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (remainingTime > 0) {
            remainingTime--;
            widget.updateRemainingTime(
                remainingTime); // Update remaining time in parent widget
          } else {
            showScoreboard = true;
            timer.cancel();
          }
        });
      }
    });
  }

  void nextQuestion() {
    if (currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      setState(() {
        showScoreboard = true;
        timer?.cancel(); // Stop the timer when showing scoreboard
      });
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  int calculateCorrectAnswers() {
    int correct = 0;
    for (int i = 0; i < widget.questions.length; i++) {
      if (selectedAnswers[i] == widget.questions[i]['answer']) {
        correct++;
      }
    }
    return correct;
  }

  @override
  Widget build(BuildContext context) {
    if (showScoreboard) {
      int correctAnswers = calculateCorrectAnswers();
      int incorrectAnswers = widget.questions.length - correctAnswers;
      double score = (correctAnswers / widget.questions.length) * 100;

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/thumbsup.png', // Path to your image asset
            ),
            SizedBox(height: 10), // Spacing between image and text
            Text(
              'Congratulations!',
              style: TextStyle(
                fontSize: 24,
                fontFamily: "InterSemiBold",
              ),
            ),
            SizedBox(height: 10), // Spacing between text and scoreboard
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ScoreCard(
                    title: 'BENAR',
                    value: correctAnswers.toString(),
                    borderColor: Colors.green,
                    textColor: Colors.green,
                    backgroundColor: Colors.green,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ScoreCard(
                    title: 'SALAH',
                    value: incorrectAnswers.toString(),
                    borderColor: Colors.red,
                    textColor: Colors.red,
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ScoreCard(
                title: 'NILAI',
                value: score.toStringAsFixed(0),
                borderColor: Colors.yellow,
                textColor: Colors.yellow,
                backgroundColor: Colors.yellow,
              ),
            ),
            SizedBox(height: 32), // Add some spacing before the button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  currentQuestionIndex = 0;
                  selectedAnswers.clear();
                  showScoreboard = false;
                  remainingTime = 30; // Reset timer
                  startTimer(); // Restart timer
                });
              },
              child: Text('Mulai Lagi'),
            ),
          ],
        ),
      );
    }

    var currentQuestion = widget.questions[currentQuestionIndex];
    double progress = (currentQuestionIndex + 1) / widget.questions.length;

    BorderRadius borderRadius =
        currentQuestionIndex == widget.questions.length - 1
            ? BorderRadius.zero
            : BorderRadius.only(
                topRight: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              );

    return Column(
      children: [
        ClipRRect(
          borderRadius: borderRadius,
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: whitesoft,
            color: greenColor,
            minHeight: 8,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    currentQuestion['question'],
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                ...List.generate(currentQuestion['options'].length, (index) {
                  var option = currentQuestion['options'][index];
                  return RadioListTile(
                    title: Text(option),
                    value: option,
                    groupValue: selectedAnswers[currentQuestionIndex],
                    onChanged: (value) {
                      setState(() {
                        selectedAnswers[currentQuestionIndex] = value as String;
                      });
                    },
                  );
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: previousQuestion,
                      child: Text('Previous'),
                    ),
                    ElevatedButton(
                      onPressed: nextQuestion,
                      child: Text('Next'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ScoreCard extends StatelessWidget {
  final String title;
  final String value;
  final Color borderColor;
  final Color textColor;
  final Color backgroundColor;

  const ScoreCard({
    Key? key,
    required this.title,
    required this.value,
    required this.borderColor,
    required this.textColor,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor, width: 1),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity, // Full width
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontFamily: "InterSemiBold"),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                value,
                style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                    fontFamily: "InterSemiBold"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
