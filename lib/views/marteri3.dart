import 'package:aplikasi_aksun/utils/colors.dart';
import 'package:flutter/material.dart';

class AksaraAngkaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          decoration: BoxDecoration(
            color: greenColor
                .withOpacity(0.3), // Set the background color to green
            borderRadius:
                BorderRadius.circular(10), // Add some border radius to the icon
          ),
          margin: EdgeInsets.all(8), // Adds some margin around the icon
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: Text(
          'Aksara Angka',
          style: TextStyle(
              color: Colors.black, fontFamily: "InterSemiBold", fontSize: 20),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Text('Content for Aksara Swara'),
      ),
    );
  }
}
