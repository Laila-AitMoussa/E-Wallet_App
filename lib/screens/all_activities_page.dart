import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wallet_app/core/utils/colors.dart';
import 'package:wallet_app/cubit/fetchCubit/fetch_data_cubit.dart';
import 'package:wallet_app/models/wallet_model.dart';
import 'package:wallet_app/screens/action_page.dart';

class AllActivitiesPage extends StatefulWidget {
  const AllActivitiesPage({super.key});

  @override
  State<AllActivitiesPage> createState() => _AllActivitiesPageState();
}

class _AllActivitiesPageState extends State<AllActivitiesPage> {
  CalendarFormat calendarFormat = CalendarFormat.week;
  DateTime mySelectedDay = DateTime.now();
  DateTime myFocusedDay = DateTime.now();
  @override
  void initState() {
    BlocProvider.of<FetchDataCubit>(context)
        .fetchDateData(datetime: mySelectedDay);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Activities'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 1),
        child: BlocBuilder<FetchDataCubit, FetchDataState>(
          builder: (context, state) {
            return Column(
              children: [
                TableCalendar(
                  calendarStyle: CalendarStyle(
                    defaultTextStyle: TextStyle(fontFamily: 'Rubik'),
                    todayDecoration: BoxDecoration(
                        color: beigeColor, shape: BoxShape.circle),
                  ),
                  firstDay: DateTime(2024),
                  lastDay: DateTime.now(),
                  focusedDay: myFocusedDay,
                  calendarFormat: calendarFormat,
                  onFormatChanged: (format) {
                    setState(() {
                      calendarFormat = format;
                    });
                  },
                  currentDay: mySelectedDay,
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      mySelectedDay = selectedDay;
                      myFocusedDay = focusedDay;
                      BlocProvider.of<FetchDataCubit>(context).selectDay =
                          mySelectedDay;
                    });
                    BlocProvider.of<FetchDataCubit>(context)
                        .fetchDateData(datetime: mySelectedDay);
                  },
                ),
                Gap(20),
                Expanded(
                  child: ListView.builder(
                    itemCount: BlocProvider.of<FetchDataCubit>(context)
                        .dateWalletList
                        .length,
                    itemBuilder: (context, index) {
                      List<WalletModel> myList =
                          BlocProvider.of<FetchDataCubit>(context)
                              .dateWalletList
                              .reversed
                              .toList();
                      return Dismissible(
                        background: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          color: blueColor.withOpacity(0.5),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.edit,
                              color: blueColor,
                            ),
                          ),
                        ),
                        secondaryBackground: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          color: pinkColor.withOpacity(0.5),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.delete,
                              color: pinkColor,
                            ),
                          ),
                        ),
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          if (direction == DismissDirection.startToEnd) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ActionPage(
                                    isPlus: myList[index].value > 0,
                                    walletModel: myList[index],
                                  ),
                                ));
                          } else if (direction == DismissDirection.endToStart) {
                            myList[index].delete();
                            BlocProvider.of<FetchDataCubit>(context)
                                .fetchData();
                          }
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 22,
                            backgroundColor:
                                myList[index].value > 0 ? blueColor : pinkColor,
                            child: Text(
                              myList[index].details.isNotEmpty
                                  ? myList[index]
                                      .details
                                      .substring(0, 1)
                                      .toUpperCase()
                                  : '',
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ),
                          title: Text(
                            myList[index].details,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Rubik',
                              fontSize: 16.5,
                            ),
                          ),
                          trailing: Text(
                            myList[index].value < 0
                                ? myList[index].value.toString()
                                : '+${myList[index].value}',
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 13,
                                color: myList[index].value > 0
                                    ? blueColor
                                    : pinkColor),
                          ),
                          subtitle: Text(
                            DateFormat.yMMMEd()
                                .format(myList[index].date)
                                .toString(),
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Rubik',
                                color: Colors.grey),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
