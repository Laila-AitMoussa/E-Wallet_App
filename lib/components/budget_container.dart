import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class BudgetContainer extends StatelessWidget {
  final String text;
  final double balance;
  final Color color;
  final bool isTop;
  const BudgetContainer(
      {super.key,
      required this.text,
      required this.balance,
      required this.color,
      required this.isTop});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            padding: EdgeInsets.all(20),
            height: 115,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: 0.4, color: Colors.white),
                    bottom: BorderSide(width: 0.4, color: Colors.white),
                    left: BorderSide(width: 0.2, color: Colors.white)),
                borderRadius: isTop
                    ? BorderRadius.only(topLeft: Radius.circular(13))
                    : BorderRadius.only(bottomLeft: Radius.circular(13)),
                color: Colors.black),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Rubik', fontSize: 16),
                ),
                Gap(5),
                Text(
                  NumberFormat.compactCurrency(decimalDigits: 2, symbol: '\$')
                      .format(balance)
                      .toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w300,
                      fontSize: 30),
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            width: 50,
            height: 115,
            decoration: BoxDecoration(
              color: color,
              borderRadius: isTop
                  ? BorderRadius.only(topRight: Radius.circular(13))
                  : BorderRadius.only(bottomRight: Radius.circular(13)),
            ),
          ),
        ),
      ],
    );
  }
}
