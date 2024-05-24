// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:wallet_app/components/number_keyboard.dart';
import 'package:wallet_app/core/utils/colors.dart';
import 'package:wallet_app/core/utils/constants.dart';
import 'package:wallet_app/cubit/AddCubit/add_data_cubit.dart';
import 'package:wallet_app/cubit/fetchCubit/fetch_data_cubit.dart';
import 'package:wallet_app/models/wallet_model.dart';

class ActionPage extends StatefulWidget {
  WalletModel? walletModel;
  final bool isPlus;
  ActionPage({super.key, this.walletModel, required this.isPlus});

  @override
  State<ActionPage> createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionPage> {
  TextEditingController detailsCon = TextEditingController();
  String amountText = '';
  @override
  void initState() {
    if (widget.walletModel != null) {
      setState(() {
        detailsCon.text = widget.walletModel!.details;
        amountText = widget.walletModel!.value < 0
            ? (widget.walletModel!.value * -1).toString()
            : widget.walletModel!.value.toString();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.isPlus ? 'Plus' : 'Minus'),
      ),
      body: BlocProvider(
        create: (context) => AddDataCubit(),
        child: BlocBuilder<AddDataCubit, AddDataState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    height: 65,
                    decoration: BoxDecoration(
                        color: orangeColor,
                        borderRadius: BorderRadius.circular(13)),
                    child: TextField(
                      controller: detailsCon,
                      onChanged: (value) {
                        setState(() {
                          detailsCon.text = value;
                        });
                      },
                      decoration: InputDecoration(
                        fillColor: orangeColor,
                        focusColor: orangeColor,
                        hintText: 'Details here...',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14,
                        ),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(13)),
                      ),
                    ),
                  ),
                  Gap(20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 65,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: widget.isPlus ? blueColor : pinkColor,
                              borderRadius: BorderRadius.circular(13)),
                          child: Center(
                              child: Text(
                            widget.isPlus
                                ? amountText != ''
                                    ? '+ $amountText'
                                    : '+ 0.0'
                                : amountText != ''
                                    ? '-$amountText'
                                    : '- 0.0',
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 20,
                                color: Colors.black),
                          )),
                        ),
                      ),
                    ],
                  ),
                  Gap(40),
                  NumberKeyboard(
                    text: amountText,
                    onValueChanged: (value) {
                      setState(() {
                        amountText = value;
                      });
                    },
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          try {
                            if (widget.walletModel != null) {
                              widget.walletModel!.details = detailsCon.text;
                              widget.walletModel!.value = widget.isPlus
                                  ? double.parse(amountText)
                                  : double.parse(amountText) < 0
                                      ? double.parse(amountText)
                                      : double.parse(amountText) * (-1);
                              widget.walletModel!.save();
                            } else {
                              BlocProvider.of<AddDataCubit>(context).addData(
                                  WalletModel(
                                      details: detailsCon.text,
                                      value: widget.isPlus
                                          ? double.parse(amountText)
                                          : double.parse(amountText) * (-1),
                                      date: DateTime.now()));
                            }
                            BlocProvider.of<FetchDataCubit>(context)
                                .fetchData();
                            BlocProvider.of<FetchDataCubit>(context)
                                .fetchDateData(
                                    datetime:
                                        BlocProvider.of<FetchDataCubit>(context)
                                            .selectDay);
                            Navigator.pop(context);
                          } on Exception catch (e) {
                            Constants.showToast(msg: e.toString());
                          }
                        },
                        child: Container(
                          width: 165,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              color: blueColor),
                          child: Center(
                              child: Text(
                            widget.walletModel != null ? 'UPDATE' : 'ADD',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 165,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              color: pinkColor),
                          child: Center(
                              child: Text(
                            'CANCEL',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontFamily: 'Rubik'),
                          )),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
