import 'package:flutter/material.dart';

class DayCard extends StatelessWidget {
  final DateTime dayToShow;
  final Color color;
  final String text;

  const DayCard(
      {super.key,
      required this.dayToShow,
      required this.color,
      required this.text});

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
              FittedBox(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: dayToShow.day == DateTime.now().day ? 50 : 11,
                    color: dayToShow.day == DateTime.now().day
                        ? color
                        : Colors.black87,
                  ),
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
                      ? color
                      : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
