import 'package:aplikasi_aksun/utils/colors.dart';
import 'package:aplikasi_aksun/views/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  Future<Map<String, String>> _getUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      return {
        'name': userDoc['name'] ?? "User",
        'email': user.email ?? "email@example.com",
      };
    }
    return {'name': 'User', 'email': 'email@example.com'};
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; // Disable back button
      },
      child: Scaffold(
        body: FutureBuilder<Map<String, String>>(
          future: _getUserInfo(),
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, String>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              final userInfo = snapshot.data!;
              String initial =
                  userInfo['name']!.isNotEmpty ? userInfo['name']![0] : 'U';

              return Center(
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          "Pengaturan",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.blue,
                              child: Text(
                                initial,
                                style: TextStyle(
                                    fontSize: 40, color: Colors.white),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Nama Pengguna: ${userInfo['name']}",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Email: ${userInfo['email']}",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: LogoutButton(),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class LogoutButton extends StatefulWidget {
  @override
  _LogoutButtonState createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  bool isPressed = false;

  void _onButtonPressed(bool pressed) {
    setState(() {
      isPressed = pressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: GestureDetector(
        onTapDown: (_) => _onButtonPressed(true),
        onTapUp: (_) {
          _onButtonPressed(false);
          FirebaseAuth.instance.signOut();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Berhasil keluar'),
            ),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginView()),
            (Route<dynamic> route) => false,
          );
        },
        onTapCancel: () => _onButtonPressed(false),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: double.infinity,
          height: 55,
          decoration: BoxDecoration(
            color: red,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isPressed
                ? []
                : [
                    BoxShadow(
                      color: darkred,
                      offset: Offset(0, 4),
                    ),
                  ],
          ),
          child: Center(
            child: Text(
              'Log Out',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SettingsView(),
  ));
}
