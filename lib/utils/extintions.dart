import 'package:flutter/material.dart';

extension WidgetExtention on Widget {
  Widget onTap(
    Function function, {
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(5)),
  }) {
    return InkWell(
      onTap: function as void Function()?,
      borderRadius: borderRadius,
      child: this,
    );
  }
}
