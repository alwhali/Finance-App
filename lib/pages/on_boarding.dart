import 'package:finance_app/colors/colors.dart';
import 'package:finance_app/global_variables.dart';
import 'package:finance_app/pages/home_page.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int currentIndex = 0;
  bool isLastPage = false;
  final PageController _pageController = PageController();
  List<PagesOnBoarding> pages = [
    PagesOnBoarding(
      title: 'Welcome ',
      image: 'assets/images/money.png',
      subTitle: 'using our app to manage your Money',
    ),
    PagesOnBoarding(
      title: 'Wallet is the Future',
      image: 'assets/images/shop.png',
      subTitle: 'buys and sells with your digital wallet',
    ),
    PagesOnBoarding(
      title: 'Get Started!',
      image: 'assets/images/wallet.png',
      subTitle: 'Start managing your finances today',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              FirstTime.registerFirstTime();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
            child: Text(
              'Skip',
              style: TextStyle(color: blackcColor, fontSize: 16),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  return pages[index];
                },
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                    isLastPage = currentIndex == pages.length - 1;
                  });
                },
              ),
            ),
            Row(
              children: [
                Text(
                  '${currentIndex + 1}/${pages.length}',
                  style: TextStyle(color: blackcColor, fontSize: 16),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    if (!isLastPage) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    } else {
                      FirstTime.registerFirstTime();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreenColor,
                    foregroundColor: whiteColor,
                  ),
                  child: Text(isLastPage ? 'Get Started' : 'Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PagesOnBoarding extends StatelessWidget {
  final String title;
  final String image;
  final subTitle;
  const PagesOnBoarding({
    super.key,
    required this.title,
    required this.image,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: blackcColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Image.asset(image, height: 350, width: 350),
        Text(
          subTitle,
          style: TextStyle(
            color: blackcColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
