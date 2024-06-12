import 'package:aplikasi_aksun/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RankView extends StatefulWidget {
  const RankView({super.key});

  @override
  _RankViewState createState() => _RankViewState();
}

class _RankViewState extends State<RankView> {
  Map<String, List<Map<String, dynamic>>> rankData = {
    'Level 1': [],
    'Level 2': [],
    'Level 3': []
  };
  String selectedLevel = 'Level 1';

  @override
  void initState() {
    super.initState();
    _fetchRankData();
  }

  Future<void> _fetchRankData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('quiz_results')
        .orderBy('points', descending: true)
        .get();

    Map<String, List<Map<String, dynamic>>> fetchedRankData = {
      'Level 1': [],
      'Level 2': [],
      'Level 3': []
    };

    for (var doc in querySnapshot.docs) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(doc['user_id'])
          .get();

      Map<String, dynamic> userData = {
        "name": userDoc['name'],
        "level": doc['level'],
        "points": doc['points'].toInt(), // Convert points to integer
        "timer": doc['timer'],
      };

      fetchedRankData['Level ${doc['level']}']?.add(userData);
    }

    setState(() {
      rankData = fetchedRankData;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double buttonWidth = screenWidth * 0.28; // 28% of screen width
    double buttonHeight = screenHeight * 0.05; // 5% of screen height
    double fontSize = screenWidth * 0.04; // 4% of screen width

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0, // Set the height to 0 to hide the AppBar
        elevation: 0,
      ),
      body: rankData['Level 1']!.isEmpty &&
              rankData['Level 2']!.isEmpty &&
              rankData['Level 3']!.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/peringkat.png', // Path to your image
                        width: screenWidth * 0.5, // Adjust the width as needed
                      ),
                      Text(
                        'Liga Superior',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'InterBold',
                          color: greenColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Text(
                          'Top 5 Peringkat terbaik berdasarkan kategori level',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'InterRegular',
                            color: fontGrayLightColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildLevelButton('Level 1', buttonWidth,
                              buttonHeight, fontSize, context),
                          _buildLevelButton('Level 2', buttonWidth,
                              buttonHeight, fontSize, context),
                          _buildLevelButton('Level 3', buttonWidth,
                              buttonHeight, fontSize, context),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _buildRankList(selectedLevel),
                ),
              ],
            ),
    );
  }

  Widget _buildLevelButton(String level, double width, double height,
      double fontSize, BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              selectedLevel = level;
            });
          },
          child: Text(level, style: TextStyle(fontSize: fontSize)),
          style: ElevatedButton.styleFrom(
            primary: selectedLevel == level ? greenColor : grayColor,
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRankList(String level) {
    List<Map<String, dynamic>> levelData = rankData[level] ?? [];
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: levelData.isEmpty
          ? Center(
              child: Text('No data available for $level'),
            )
          : ListView.builder(
              itemCount: levelData.length > 5 ? 5 : levelData.length,
              itemBuilder: (context, index) {
                var data = levelData[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text(data['name']),
                  subtitle: Text(
                      'Points: ${data['points'].toInt()}, Waktu: ${data['timer']}s'), // Convert points to integer
                );
              },
            ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RankView(),
  ));
}
