import 'package:flutter/material.dart';

class ColumnText extends StatelessWidget {
  final String heading;
  final String subHeading;
  final Color? color;
  const ColumnText({
    super.key,
    required this.heading,
    required this.subHeading, this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [Text(heading), Text(subHeading,style: TextStyle(fontWeight: FontWeight.bold,color: color),)],
    );
  }
}
