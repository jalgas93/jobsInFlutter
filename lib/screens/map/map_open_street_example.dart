// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
//
// import 'package:tuple/tuple.dart';
// import 'package:latlong/latlong.dart';
// import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';
// import 'package:transparent_image/transparent_image.dart';
// import 'package:async/async.dart';
//
// import 'package:geocode/geocode.dart';
// import 'package:proj4dart/proj4dart.dart';
// import 'package:meta/meta.dart';
// import 'package:collection/collection.dart';
//
// class OpenStreetMap extends StatefulWidget {
//   const OpenStreetMap({Key? key}) : super(key: key);
//
//   @override
//   _OpenStreetMapState createState() => _OpenStreetMapState();
// }
//
// class _OpenStreetMapState extends State<OpenStreetMap> {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         FlutterMap(
//           options: MapOptions(center: LatLng(49.5, -0.09), zoom: 10.0),
//           layers: [
//             TileLayerOptions(
//               urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//               subdomains: ['a', 'b', 'c'],
//             ),
//             MarkerLayerOptions(markers: [
//               Marker(
//                   width: 100.0,
//                   height: 100.0,
//                   point: point,
//                   builder: (ctx) => Icon(
//                         Icons.location_on,
//                         color: Colors.red,
//                       ),
//               )
//             ])
//           ],
//         ),
//       ],
//     );
//   }
// }
