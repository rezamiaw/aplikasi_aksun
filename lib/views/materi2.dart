import 'package:aplikasi_aksun/utils/colors.dart';
import 'package:flutter/material.dart';

class AksaraNgalagenaPage extends StatelessWidget {
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
          'Aksara Ngalagena',
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
                'Aksara ngalagena adalah huruf-huruf dasar dalam aksara Sunda yang mewakili konsonan. Setiap huruf ngalagena pada dasarnya memiliki bunyi konsonan yang diikuti oleh vokal "a".',
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
                'Aksara ngalagena terdiri dari 18 huruf dasar. Setiap huruf mewakili konsonan yang berbeda.',
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
                'Aksara ngalagena digunakan sebagai dasar dalam penulisan kata-kata dalam bahasa Sunda. Ketika menulis, huruf-huruf ngalagena dapat digabungkan dengan tanda-tanda vokal (disebut "sandhangan") untuk membentuk berbagai bunyi vokal yang berbeda.',
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
                  'assets/images/ngalagena.png',
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
                "Kata mama dalam aksara Sunda ditulis dengan huruf ngalagena: ᮙᮙ ",
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
