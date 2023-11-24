import 'package:flutter/material.dart';

class DayCard extends StatelessWidget {
  final DateTime dayToShow;
  final Color color;
  final String text;
  final int? selectDay;

  const DayCard({
    super.key,
    required this.dayToShow,
    required this.color,
    required this.text,
    required this.selectDay,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: selectDay! == dayToShow.day ? Colors.indigo : Colors.white,
            // Specify border color
            width: 3.0, // Specify border thickness
          ),
        ),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              FittedBox(
                child: Text(
                  text.toUpperCase(),
                  style: TextStyle(
                      fontSize: 19,
                      color: dayToShow.day == DateTime.now().day
                          ? color
                          : Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              FittedBox(
                child: Text(
                  '${dayToShow.day}',
                  style: TextStyle(
                    fontSize: 30,
                    color: dayToShow.day == DateTime.now().day
                        ? color
                        : Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
