import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallet_app/core/utils/colors.dart';

class Constants {
  static showErrorDialog({required BuildContext context, required String msg}) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(
          msg,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
                textStyle:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            child: Text('Ok'),
          )
        ],
      ),
    );
  }

  static void showToast(
      {required String msg, Color? color, ToastGravity? gravity}) {
    Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: color ?? Colors.red,
        gravity: gravity ?? ToastGravity.BOTTOM,
        msg: msg);
  }
}
