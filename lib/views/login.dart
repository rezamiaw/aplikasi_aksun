import 'package:aplikasi_aksun/utils/colors.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isHide = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context)
                .size
                .height, // Make the container take full height
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Space out the children
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40), // Add some space from the top
                      Center(
                        child: Text(
                          "Masuk ke Akun",
                          style: TextStyle(
                            fontFamily: "InterSemiBold",
                            fontSize: 20,
                            color: fontGrayDarkColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Text(
                          "Masuk untuk mengakses quiz",
                          style: TextStyle(
                            fontFamily: "InterRegular",
                            fontSize: 16,
                            color: fontGrayLightColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Email",
                        style: TextStyle(
                          fontFamily: "InterMedium",
                          fontSize: 14,
                          color: fontGrayDarkColor,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Masukkan alamat email anda',
                          hintStyle: TextStyle(
                            fontFamily: "InterRegular",
                            fontSize: 14,
                            color: fontGrayLightColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Password",
                        style: TextStyle(
                          fontFamily: "InterMedium",
                          fontSize: 14,
                          color: fontGrayDarkColor,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        obscureText: isHide,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isHide = !isHide;
                              });
                            },
                            icon: Icon(isHide
                                ? Icons.visibility_off
                                : Icons.visibility),
                            color: greenColor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Masukkan password anda',
                          hintStyle: TextStyle(
                            fontFamily: "InterRegular",
                            fontSize: 14,
                            color: fontGrayLightColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          // Handle the "Masuk" button tap here
                        },
                        child: Container(
                          width: double.infinity, // Make the button full width
                          height: 55,
                          decoration: BoxDecoration(
                            color: greenColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: darkgreenColor,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "Masuk",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "InterBold",
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20), // Add some space before the divider
                      Row(
                        children: [
                          Expanded(
                            child:
                                Divider(color: Colors.black.withOpacity(0.2)),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "atau masuk dengan",
                              style: TextStyle(
                                fontFamily: "InterRegular",
                                fontSize: 14,
                                color: fontGrayLightColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child:
                                Divider(color: Colors.black.withOpacity(0.2)),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          // Handle the "Masuk Dengan Google" button tap here
                        },
                        child: Container(
                          width: double.infinity, // Make the button full width
                          height: 55,
                          decoration: BoxDecoration(
                            color: softwhite,
                            border: Border.all(color: grayColor),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: grayColor,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/google.png",
                                height: 24.0,
                                width: 24.0,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Masuk Dengan Google",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "InterBold",
                                  fontSize: 14,
                                  color: fontGrayDarkColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Belum punya akun?",
                        style: TextStyle(
                          fontFamily: "InterRegular",
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Daftar Sekarang",
                        style: TextStyle(
                          fontFamily: "InterSemiBold",
                          fontSize: 16,
                          color: greenColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20), // Add some space at the bottom
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginView(),
  ));
}
