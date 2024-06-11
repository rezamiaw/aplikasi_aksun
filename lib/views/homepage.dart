import 'package:aplikasi_aksun/utils/colors.dart';
import 'package:aplikasi_aksun/views/marteri3.dart';
import 'package:aplikasi_aksun/views/materi1.dart';
import 'package:aplikasi_aksun/views/materi2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aplikasi_aksun/views/quiz_page.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final List<Map<String, String>> aksaraList = [
    {"title": "Aksara \nSwara"},
    {"title": "Aksara \nNgalagena"},
    {"title": "Aksara \nAngka"},
  ];

  final List<Color> aksaraColors = [
    greenlightColor,
    bluelightColor,
    redlightColor,
  ];

  final List<Color> aksaraColorsbackground = [
    greenlightColor.withOpacity(0.5),
    bluelightColor.withOpacity(0.5),
    redlightColor.withOpacity(0.5),
  ];

  final List<Map<String, String>> levelList = [
    {"level": "Level 1", "questions": "10 Soal", "difficulty": "Easy"},
    {"level": "Level 2", "questions": "15 Soal", "difficulty": "Medium"},
    {"level": "Level 3", "questions": "20 Soal", "difficulty": "Hard"},
  ];

  String? userName;

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      setState(() {
        userName = userDoc['name'] ?? "User";
      });
    } else {
      setState(() {
        userName = "User";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userName == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(userName!),
                  _buildMateriSection(),
                  _buildQuizSection(),
                  SizedBox(height: 100), // Add some space at the bottom
                ],
              ),
            ),
    );
  }

  Widget _buildHeader(String userName) {
    return Stack(
      children: [
        Container(
          height: 216,
          color: greenColor, // Set your desired background color
        ),
        Positioned(
          top: 21, // Adjusted top position to 21
          right: -45,
          child: SvgPicture.asset(
            'assets/images/ilustrasi.svg',
            width: 201.5, // Adjust the width as needed
            height: 178.17, // Adjust the height as needed
          ),
        ),
        Positioned(
          top: 96, // Adjusted top position to 96
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 30.0), // Add padding left and right
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, $userName! 👋',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "InterSemibold",
                    color: Colors
                        .white, // Set text color to contrast the background
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Apa yang ingin kamu pelajari \nhari ini?',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontFamily: "InterRegular",
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMateriSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Materi',
              style: TextStyle(
                fontSize: 16,
                fontFamily: "InterSemibold",
                color: fontGrayDarkColor, // Set the text color
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(30, 11, 15, 13),
          child: Row(
            children: List.generate(aksaraList.length, (index) {
              return GestureDetector(
                onTap: () {
                  switch (index) {
                    case 0:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AksaraSwaraPage()),
                      );
                      break;
                    case 1:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AksaraNgalagenaPage()),
                      );
                      break;
                    case 2:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AksaraAngkaPage()),
                      );
                      break;
                  }
                },
                child: Container(
                  width: 134,
                  height: 118,
                  margin: const EdgeInsets.only(
                      right: 16), // Add margin between items
                  padding: const EdgeInsets.fromLTRB(10, 14, 11, 8),
                  decoration: BoxDecoration(
                    color: aksaraColors[index],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          aksaraList[index]['title']!,
                          style: TextStyle(
                            fontFamily: "InterMedium",
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(1000),
                          ),
                          child: SvgPicture.asset(
                            'assets/icons/Arrow - Right.svg',
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildQuizSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Kuis',
              style: TextStyle(
                fontSize: 16,
                fontFamily: "InterSemibold",
                color: fontGrayDarkColor, // Set the text color
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          child: Column(
            children: List.generate(levelList.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                child: GestureDetector(
                  onTap: () {
                    _showQuizConfirmationDialog(context, index);
                  },
                  child: Container(
                    width: 350, // Adjust the width as needed
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: aksaraColors[index],
                                borderRadius: BorderRadius.circular(1000),
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontFamily: "FredokaBold",
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  levelList[index]['level']!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "InterSemibold",
                                    color: fontGrayDarkColor,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  levelList[index]['questions']!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "InterRegular",
                                    color: fontGrayLightColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: aksaraColorsbackground[index],
                            borderRadius: BorderRadius.circular(1000),
                          ),
                          child: Text(
                            levelList[index]['difficulty']!,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "InterRegular",
                              color: aksaraColors[index],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  void _showQuizConfirmationDialog(BuildContext context, int index) {
    String level = levelList[index]['level']!;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            children: [
              Icon(Icons.quiz, color: greenColor),
              SizedBox(width: 10),
              Text(
                "Mulai Kuis",
                style: TextStyle(fontFamily: "InterSemiBold"),
              ),
            ],
          ),
          content: Text(
            "Apakah Anda siap untuk memulai $level?",
            style: TextStyle(fontFamily: "InterRegular"),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text("Batal"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: greenColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text("Mulai"),
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToQuizLevel(context, index);
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToQuizLevel(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => QuizPage(level: 1, category: "basic")),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => QuizPage(level: 2, category: "advanced")),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => QuizPage(level: 3, category: "expert")),
        );
        break;
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePageView(),
  ));
}
