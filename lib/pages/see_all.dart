import 'package:finance_app/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SeeAll extends StatefulWidget {
  const SeeAll({super.key});

  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime mySelectedDay = DateTime.now();
  DateTime myFocusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
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
                });
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ListTileOfElement();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListTileOfElement extends StatelessWidget {
  const ListTileOfElement({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: secondryBlueColor),
      title: Text(
        'Amazon',
        style: TextStyle(
          color: blackcColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        '20 Jan 2024',
        style: TextStyle(color: blackcColor, fontSize: 14),
      ),
      trailing: Text(
        '-\$50',
        style: TextStyle(color: blackcColor, fontSize: 14),
      ),
    );
  }
}
