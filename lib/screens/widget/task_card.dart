import 'package:flutter/material.dart';
import 'package:todo_app/screens/model/todo_model.dart';
import 'package:todo_app/utils/colors.dart';

class BuildCard extends StatelessWidget {
  final TodoModel viewModel;

  const BuildCard({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 3,
              color: AppColors.primary,
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  viewModel.title,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),const SizedBox(
                  height: 10,
                ),
                Text(
                  viewModel.dateTime.toString(),
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
