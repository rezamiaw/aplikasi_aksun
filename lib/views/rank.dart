import 'package:flutter/material.dart';

class RankView extends StatelessWidget {
  const RankView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; // Disable back button
      },
      child: Scaffold(
        body: Center(
          child: Text("Peringkat"),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RankView(),
  ));
}
