// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class NumberContainer extends StatelessWidget {
  final String number;
  final Function() onTap;
  const NumberContainer({
    super.key,
    required this.number,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 110,
        height: 75,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1.5),
            color: Colors.black,
            borderRadius: BorderRadius.circular(13)),
        padding: EdgeInsets.all(5),
        child: Center(
            child: Text(
          number,
          style:
              TextStyle(color: Colors.white, fontFamily: 'Rubik', fontSize: 16),
        )),
      ),
    );
  }
}
