import 'package:aplikasi_aksun/utils/colors.dart';
import 'package:aplikasi_aksun/views/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  String? userName;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      setState(() {
        userName = userDoc['name'] ?? "User";
        userEmail = user.email ?? "email@example.com";
      });
    } else {
      setState(() {
        userName = "User";
        userEmail = "email@example.com";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String initial = userName?.isNotEmpty == true ? userName![0] : 'U';

    return Scaffold(
      body: userName == null || userEmail == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
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
                              style:
                                  TextStyle(fontSize: 40, color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Nama Pengguna: $userName",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Email: $userEmail",
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

  void _showLogoutConfirmationBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white, // Set background color to white
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start, // Align to flex-start
            children: [
              SizedBox(height: 10),
              Text(
                'Keluar dari akunmu?',
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'InterBold',
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Nanti ketemu lagi di lain waktu, ya!',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'InterRegular',
                  color: fontGrayLightColor,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: greenColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () =>
                          Navigator.of(context).pop(), // Close the dialog
                      child: Text(
                        'Gak jadi',
                        style: TextStyle(
                            color: greenColor, fontFamily: 'InterBold'),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: greenColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                        _logout(); // Log out the user
                      },
                      child: Text(
                        'Iya, keluar',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'InterBold',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _logout() {
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
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: GestureDetector(
        onTapDown: (_) => _onButtonPressed(true),
        onTapUp: (_) {
          _onButtonPressed(false);
          _showLogoutConfirmationBottomSheet();
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  'Log Out',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
    home: SettingsView(),
  ));
}
