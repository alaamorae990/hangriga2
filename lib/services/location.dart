// import 'dart:async';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:location/location.dart' as loc;
// import 'package:permission_handler/permission_handler.dart';
//
// import '../consts/firebase_consts.dart';
// import 'my_map.dart';
// class LocationScreen extends StatefulWidget {
//   const LocationScreen({Key? key}) : super(key: key);
//
//   @override
//   State<LocationScreen> createState() => _LocationScreenState();
// }
//
// class _LocationScreenState extends State<LocationScreen> {
//   final User? user = authInstance.currentUser;
//    String? _name;
//       final loc.Location location = loc.Location();
//   StreamSubscription<loc.LocationData>? _locationSubscription;
//   @override
//   Widget build(BuildContext context) {
//  return Scaffold(
//       appBar: AppBar(
//         title: Text('live location tracker'),
//       ),
//       body: Column(
//         children: [
//           TextButton(
//               onPressed: () {
//                 _getLocation();
//               },
//               child: Text('add my location')),
//           TextButton(
//               onPressed: () {
//                 _listenLocation();
//               },
//               child: Text('enable live location')),
//           TextButton(
//               onPressed: () {
//                 _stopListening();
//               },
//               child: Text('stop live location')),
//           Expanded(
//               child: StreamBuilder(
//             stream:
//                 FirebaseFirestore.instance.collection('location').snapshots(),
//             builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (!snapshot.hasData) {
//                 return Center(child: CircularProgressIndicator());
//               }
//               return ListView.builder(
//                   itemCount: snapshot.data?.docs.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title:
//                           Text(snapshot.data!.docs[index]['name'].toString()),
//                       subtitle: Row(
//                         children: [
//                           Text(snapshot.data!.docs[index]['latitude']
//                               .toString()),
//                           SizedBox(
//                             width: 20,
//                           ),
//                           Text(snapshot.data!.docs[index]['longitude']
//                               .toString()),
//                               // Text(snapshot.data!.docs[index]['id']
//                               // .toString()),
//                         ],
//                       ),
//                       trailing: IconButton(
//                         icon: Icon(Icons.directions),
//                         onPressed: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: (context) =>
//                                   MyMap(snapshot.data!.docs[index].id)));
//                         },
//                       ),
//                     );
//                   });
//             },
//           )),
//         ],
//       ),
//     );
//   }
//
//   _getLocation() async {
//     try {
//       final loc.LocationData _locationResult = await location.getLocation();
//
//       String _uid = user!.uid;
//
//       await FirebaseFirestore.instance.collection('location').doc(_uid).set({
//         'latitude': _locationResult.latitude,
//         'longitude': _locationResult.longitude,
//         'id':_uid,
//         'name':user!.displayName,
//       }, SetOptions(merge: true));
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Future<void> _listenLocation() async {
//     _locationSubscription = location.onLocationChanged.handleError((onError) {
//       print(onError);
//       _locationSubscription?.cancel();
//       setState(() {
//         _locationSubscription = null;
//       });
//     }).listen((loc.LocationData currentlocation) async {
//       String _uid = user!.uid;
//       await FirebaseFirestore.instance.collection('location').doc(_uid).set({
//         'latitude': currentlocation.latitude,
//         'longitude': currentlocation.longitude,
//          'id':_uid,
//         'name':user!.displayName,
//         // 'name': 'john'
//       }, SetOptions(merge: true));
//     });
//   }
//
//   _stopListening() {
//     _locationSubscription?.cancel();
//     setState(() {
//       _locationSubscription = null;
//     });
//   }
//
//   _requestPermission() async {
//     var status = await Permission.location.request();
//     if (status.isGranted) {
//       print('done');
//     } else if (status.isDenied) {
//       _requestPermission();
//     } else if (status.isPermanentlyDenied) {
//       openAppSettings();
//     }
//   }
// }
