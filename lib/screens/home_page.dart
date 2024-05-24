import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:wallet_app/components/action_card.dart';
import 'package:wallet_app/components/budget_container.dart';
import 'package:wallet_app/core/utils/colors.dart';
import 'package:wallet_app/cubit/fetchCubit/fetch_data_cubit.dart';
import 'package:wallet_app/models/wallet_model.dart';
import 'package:wallet_app/screens/action_page.dart';
import 'package:wallet_app/screens/all_activities_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<FetchDataCubit>(context).fetchData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('darkModeBox').listenable(),
        builder: (BuildContext context, Box<dynamic> box, Widget? child) {
          var darkMode = box.get('darkMode', defaultValue: false);
          return Scaffold(
              appBar: AppBar(
                surfaceTintColor: Colors.white,
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text('Welcome, Laila'),
                actions: [
                  IconButton(
                      onPressed: () {
                        box.put('darkMode', !darkMode);
                      },
                      icon: Icon(!darkMode
                          ? Icons.brightness_3
                          : Icons.light_mode_outlined)),
                  IconButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    icon: Icon(Icons.exit_to_app),
                  )
                ],
              ),
              body: BlocBuilder<FetchDataCubit, FetchDataState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(15, 12, 15, 1),
                    child: state is FetchDataLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              BudgetContainer(
                                  text: 'My Balance',
                                  balance:
                                      BlocProvider.of<FetchDataCubit>(context)
                                          .sum,
                                  color: orangeColor,
                                  isTop: true),
                              Gap(10),
                              BudgetContainer(
                                  text: 'Today Balance',
                                  balance:
                                      BlocProvider.of<FetchDataCubit>(context)
                                          .todaySum,
                                  color: blueColor,
                                  isTop: false),
                              Gap(15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ActionCard(
                                    text: 'Plus',
                                    color: blueColor,
                                    iconData: Icons.add,
                                    isPlus: true,
                                  ),
                                  ActionCard(
                                    text: 'Minus',
                                    color: pinkColor,
                                    iconData: Icons.remove,
                                    isPlus: false,
                                  ),
                                ],
                              ),
                              Gap(12),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Activity',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Rubik',
                                        fontSize: 22,
                                        color: orangeColor),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AllActivitiesPage(),
                                            ));
                                      },
                                      child: Text(
                                        'See All',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Rubik',
                                            fontSize: 14,
                                            color: beigeColor),
                                      ))
                                ],
                              ),
                              // Gap(20),
                              Expanded(
                                child: ListView.builder(
                                  itemCount:
                                      BlocProvider.of<FetchDataCubit>(context)
                                          .todayWalletList
                                          .length,
                                  itemBuilder: (context, index) {
                                    List<WalletModel> myList =
                                        BlocProvider.of<FetchDataCubit>(context)
                                            .todayWalletList
                                            .reversed
                                            .toList();
                                    return Dismissible(
                                      background: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        color: blueColor.withOpacity(0.3),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Icon(
                                            Icons.edit,
                                            color: blueColor,
                                          ),
                                        ),
                                      ),
                                      secondaryBackground: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        color: pinkColor.withOpacity(0.3),
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
                                        if (direction ==
                                            DismissDirection.startToEnd) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ActionPage(
                                                  isPlus:
                                                      myList[index].value > 0,
                                                  walletModel: myList[index],
                                                ),
                                              ));
                                        } else if (direction ==
                                            DismissDirection.endToStart) {
                                          myList[index].delete();
                                          BlocProvider.of<FetchDataCubit>(
                                                  context)
                                              .fetchData();
                                        }
                                      },
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          radius: 22,
                                          backgroundColor: myList.isNotEmpty
                                              ? myList[index].value > 0
                                                  ? blueColor
                                                  : pinkColor
                                              : null,
                                          child: Text(
                                            myList.isNotEmpty
                                                ? myList[index]
                                                        .details
                                                        .isNotEmpty
                                                    ? myList[index]
                                                        .details
                                                        .substring(0, 1)
                                                        .toUpperCase()
                                                    : ''
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
                          ),
                  );
                },
              ));
        });
  }
}
