import 'package:aplikasi_aksun/utils/colors.dart';
import 'package:flutter/material.dart';
import 'login.dart'; // Import the LoginScreen
import 'register.dart'; // Import the RegisterView

List onboardingData = [
  {
    "image": "assets/images/1.png",
    "title": "Belajar Aksara Sunda\nJadi Lebih Mudah!",
    "desc":
        "Gunakan metode belajar interaktif kami untuk \nmengenal, membaca, dan menulis aksara \nSunda dengan cara yang menyenangkan"
  },
  {
    "image": "assets/images/2.png",
    "title": "Latih dan Uji Kemampuanmu!",
    "desc":
        "Dengan berbagai latihan dan kuis, kamu bisa \nmenguji seberapa jauh kamu telah belajar dan \nmemahami aksara Sunda"
  },
  {
    "image": "assets/images/3.png",
    "title": "Bersiap \nuntuk Memulai?",
    "desc":
        "Bergabunglah dengan kami sekarang dan \njadilah bagian dari komunitas pembelajar \naksara Sunda"
  },
];

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnBoardingView> {
  final PageController pageController = PageController();
  int currentPage = 0;
  bool isPressedContinue = false;
  bool isPressedLogin = false;

  void _onContinuePressed() {
    if (currentPage < onboardingData.length - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegisterView()),
      );
    }
  }

  void _onButtonPressedContinue(bool pressed) {
    setState(() {
      isPressedContinue = pressed;
    });
  }

  void _onButtonPressedLogin(bool pressed) {
    setState(() {
      isPressedLogin = pressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (v) {
                setState(() {
                  currentPage = v;
                });
              },
              itemCount: onboardingData.length,
              itemBuilder: (context, i) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.asset(
                            onboardingData[i]["image"],
                            width: constraints.maxWidth * 0.8,
                            height: constraints.maxHeight * 0.4,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Text(
                            onboardingData[i]["title"],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "InterBold",
                              fontSize: 24,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Text(
                            onboardingData[i]["desc"],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "InterRegular",
                              fontSize: 14,
                              color: fontGrayLightColor,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Wrap(
            spacing: 6,
            children: List.generate(
              onboardingData.length,
              (index) => AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: currentPage == index ? greenColor : grayColor,
                  borderRadius: BorderRadius.circular(1000),
                ),
                width: currentPage == index ? 20 : 8,
                height: 8,
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTapDown: (_) => _onButtonPressedLogin(true),
                onTapUp: (_) {
                  _onButtonPressedLogin(false);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginView()),
                  );
                },
                onTapCancel: () => _onButtonPressedLogin(false),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: 148,
                  height: 55,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: grayColor),
                    boxShadow: isPressedLogin
                        ? []
                        : [
                            BoxShadow(
                              color: grayColor,
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
                        color: fontGrayDarkColor,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTapDown: (_) => _onButtonPressedContinue(true),
                onTapUp: (_) {
                  _onButtonPressedContinue(false);
                  _onContinuePressed();
                },
                onTapCancel: () => _onButtonPressedContinue(false),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  width: 148,
                  height: 55,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    color: greenColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: isPressedContinue
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
                      currentPage == onboardingData.length - 1
                          ? "Daftar"
                          : "Lanjutkan",
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
            ],
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: OnBoardingView(),
  ));
}
