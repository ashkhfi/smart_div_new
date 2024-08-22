// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:smart_div_new/Provider/sensor_provider.dart';

// class RelayControl extends StatefulWidget {
//   @override
//   _RelayControlState createState() => _RelayControlState();
// }

// class _RelayControlState extends State<RelayControl> {
//   bool _relay1Status = false; // Switch untuk Relay 1
//   bool _relay2Status = false; // Switch untuk Relay 2

//   @override
//   Widget build(BuildContext context) {
//     final sensorProvider = Provider.of<SensorProvider>(context);
//     bool baterai = (sensorProvider.sensor!.relay1 == "HIGH" &&
//                 sensorProvider.sensor!.relay2 == "HIGH") ||
//             sensorProvider.sensor!.relay1 == "true" &&
//                 sensorProvider.sensor!.relay2 == "true"
//         ? true
//         : false;
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: 200,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(baterai ? "Baterai" : "PLN"),

//             // Switch untuk Relay 1
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('BATERAI'),
//                 Switch(
//                   value: baterai,
//                   onChanged: (value) {
//                     Provider.of<SensorProvider>(context, listen: false)
//                         .updateRelay("HIGH", "HIGH");
//                   },
//                 ),
//               ],
//             ),

//             // Switch untuk Relay 2
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('PLN'),
//                 Switch(
//                   value: !baterai,
//                   onChanged: (value) {
//                     Provider.of<SensorProvider>(context, listen: false)
//                         .updateRelay("LOW", "LOW");
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
