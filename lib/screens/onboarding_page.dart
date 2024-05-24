import 'package:flutter/material.dart';
import 'package:wallet_app/components/item_page.dart';
import 'package:wallet_app/core/utils/colors.dart';
import 'package:wallet_app/screens/home_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  PageController pageController = PageController();
  int currentIndex = 0;
  bool isLastPage = false;
  List<ItemPage> item = [
    ItemPage(
        title: 'Welcome to E-Wallet: Your Personal Finance Companion',
        image: 'assets/images/finance1.png',
        subtitle:
            'Unlock the power of smart budgeting and take control of your finances effortlessly with E-Wallet, your all-in-one financial management solution.'),
    ItemPage(
      title: 'Getting Started: Set Up Your Budget in Minutes',
      subtitle:
          'Easily create your personalized budget by inputting your income, expenses, and savings goals, and let E-Wallet handle the rest.',
      image: 'assets/images/finance2.png',
    ),
    ItemPage(
      subtitle:
          'Explore powerful tools for expense tracking, budget visualization, and personalized insights to master your finances.',
      title: 'Budgeting Made Simple: Navigate Your Financial Journey',
      image: 'assets/images/finance3.png',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                    (route) => false);
              },
              child: Text('Skip'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (value) {
                  currentIndex = value;
                  if (value + 1 == item.length) {
                    isLastPage = true;
                  } else {
                    isLastPage = false;
                  }
                  setState(() {});
                },
                itemCount: item.length,
                controller: pageController,
                itemBuilder: (BuildContext context, int index) {
                  return item[index];
                },
              ),
            ),
            Row(
              children: [
                Text('${currentIndex + 1}/${item.length}'),
                Spacer(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: isLastPage ? beigeColor : orangeColor,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      isLastPage
                          ? Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                              (route) => false)
                          : pageController.nextPage(
                              duration: Duration(milliseconds: 400),
                              curve: Easing.legacyAccelerate);
                    },
                    child: Text(isLastPage ? 'Get Started' : 'Next'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
