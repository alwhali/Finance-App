import 'dart:io';

import 'package:finance_app/colors/colors.dart';
import 'package:finance_app/cubit/add_cubit/add_data_cubit_cubit.dart';
import 'package:finance_app/cubit/fetch_cubit/fetch_data_cubit.dart';
import 'package:finance_app/models/finance_model.dart';
import 'package:finance_app/pages/add.dart';
import 'package:finance_app/pages/see_all.dart';
import 'package:finance_app/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    print('THIS IS INIT STATE FFROM HOME PAGE');
    // TODO: implement initState
    super.initState();
    BlocProvider.of<FetchDataCubit>(context).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final blocProviderFetchDAta = BlocProvider.of<FetchDataCubit>(context);

    return ValueListenableBuilder(
      valueListenable: Hive.box("darkModeBox").listenable(),

      builder: (context, box, child) {
        var dartTheme = box.get('darkMode', defaultValue: false);

        return Scaffold(
          appBar: AppBar(
            title: const Text("Welcome Ahmed"),
            actions: [
              IconButton(
                icon: Icon(dartTheme ? Icons.sunny : Icons.dark_mode),
                onPressed: () {
                  box.put('darkMode', !dartTheme);
                },
              ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: secondryGreenColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        child: Text(
                          "A",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Ahmed Alwhali",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: dartTheme
                      ? Icon(Icons.dark_mode)
                      : Icon(Icons.light_mode),
                  trailing: Switch(
                    value: dartTheme,
                    onChanged: (value) {
                      box.put('darkMode', value);
                    },
                  ),
                  title: Text("Dark Mode"),
                  onTap: () {
                    box.put('darkMode', !dartTheme);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  trailing: Icon(Icons.arrow_right),
                  title: Text("Home"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.add),
                  trailing: Icon(Icons.arrow_right),
                  title: Text("Add"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.add),
                  trailing: Icon(Icons.arrow_right),
                  title: Text("Minus"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddPage(isMinus: true),
                      ),
                    );
                  },
                ),

                ListTile(
                  leading: Icon(Icons.list),
                  trailing: Icon(Icons.arrow_right),
                  title: Text("See All"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SeeAll()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  trailing: Icon(Icons.arrow_right),
                  title: Text("Settings"),
                  onTap: () {
                    // Navigator.pop(context);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Settings()),
                    // );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app),

                  title: Text("Exit"),
                  onTap: () {
                    // SystemNavigator.pop();
                    exit(0);
                  },
                ),
              ],
            ),
          ),
          body: BlocBuilder<FetchDataCubit, FetchDataState>(
            builder: (context, state) => Padding(
              padding: const EdgeInsets.all(16),
              child: state is FetchDataLoading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        SizedBox(
                          height: 150,

                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,

                                child: Container(
                                  decoration: BoxDecoration(
                                    color: blackcColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "My Balance",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          NumberFormat.compactCurrency(
                                            decimalDigits: 1,
                                            symbol: '\YR',
                                          ).format(
                                            blocProviderFetchDAta
                                                .sumTotalBalance,
                                          ),

                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: secondrypurbleColor,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 16),
                        SizedBox(
                          height: 150,

                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: blackcColor,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Today's Balance",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          NumberFormat.compactCurrency(
                                            decimalDigits: 1,
                                            symbol: '\YR',
                                          ).format(
                                            blocProviderFetchDAta
                                                .sumToDayBalance,
                                          ),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: secondryRedColor,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24),

                        SizedBox(
                          height: 50,
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddPage(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: secondryGreenColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.add, color: blackcColor),
                                        SizedBox(width: 8),
                                        Text(
                                          'Plus',
                                          style: TextStyle(
                                            color: blackcColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AddPage(isMinus: true),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: secondryRedColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.remove, color: blackcColor),
                                        SizedBox(width: 8),
                                        Text(
                                          'Minus',
                                          style: TextStyle(
                                            color: blackcColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Activity',
                              style: TextStyle(
                                // color: blackcColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SeeAll(),
                                  ),
                                );
                              },
                              child: Text(
                                'See All',
                                style: TextStyle(
                                  // color: blackcColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Expanded(
                          child: ListView.builder(
                            // shrinkWrap: true,
                            // physics: NeverScrollableScrollPhysics(),
                            // addAutomaticKeepAlives: true,
                            itemCount: blocProviderFetchDAta
                                .fetchDateDate(DateTime.now())
                                .length,
                            itemBuilder: (context, index) {
                              List<FinanceModel> mylist = blocProviderFetchDAta
                                  .todayFinanceDataList
                                  .reversed
                                  .toList();

                              return Dismissible(
                                background: Container(
                                  color: secondryGreenColor,
                                  // alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 20),
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit, color: blackcColor),
                                      SizedBox(width: 8),
                                      Text(
                                        'Edit',
                                        style: TextStyle(
                                          color: blackcColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                secondaryBackground: Container(
                                  color: secondryRedColor,
                                  // alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(right: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Delete',
                                        style: TextStyle(
                                          color: blackcColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Icon(Icons.delete, color: blackcColor),
                                    ],
                                  ),
                                ),
                                key: UniqueKey(),

                                confirmDismiss: (direction) async {
                                  if (direction ==
                                      DismissDirection.endToStart) {
                                    return await showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Confirm Delete'),
                                        content: const Text(
                                          'Are you sure you want to delete this item?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.of(
                                              context,
                                            ).pop(false),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(true),
                                            child: const Text(
                                              'Delete',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  return true;
                                },

                                onDismissed: (direction) {
                                  if (direction ==
                                      DismissDirection.startToEnd) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddPage(
                                          financeModel: mylist[index],
                                          isMinus:
                                              mylist[index].financeValue < 0,
                                        ),
                                      ),
                                    );
                                  } else {
                                    mylist[index].delete();
                                    BlocProvider.of<FetchDataCubit>(
                                      context,
                                    ).fetchData();
                                  }
                                },

                                child: ListTileOfElement(
                                  financeModel: mylist[index],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}

class ListTileOfElement extends StatelessWidget {
  FinanceModel financeModel;
  ListTileOfElement({super.key, required this.financeModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: secondryBlueColor),
        title: Text(
          financeModel.details,
          style: TextStyle(
            // color: blackcColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          DateFormat.MMMMEEEEd().format(financeModel.dateTime),

          style: TextStyle(
            // color: blackcColor,
            fontSize: 14,
          ),
        ),
        trailing: Text(
          financeModel.financeValue > 0
              ? "\$ +${financeModel.financeValue.toString()}"
              : "\$ ${financeModel.financeValue.toString()}",
          style: TextStyle(
            // color: blackcColor,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
