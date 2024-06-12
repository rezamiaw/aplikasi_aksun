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
                'Aksara angka adalah simbol-simbol yang digunakan untuk menuliskan angka dalam aksara Sunda. Sistem ini berbeda dari sistem penulisan angka Arab yang umum digunakan saat ini.',
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
                'Aksara angka Sunda terdiri dari sepuluh simbol dasar yang mewakili angka 0 hingga 9.',
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
                'Aksara angka digunakan dalam konteks penulisan tradisional Sunda untuk menuliskan angka pada teks-teks, catatan, dokumen, dan prasasti.',
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
                  'assets/images/angka.png',
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
                'Misalnya, angka tahun 2023 dalam aksara angka Sunda ditulis sebagai ᮲᮰᮲᮳',
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
