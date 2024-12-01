import 'package:flutter/material.dart';

class CTAButton extends StatelessWidget {
  final Icon icon;
  const CTAButton({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: icon,
    );
  }
}
