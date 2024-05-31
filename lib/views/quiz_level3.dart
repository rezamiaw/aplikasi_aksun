import 'package:aplikasi_aksun/views/bank_soal.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_aksun/widgets/quiz_content.dart';
import 'package:aplikasi_aksun/utils/colors.dart';

class QuizLevel3Page extends StatefulWidget {
  QuizLevel3Page({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> questions = getLevelQuestions(3, "expert");

  @override
  _QuizLevel3PageState createState() => _QuizLevel3PageState();
}

class _QuizLevel3PageState extends State<QuizLevel3Page> {
  int remainingTime = 30;

  void updateRemainingTime(int time) {
    setState(() {
      remainingTime = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Level 3'),
        ),
        body: Center(
          child: Text('No questions available for this level and category.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: Container(
          decoration: BoxDecoration(
            color: greenColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(8),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Level 3',
              style: TextStyle(
                color: Colors.black,
                fontFamily: "InterSemiBold",
                fontSize: 20,
              ),
            ),
            Row(
              children: [
                Image.asset(
                  'assets/images/timer.png', // Path to your timer image asset
                  width: 24, // Adjust size as needed
                  height: 24,
                ),
                SizedBox(width: 5),
                Text(
                  '$remainingTime s',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "InterBold",
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: QuizContent(
        level: 3,
        questions: widget.questions,
        updateRemainingTime: updateRemainingTime,
      ),
    );
  }
}