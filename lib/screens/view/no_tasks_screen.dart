import 'package:flutter/cupertino.dart';

class NoTasksScreen extends StatelessWidget {
  const NoTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No tasks added yet.'),
    );
  }
}
