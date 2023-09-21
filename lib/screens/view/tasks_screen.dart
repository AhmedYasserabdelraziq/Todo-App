import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return const Card(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text('data'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Divider(
                    height: 1,
                    thickness: 2,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text('description'),
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: 10,
      ),
    );
  }
}
