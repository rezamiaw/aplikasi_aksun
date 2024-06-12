import 'package:aplikasi_aksun/utils/colors.dart';
import 'package:flutter/material.dart';

class AksaraSwaraPage extends StatelessWidget {
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
          'Aksara Swara',
          style: TextStyle(
              color: Colors.black, fontFamily: "InterSemiBold", fontSize: 20),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pengertian',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "InterSemiBold",
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Aksara swara adalah huruf-huruf yang mewakili bunyi vokal dalam aksara Sunda. Huruf-huruf ini digunakan untuk menuliskan vokal yang berdiri sendiri tanpa konsonan pendamping.',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "InterMedium",
                    color: fontGrayLightColor),
              ),
              SizedBox(height: 8),
              Text(
                'Jumlah huruf',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "InterSemiBold",
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Aksara swara dalam aksara Sunda terdiri dari tujuh simbol dasar yang mewakili vokal',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "InterMedium",
                    color: fontGrayLightColor),
              ),
              SizedBox(height: 8),
              Text(
                'Penggunaan',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "InterSemiBold",
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Aksara swara digunakan untuk menuliskan kata-kata atau suku kata yang dimulai dengan vokal. Dalam penulisan teks, aksara swara digunakan ketika sebuah vokal perlu ditulis sebagai huruf yang berdiri sendiri.',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "InterMedium",
                    color: fontGrayLightColor),
              ),
              SizedBox(height: 8),
              Text(
                'Daftar Huruf',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "InterSemiBold",
                ),
              ),
              SizedBox(height: 8),
              Container(
                child: Image.asset(
                  'assets/images/swara.png',
                  fit: BoxFit.contain, // Ensures the image scales properly
                  width: double
                      .infinity, // Makes the image take the full width of the screen
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Contoh Penggunaan',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "InterSemiBold",
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Kata "anak" ditulis sebagai ᮃᮔᮊ᮪',
                style: TextStyle(
                    fontFamily: "InterMedium",
                    fontSize: 16,
                    color: fontGrayLightColor),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
