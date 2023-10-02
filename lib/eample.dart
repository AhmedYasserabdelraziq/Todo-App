import 'package:flutter/material.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/widget/custom_appbar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Week Day List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WeekDayList(),
    );
  }
}

class WeekDayList extends StatelessWidget {
  const WeekDayList({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now().subtract(const Duration(days: 2));
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Column(
            children: [
              CustomAppbar(
                title: 'To Do List',
                hieght: 200,
                backgroundColor: AppColors.primary,
              ),
            ],
          ),
          Positioned(
            top: 180,
            child: SizedBox(
              height: 117,
              width: 500,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  DateTime? dayToShow = now.add(Duration(days: index));
                  return DayCard(dayToShow: dayToShow);
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          now = now.add(const Duration(days: 1));
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}

class DayCard extends StatelessWidget {
  final DateTime dayToShow;

  const DayCard({super.key, required this.dayToShow});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 82,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                weekDayName(dayToShow.weekday),
                style: TextStyle(
                  fontSize: dayToShow.day == DateTime.now().day ? 20 : 11,
                  color: dayToShow.day == DateTime.now().day
                      ? AppColors.primary
                      : Colors.black87,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                '${dayToShow.day}',
                style: TextStyle(
                  fontSize: 50,
                  color: dayToShow.day == DateTime.now().day
                      ? AppColors.primary
                      : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String weekDayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }
}
