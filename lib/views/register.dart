import 'package:aplikasi_aksun/utils/colors.dart';
import 'package:flutter/material.dart';
import 'login.dart'; // Import the LoginScreen
import 'package:firebase_auth/firebase_auth.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  bool isHidePassword = true;
  bool isHideConfirmPassword = true;
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController =
      TextEditingController(); // Added emailController
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: 40), // Add some space from the top
                Center(
                  child: Text(
                    "Daftar Akun Baru",
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
                    "Buat akun untuk mengakses quiz",
                    style: TextStyle(
                      fontFamily: "InterRegular",
                      fontSize: 16,
                      color: fontGrayLightColor,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nama",
                        style: TextStyle(
                          fontFamily: "InterMedium",
                          fontSize: 14,
                          color: fontGrayDarkColor,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: namaController, // Use the namaController
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Masukkan nama lengkap anda',
                          hintStyle: TextStyle(
                            fontFamily: "InterRegular",
                            fontSize: 14,
                            color: fontGrayLightColor,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
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
                        controller: emailController, // Use the emailController
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
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
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
                        obscureText: isHidePassword,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isHidePassword = !isHidePassword;
                              });
                            },
                            icon: Icon(isHidePassword
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
                      SizedBox(height: 10),
                      Text(
                        "Konfirmasi Password",
                        style: TextStyle(
                          fontFamily: "InterMedium",
                          fontSize: 14,
                          color: fontGrayDarkColor,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: isHideConfirmPassword,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isHideConfirmPassword = !isHideConfirmPassword;
                              });
                            },
                            icon: Icon(isHideConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            color: greenColor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Masukkan kembali password anda',
                          hintStyle: TextStyle(
                            fontFamily: "InterRegular",
                            fontSize: 14,
                            color: fontGrayLightColor,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Konfirmasi password tidak boleh kosong';
                          }
                          if (value != passwordController.text) {
                            return 'Password tidak cocok';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Registration Successful!')),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginView()),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Registration Failed: $e')),
                              );
                            }
                          }
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
                              "Daftar",
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
                              "atau daftar dengan",
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
                          // Handle the "Daftar Dengan Google" button tap here
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
                                "Daftar Dengan Google",
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
                        "Sudah punya akun?",
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
                                builder: (context) => LoginView()),
                          );
                        },
                        child: Text(
                          "Masuk Sekarang",
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
    home: RegisterView(),
  ));
}
