import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:wallet_app/core/utils/colors.dart';
import 'package:wallet_app/screens/onboarding_page.dart';

class SpalshPage extends StatefulWidget {
  const SpalshPage({super.key});

  @override
  State<SpalshPage> createState() => _SpalshPageState();
}

class _SpalshPageState extends State<SpalshPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OnboardingPage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/svg/logo.svg',
              height: 165,
            ),
            Gap(17),
            Text(
              'E-Wallet',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Rubik',
                  fontSize: 32,
                  color: beigeColor),
            ),
            Text(
              'Finance',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Rubik',
                  fontSize: 22,
                  color: beigeColor),
            )
          ],
        ),
      ),
    );
  }
}
