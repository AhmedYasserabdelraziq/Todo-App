import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar(
      {required this.title, this.backgroundColor = Colors.white, Key? key,required, required this.hieght })
      : super(key: key);
  final String title;
  final Color backgroundColor;
  final double hieght;

  @override
  Widget build(BuildContext context) {
    return AppBar(toolbarHeight: hieght,
      title: Text(title),
      elevation: 0,
      backgroundColor: backgroundColor,
      actions: const [],
    );
  }
}
