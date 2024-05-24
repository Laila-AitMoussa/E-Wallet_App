import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wallet_app/core/utils/colors.dart';

class ItemPage extends StatelessWidget {
  final String title;
  final String image;
  final String subtitle;
  const ItemPage({
    super.key,
    required this.title,
    required this.image,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: Image.asset(
          image,
          height: 350,
        )),
        Text(
          title,
          style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 32,
              color: orangeColor,
              fontWeight: FontWeight.bold),
        ),
        Gap(20),
        Text(
          subtitle,
          style:
              TextStyle(fontFamily: 'Rubik', fontSize: 15, color: Colors.grey),
        ),
      ],
    );
  }
}
