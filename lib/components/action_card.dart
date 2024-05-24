import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wallet_app/screens/action_page.dart';

class ActionCard extends StatelessWidget {
  final String text;
  final Color color;
  final IconData iconData;
  final bool isPlus;

  const ActionCard({
    super.key,
    required this.text,
    required this.color,
    required this.iconData,
    required this.isPlus,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ActionPage(
                isPlus: isPlus,
              ),
            ));
      },
      child: Container(
        width: 175,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13), color: color),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(iconData, color: Colors.black),
            Gap(5),
            Text(
              text,
              style: TextStyle(fontFamily: 'Rubik', color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
