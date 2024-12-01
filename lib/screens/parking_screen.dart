// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:park/widgets/CarSlot.dart';
// import 'package:park/widgets/CustomAppBar.dart';
// import 'package:park/widgets/InfoContainer.dart';

// class ParkingScreen extends StatefulWidget {
//   const ParkingScreen({Key? key}) : super(key: key);

//   @override
//   State<ParkingScreen> createState() => _ParkingScreenState();
// }

// class _ParkingScreenState extends State<ParkingScreen> {
//   List<Map<String, dynamic>> data = [];
//   bool isLoading = false;
//   List<Map<String, dynamic>> leftSlots = [];
//   List<Map<String, dynamic>> rightSlots = [];
//   String statusText = '';
//   String availableSlotNumber = '';

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

// Future<void> fetchData() async {
//   setState(() {
//     isLoading = true;
//   });

//   try {
//     DatabaseReference ref = FirebaseDatabase.instance.ref('parkingSlots');
//     DatabaseEvent event = await ref.once();

//     if (event.snapshot.exists) {
//       // Convert the snapshot data (LinkedMap) to List<Map<String, dynamic>>
//       var dataSnapshot = event.snapshot.value as List<dynamic>;
//       List<Map<String, dynamic>> jsonData = dataSnapshot
//           .map((item) => Map<String, dynamic>.from(item as Map))
//           .toList();

//       setState(() {
//         data = jsonData;

//         // Filter slots into left and right based on 'left_or_right' value
//         leftSlots =
//             data.where((slot) => slot['left_or_right'] == 'L').toList();
//         rightSlots =
//             data.where((slot) => slot['left_or_right'] == 'R').toList();

//         // Check if there are any available slots
//         bool isAvailable = data.any((slot) => slot['state'] == 1);
//         statusText = isAvailable ? 'Available' : 'Unavailable';

//         // Find the first available slot number
//         availableSlotNumber = isAvailable
//             ? data.firstWhere((slot) => slot['state'] == 1)['slot_number']
//             : '';

//         isLoading = false;
//       });
//     }
//   } catch (e) {
//     print('Error fetching data from Firebase: $e');
//     setState(() {
//       isLoading = false;
//     });
//   }
// }

//   Future<void> changeSlotState(int slotId, int newState) async {
//     try {
//       DatabaseReference ref =
//           FirebaseDatabase.instance.ref('parkingSlots/$slotId');
//       await ref.update({'state': newState});
//       print('Slot state changed successfully');
//       // Refresh data after state change
//       fetchData();
//     } catch (e) {
//       print('Error changing slot state in Firebase: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: const CustomAppBar(
//         text: Text("Choose a Spot"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           children: [
//             // Info Container
//             InfoContainer(
//               height: height,
//               statusText: statusText,
//               availableSlotNumber: availableSlotNumber,
//             ),
//             // Parking Slot

//             // Column 1
//             Expanded(
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: leftSlots.length,
//                       itemBuilder: (context, index) {
//                         return CarSlot(
//                           slotNumber: leftSlots[index]['slot_number'],
//                           isAvailable: leftSlots[index]['state'] == 1,
//                           height: height,
//                           width: width,
//                           onTap: () {
//                             changeSlotState(
//                               leftSlots[index]['id'],
//                               leftSlots[index]['state'] == 1 ? 0 : 1,
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ),

//                   // Vertical Divider
//                   const VerticalDivider(thickness: 2),

//                   // Column 2
//                   Expanded(
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: rightSlots.length,
//                       itemBuilder: (context, index) {
//                         return CarSlot(
//                           slotNumber: rightSlots[index]['slot_number'],
//                           isAvailable: rightSlots[index]['state'] == 1,
//                           height: height,
//                           width: width,
//                           onTap: () {
//                             changeSlotState(
//                               rightSlots[index]['id'],
//                               rightSlots[index]['state'] == 1 ? 0 : 1,
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Text("Entry"),
//             const SizedBox(height: 10),
//             // Book spot Button
//             // CustomButton(buttonText: "Book Spot", height: height),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:park/widgets/CarSlot.dart';
import 'package:park/widgets/CustomAppBar.dart';
import 'package:park/widgets/InfoContainer.dart';

class ParkingScreen extends StatefulWidget {
  const ParkingScreen({Key? key}) : super(key: key);

  @override
  State<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  List<Map<String, dynamic>> data = [];
  bool isLoading = false;
  List<Map<String, dynamic>> leftSlots = [];
  List<Map<String, dynamic>> rightSlots = [];
  String statusText = '';
  String availableSlotNumber = '';

  late DatabaseReference ref;

  @override
  void initState() {
    super.initState();
    ref = FirebaseDatabase.instance.ref('parkingSlots');
    listenToParkingSlotChanges();
  }

  void listenToParkingSlotChanges() {
    setState(() {
      isLoading = true;
    });

    // Listen for real-time updates on the parkingSlots node
    ref.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.exists) {
        var dataSnapshot = event.snapshot.value as List<dynamic>;
        List<Map<String, dynamic>> jsonData = dataSnapshot
            .map((item) => Map<String, dynamic>.from(item as Map))
            .toList();

        setState(() {
          data = jsonData;

          // Filter slots into left and right based on 'left_or_right' value
          leftSlots =
              data.where((slot) => slot['left_or_right'] == 'L').toList();
          rightSlots =
              data.where((slot) => slot['left_or_right'] == 'R').toList();

          // Check if there are any available slots
          bool isAvailable = data.any((slot) => slot['state'] == 1);
          statusText = isAvailable ? 'Available' : 'Unavailable';

          // Find the first available slot number
          availableSlotNumber = isAvailable
              ? data.firstWhere((slot) => slot['state'] == 1)['slot_number']
              : '';

          isLoading = false;
        });
      }
    }, onError: (error) {
      print('Error listening to Firebase updates: $error');
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> changeSlotState(int slotId, int newState) async {
    try {
      DatabaseReference slotRef =
          FirebaseDatabase.instance.ref('parkingSlots/$slotId');
      await slotRef.update({'state': newState});
      print('Slot state changed successfully');
    } catch (e) {
      print('Error changing slot state in Firebase: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const CustomAppBar(
        text: Text("Choose a Spot"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Info Container
            InfoContainer(
              height: height,
              statusText: statusText,
              availableSlotNumber: availableSlotNumber,
            ),
            // Parking Slots

            // Column 1
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: leftSlots.length,
                      itemBuilder: (context, index) {
                        return CarSlot(
                          slotNumber: leftSlots[index]['slot_number'],
                          isAvailable: leftSlots[index]['state'] == 1,
                          height: height,
                          width: width,
                          onTap: () {
                            changeSlotState(
                              leftSlots[index]['id'],
                              leftSlots[index]['state'] == 1 ? 0 : 1,
                            );
                          },
                        );
                      },
                    ),
                  ),

                  // Vertical Divider
                  const VerticalDivider(thickness: 2),

                  // Column 2
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: rightSlots.length,
                      itemBuilder: (context, index) {
                        return CarSlot(
                          slotNumber: rightSlots[index]['slot_number'],
                          isAvailable: rightSlots[index]['state'] == 1,
                          height: height,
                          width: width,
                          onTap: () {
                            changeSlotState(
                              rightSlots[index]['id'],
                              rightSlots[index]['state'] == 1 ? 0 : 1,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text("Entry"),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
