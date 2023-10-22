import 'package:flutter/material.dart';

class EditingDay extends StatelessWidget {
  final bool isBack;

  const EditingDay(this.isBack, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 82,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 10,
        child: Center(
          child: isBack
              ? const Icon(Icons.arrow_back_ios_new)
              : const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
