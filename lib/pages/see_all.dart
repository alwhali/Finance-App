import 'package:finance_app/colors/colors.dart';
import 'package:finance_app/cubit/fetch_cubit/fetch_data_cubit.dart';
import 'package:finance_app/models/finance_model.dart';
import 'package:finance_app/pages/add.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class SeeAll extends StatefulWidget {
  const SeeAll({super.key});

  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  late CalendarFormat calendarFormat = CalendarFormat.month;
  late DateTime mySelectedDay = DateTime.now();
  late DateTime myFocusedDay = DateTime.now();

  @override
  void initState() {
    print('THIS IS INIT STATE FFROM SEE ALL PAGE');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final blocProviderFetchData = BlocProvider.of<FetchDataCubit>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('See All')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2026, 1, 1),
              lastDay: DateTime.now(),
              focusedDay: DateTime.now(),
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
                  blocProviderFetchData.fetchDateDate(mySelectedDay);
                });
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<FetchDataCubit, FetchDataState>(
                builder: (context, state) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: blocProviderFetchData
                      .fetchDateDate(mySelectedDay)
                      .length,
                  itemBuilder: (context, index) {
                    List<FinanceModel> mylist = blocProviderFetchData
                        .fetchDateDate(mySelectedDay)
                        .toList();

                    return Dismissible(
                      background: Container(
                        color: secondryGreenColor,
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            const Icon(Icons.edit, color: Colors.white),
                            const SizedBox(width: 8),
                            Text(
                              'Edit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      secondaryBackground: Container(
                        color: secondryRedColor,
                        padding: const EdgeInsets.only(right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Delete',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.delete, color: Colors.white),
                          ],
                        ),
                      ),
                      key: UniqueKey(),
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.endToStart) {
                          return await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Confirm Delete'),
                              content: const Text(
                                'Are you sure you want to delete this item?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return true;
                      },
                      onDismissed: (direction) {
                        if (direction == DismissDirection.startToEnd) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddPage(
                                financeModel: mylist[index],
                                isMinus: mylist[index].financeValue < 0,
                              ),
                            ),
                          );
                        } else {
                          mylist[index].delete();
                          BlocProvider.of<FetchDataCubit>(context).fetchData();
                        }
                      },
                      child: ListTileOfElement(financeModel: mylist[index]),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListTileOfElement extends StatelessWidget {
  final FinanceModel financeModel;
  const ListTileOfElement({super.key, required this.financeModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: secondryBlueColor),
        title: Text(
          financeModel.details,
          style: TextStyle(
            color: blackcColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          DateFormat.MMMMEEEEd().format(financeModel.dateTime),
          style: TextStyle(color: blackcColor, fontSize: 14),
        ),
        trailing: Text(
          financeModel.financeValue > 0
              ? "\$ +${financeModel.financeValue.toString()}"
              : "\$ ${financeModel.financeValue.toString()}",
          style: TextStyle(color: blackcColor, fontSize: 14),
        ),
      ),
    );
  }
}
