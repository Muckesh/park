import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.height,
    required this.buttonText,
  });

  final double height;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.09,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffF8D73A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
          child: Text(
        buttonText,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      )),
    );
  }
}
