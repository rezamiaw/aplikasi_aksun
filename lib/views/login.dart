import 'package:aplikasi_aksun/utils/colors.dart';
import 'package:aplikasi_aksun/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'register.dart'; // Import the RegisterView
import 'package:firebase_auth/firebase_auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  bool isHide = true;
  bool isPressedLogin = false;
  bool isPressedGoogle = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _onButtonPressedLogin(bool pressed) {
    setState(() {
      isPressedLogin = pressed;
    });
  }

  void _onButtonPressedGoogle(bool pressed) {
    setState(() {
      isPressedGoogle = pressed;
    });
  }

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
                  child: Form(
                    key: _formKey,
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
                          controller: emailController,
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email tidak boleh kosong';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return 'Masukkan email yang valid';
                            }
                            return null;
                          },
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
                          controller: passwordController,
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password tidak boleh kosong';
                            }
                            if (value.length < 6) {
                              return 'Password harus lebih dari 6 karakter';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTapDown: (_) => _onButtonPressedLogin(true),
                          onTapUp: (_) {
                            _onButtonPressedLogin(false);
                            if (_formKey.currentState!.validate()) {
                              try {
                                FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Login Successful!')),
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BottomNavBar()),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Login Failed: $e')),
                                );
                              }
                            }
                          },
                          onTapCancel: () => _onButtonPressedLogin(false),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            width: double.infinity,
                            height: 55,
                            decoration: BoxDecoration(
                              color: greenColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: isPressedLogin
                                  ? []
                                  : [
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
                        SizedBox(
                            height: 20), // Add some space before the divider
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
                          onTapDown: (_) => _onButtonPressedGoogle(true),
                          onTapUp: (_) {
                            _onButtonPressedGoogle(false);
                            // Handle the "Masuk Dengan Google" button tap here
                          },
                          onTapCancel: () => _onButtonPressedGoogle(false),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            width: double.infinity,
                            height: 55,
                            decoration: BoxDecoration(
                              color: softwhite,
                              border: Border.all(color: grayColor),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: isPressedGoogle
                                  ? []
                                  : [
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterView()),
                          );
                        },
                        child: Text(
                          "Daftar Sekarang",
                          style: TextStyle(
                            fontFamily: "InterSemiBold",
                            fontSize: 16,
                            color: greenColor,
                          ),
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
