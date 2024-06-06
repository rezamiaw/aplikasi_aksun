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
  bool answerChecked = false; // Added variable
  bool showErrorMessage = false; // Added variable
  int remainingTime = 444; // Set timer to 30 seconds
  Timer? timer;
  bool isPressedCheck = false; // Added variable for check button
  bool isPressedNext = false; // Added variable for next button

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

  void checkAnswer() {
    if (selectedAnswers.containsKey(currentQuestionIndex)) {
      setState(() {
        answerChecked = true;
        showErrorMessage = selectedAnswers[currentQuestionIndex] !=
            widget.questions[currentQuestionIndex]['answer'];
      });
    }
  }

  void nextQuestion() {
    if (currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        answerChecked = false; // Reset check status for new question
        showErrorMessage = false; // Reset error message for new question
      });
    } else {
      setState(() {
        showScoreboard = true;
        timer?.cancel(); // Stop the timer when showing scoreboard
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

  void _onButtonPressedCheck(bool pressed) {
    setState(() {
      isPressedCheck = pressed;
    });
  }

  void _onButtonPressedNext(bool pressed) {
    setState(() {
      isPressedNext = pressed;
    });
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
                title: 'POINT',
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

    int crossAxisCount = currentQuestion['mode'] == '2x2' ? 2 : 1;

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
            padding: const EdgeInsets.fromLTRB(30, 15, 30, 25),
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
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: crossAxisCount == 2
                              ? constraints.maxWidth / constraints.maxHeight
                              : constraints.maxWidth /
                                  50, // Set height to 50 for 1x4 mode
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                        ),
                        itemCount: currentQuestion['options'].length,
                        itemBuilder: (context, index) {
                          var option = currentQuestion['options'][index];
                          bool isCorrect = option == currentQuestion['answer'];
                          bool isSelected =
                              selectedAnswers[currentQuestionIndex] == option;

                          return GestureDetector(
                            onTap: () {
                              if (!answerChecked) {
                                setState(() {
                                  selectedAnswers[currentQuestionIndex] =
                                      option;
                                });
                              }
                            },
                            child: Container(
                              height: currentQuestion['mode'] == '1x4'
                                  ? 50
                                  : constraints.maxHeight /
                                      2, // Set height based on mode
                              decoration: BoxDecoration(
                                color: answerChecked
                                    ? isCorrect
                                        ? Colors.green.withOpacity(0.5)
                                        : isSelected
                                            ? Colors.red.withOpacity(0.5)
                                            : Colors.white
                                    : isSelected
                                        ? bluesoft.withOpacity(0.5)
                                        : Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                border:
                                    Border.all(color: whitesoft, width: 1.0),
                              ),
                              child: Center(
                                child: Text(
                                  option,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: answerChecked
                                        ? isCorrect
                                            ? Colors.green
                                            : isSelected
                                                ? Colors.red
                                                : Colors.black
                                        : isSelected
                                            ? bluesoft
                                            : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (answerChecked)
                      Text(
                        showErrorMessage ? 'KAMU SALAH!' : 'KAMU BENAR!',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "InterSemiBold",
                          color: showErrorMessage ? red : greenColor,
                        ),
                      ),
                    SizedBox(height: 8.0), // Add some spacing
                    GestureDetector(
                      onTapDown: (_) => answerChecked
                          ? _onButtonPressedNext(true)
                          : _onButtonPressedCheck(true),
                      onTapUp: (_) {
                        if (answerChecked) {
                          _onButtonPressedNext(false);
                          nextQuestion();
                        } else {
                          _onButtonPressedCheck(false);
                          checkAnswer();
                        }
                      },
                      onTapCancel: () {
                        answerChecked
                            ? _onButtonPressedNext(false)
                            : _onButtonPressedCheck(false);
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: selectedAnswers
                                  .containsKey(currentQuestionIndex)
                              ? (showErrorMessage ? red : greenColor)
                              : Colors
                                  .grey, // Background color based on condition
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: (isPressedCheck && !answerChecked) ||
                                  (isPressedNext && answerChecked)
                              ? []
                              : [
                                  BoxShadow(
                                    color: selectedAnswers
                                            .containsKey(currentQuestionIndex)
                                        ? (showErrorMessage
                                            ? darkred
                                            : darkgreenColor)
                                        : Colors
                                            .black45, // Shadow color based on condition
                                    offset: Offset(0, 4), // Shadow position
                                  ),
                                ],
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        child: Center(
                          child: Text(
                            answerChecked ? 'SELANJUTNYA' : 'PERIKSA',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "InterSemiBold",
                              color: Colors.white, // Text color
                            ),
                          ),
                        ),
                      ),
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
