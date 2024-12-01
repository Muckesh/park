// import 'package:flutter/material.dart';

// class CarSlot extends StatelessWidget {
//   const CarSlot({
//     super.key,
//     required this.height,
//     required this.isAvailable,
//     required this.width,
//     required this.slot_number,
//   });
//   final String slot_number;
//   final double height;
//   final double width;
//   final bool isAvailable;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const Divider(),
//         isAvailable
//             ? Column(
//                 children: [
//                   SizedBox(
//                     height: height * 0.1,
//                     child: Center(
//                       child: Text(slot_number),
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {},
//                     child: Text("Book"),
//                   ),
//                 ],
//               )
//             : Image.asset(
//                 "assets/images/cars1.png",
//                 height: height * 0.1,
//                 width: width * 0.2,
//               ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:park/widgets/CustomButton.dart';

class CarSlot extends StatelessWidget {
  const CarSlot({
    super.key,
    required this.height,
    required this.isAvailable,
    required this.width,
    required this.slotNumber,
    required this.onTap,
  });

  final String slotNumber;
  final double height;
  final double width;
  final bool isAvailable;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        isAvailable
            ? Column(
                children: [
                  SizedBox(
                    height: height * 0.1,
                    child: Center(
                      child: Text(slotNumber),
                    ),
                  ),
                  // CustomButton(height: height, buttonText: "Free Spot"),
                  ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStateColor.resolveWith(
                          (states) => Colors.black),
                      backgroundColor: WidgetStateColor.resolveWith(
                          (states) => const Color(0xffF8D73A)),
                    ),
                    onPressed: onTap,
                    child: const Text("Book Spot"),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/cars1.png",
                    height: height * 0.1,
                    width: width * 0.2,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  // CustomButton(height: height, buttonText: "Free Spot"),
                  ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStateColor.resolveWith(
                          (states) => Colors.black),
                      backgroundColor: WidgetStateColor.resolveWith(
                          (states) => const Color(0xffF8D73A)),
                    ),
                    onPressed: onTap,
                    child: const Text("Free Spot"),
                  ),
                ],
              ),
      ],
    );
  }
}
