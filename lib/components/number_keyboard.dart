// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wallet_app/components/number_container.dart';

typedef ValueCallback = void Function(String value);

class NumberKeyboard extends StatefulWidget {
  final ValueCallback onValueChanged;
  String text;
  NumberKeyboard({
    super.key,
    required this.onValueChanged,
    required this.text,
  });

  @override
  State<NumberKeyboard> createState() => _NumberKeyboardState();
}

class _NumberKeyboardState extends State<NumberKeyboard> {
  //String text = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NumberContainer(
              number: '7',
              onTap: () {
                setState(() {
                  widget.text = '${widget.text}7';
                });
                widget.onValueChanged(widget.text);
              },
            ),
            NumberContainer(
              number: '8',
              onTap: () {
                setState(() {
                  widget.text = '${widget.text}8';
                });
                widget.onValueChanged(widget.text);
              },
            ),
            NumberContainer(
              number: '9',
              onTap: () {
                setState(() {
                  widget.text = '${widget.text}9';
                });
                widget.onValueChanged(widget.text);
              },
            ),
          ],
        ),
        Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NumberContainer(
              number: '4',
              onTap: () {
                setState(() {
                  widget.text = '${widget.text}4';
                });
                widget.onValueChanged(widget.text);
              },
            ),
            NumberContainer(
              number: '5',
              onTap: () {
                setState(() {
                  widget.text = '${widget.text}5';
                });
                widget.onValueChanged(widget.text);
              },
            ),
            NumberContainer(
              number: '6',
              onTap: () {
                setState(() {
                  widget.text = '${widget.text}6';
                });
                widget.onValueChanged(widget.text);
              },
            ),
          ],
        ),
        Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NumberContainer(
              number: '1',
              onTap: () {
                setState(() {
                  widget.text = '${widget.text}1';
                });
                widget.onValueChanged(widget.text);
              },
            ),
            NumberContainer(
              number: '2',
              onTap: () {
                setState(() {
                  widget.text = '${widget.text}2';
                });
                widget.onValueChanged(widget.text);
              },
            ),
            NumberContainer(
              number: '3',
              onTap: () {
                setState(() {
                  widget.text = '${widget.text}3';
                });
                widget.onValueChanged(widget.text);
              },
            ),
          ],
        ),
        Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NumberContainer(
              number: '.',
              onTap: () {
                setState(() {
                  widget.text.contains('.')
                      ? null
                      : widget.text = '${widget.text}.';
                });
                widget.onValueChanged(widget.text);
              },
            ),
            NumberContainer(
              number: '0',
              onTap: () {
                setState(() {
                  widget.text = '${widget.text}0';
                });
                widget.onValueChanged(widget.text);
              },
            ),
            NumberContainer(
              number: '<',
              onTap: () {
                setState(() {
                  widget.text != ''
                      ? widget.text =
                          widget.text.substring(0, widget.text.length - 1)
                      : null;
                });
                widget.onValueChanged(widget.text);
              },
            ),
          ],
        )
      ],
    );
  }
}
