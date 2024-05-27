import 'package:aplikasi_aksun/utils/colors.dart';
import 'package:flutter/material.dart';

List onboardingData = [
  {
    "image": "assets/images/onboarding1.png",
    "title": "Belajar Aksara Sunda\nJadi Lebih Mudah!",
    "desc":
        "Gunakan metode belajar interaktif kami untuk \nmengenal, membaca, dan menulis aksara \nSunda dengan cara yang menyenangkan"
  },
  {
    "image": "assets/images/onboarding2.png",
    "title": "Latih dan Uji Kemampuanmu!",
    "desc":
        "Dengan berbagai latihan dan kuis, kamu bisa \nmenguji seberapa jauh kamu telah belajar dan \nmemahami aksara Sunda"
  },
  {
    "image": "assets/images/onboarding3.png",
    "title": "Bersiap Untuk Memulai?",
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

  void _onContinuePressed() {
    if (currentPage < onboardingData.length - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Perform action for the last page, e.g., navigate to another screen
      print("Navigate to another screen or perform another action.");
    }
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
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(onboardingData[i]["image"]),
                    ),
                    SizedBox(height: 20),
                    Text(
                      onboardingData[i]["title"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "InterBold",
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      onboardingData[i]["desc"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "InterRegular",
                        fontSize: 14,
                        color: fontGrayLightColor,
                      ),
                    ),
                  ],
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
              Container(
                width: 148,
                height: 55,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: grayColor),
                  boxShadow: [
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
              SizedBox(width: 10),
              GestureDetector(
                onTap: _onContinuePressed,
                child: Container(
                  width: 148,
                  height: 55,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
