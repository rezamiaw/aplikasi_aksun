import 'package:aplikasi_aksun/views/bank_soal.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_aksun/widgets/quiz_content.dart';
import 'package:aplikasi_aksun/utils/colors.dart';

class QuizPage extends StatefulWidget {
  final int level;
  final String category;

  QuizPage({Key? key, required this.level, required this.category})
      : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late List<Map<String, dynamic>> questions;
  int remainingTime = 30;
  bool showScoreboard = false;

  @override
  void initState() {
    super.initState();
    questions = getLevelQuestions(widget.level, widget.category);
  }

  void updateRemainingTime(int time) {
    setState(() {
      remainingTime = time;
    });
  }

  void updateScoreboard(bool show) {
    setState(() {
      showScoreboard = show;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Level ${widget.level}'),
        ),
        body: Center(
          child: Text('No questions available for this level and category.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: showScoreboard
            ? Container()
            : Container(
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
        title: showScoreboard
            ? Container()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Level ${widget.level}',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "InterSemiBold",
                      fontSize: 20,
                    ),
                  ),
                  if (!showScoreboard)
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/timer.png',
                          width: 24,
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
        level: widget.level,
        questions: questions,
        updateRemainingTime: updateRemainingTime,
        updateScoreboard: updateScoreboard,
      ),
    );
  }
}
