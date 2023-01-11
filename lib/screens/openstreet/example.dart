import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:open_street_map_search_and_pick/widgets/wide_button.dart';

import 'example.dart';
import 'example.dart';

class OpenStreetMapExample extends StatefulWidget {
  //final LatLong center;

  //final void Function(PickedData pickedData) onPicked;
  Color buttonColor;

//  String buttonText;

  OpenStreetMapExample({
    Key? key,
    //required this.center,
    // required this.onPicked,
    this.buttonColor = Colors.blue,
    // this.buttonText = 'Set Current Location',
  }) : super(key: key);

  @override
  State<OpenStreetMapExample> createState() => _OpenStreetMapExampleState();
}

class _OpenStreetMapExampleState extends State<OpenStreetMapExample> {
  MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<OSMdata> _options = <OSMdata>[];
  Timer? _debounce;

  // void setNameCurrentPos() async {
  //   var client = http.Client();
  //   double latitude = _mapController.center.latitude;
  //   double longitude = _mapController.center.longitude;
  //   if (kDebugMode) {
  //     print(latitude);
  //   }
  //   if (kDebugMode) {
  //     print(longitude);
  //   }
  //   String url =
  //       'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1';
  //
  //   var response = await client.post(Uri.parse(url));
  //   var decodedResponse =
  //   jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;
  //
  //   _searchController.text =
  //       decodedResponse['display_name'] ?? "MOVE TO CURRENT POSITION";
  //   setState(() {});
  // }

  // void setNameCurrentPosAtInit() async {
  //   var client = http.Client();
  //   double latitude = widget.center.latitude;
  //   double longitude = widget.center.longitude;
  //   if (kDebugMode) {
  //     print(latitude);
  //   }
  //   if (kDebugMode) {
  //     print(longitude);
  //   }
  //   String url =
  //       'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1';
  //
  //   var response = await client.post(Uri.parse(url));
  //   var decodedResponse =
  //   jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;
  //
  //   _searchController.text =
  //       decodedResponse['display_name'] ?? "MOVE TO CURRENT POSITION";
  //   setState(() {});
  // }

  String locationMessage = "Current location of the User";
  late double lang;
  late double latit;

  @override
  void initState() {
    _mapController = MapController();

    // _mapController.onReady.then((_) {
    //   setNameCurrentPosAtInit();
    // });

    _mapController.mapEventStream.listen((event) async {
      if (event is MapEventMoveEnd) {
        var client = http.Client();
        String url =
            'https://nominatim.openstreetmap.org/reverse?format=json&lat=${event.center.latitude}&lon=${event.center.longitude}&zoom=18&addressdetails=1';

        var response = await client.post(Uri.parse(url));
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes))
            as Map<dynamic, dynamic>;

        _searchController.text = decodedResponse['display_name'];

        setState(() {});
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: widget.buttonColor),
    );
    OutlineInputBorder inputFocusBorder = OutlineInputBorder(
      borderSide: BorderSide(color: widget.buttonColor, width: 3.0),
    );

    // String? _autocompleteSelection;
    return SafeArea(
      child: Stack(
        children: [
          Positioned.fill(
              child: FlutterMap(
            options: MapOptions(
               // center: LatLng(widget.center.latitude, widget.center.longitude),
                zoom: 15.0,
                maxZoom: 18,
                minZoom: 6),
            mapController: _mapController,
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
                // attributionBuilder: (_) {
                //   return Text("© OpenStreetMap contributors");
                // },
              ),
            ],
          )),
          Positioned(
              // top: MediaQuery.of(context).size.height * 0.5,
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: Center(
                  child: StatefulBuilder(builder: (context, setState) {
                    return Text(
                      _searchController.text,
                      textAlign: TextAlign.center,
                    );
                  }),
                ),
              )),
          Positioned.fill(
              child: IgnorePointer(
            child: Center(
              child:
                  Icon(Icons.location_pin, size: 50, color: widget.buttonColor),
            ),
          )),

          Positioned(
              bottom: 250,
              right: 5,
              child: FloatingActionButton(
                heroTag: 'button_current_location',
                backgroundColor: widget.buttonColor,
                onPressed: () {
                  getCurrentLocation2().then((value) {
                    lang = double.parse('${value.longitude}');
                    latit = double.parse('${value.latitude}');

                    setState(() {
                      locationMessage = 'longitude:$lang, latitude:$latit';

                      _mapController.move(
                          LatLng(latit, lang), _mapController.zoom);
                           //  _searchController.text = ;
                      _mapController.mapEventStream.listen((event) async {
                        if (event is MapEventMoveEnd) {
                          var client = http.Client();
                          String url =
                              'https://nominatim.openstreetmap.org/reverse?format=json&lat=${latit}&lon=${lang}&zoom=18&addressdetails=1';

                          var response = await client.post(Uri.parse(url));
                          var decodedResponse =
                              jsonDecode(utf8.decode(response.bodyBytes))
                                  as Map<dynamic, dynamic>;

                          _searchController.text =
                              decodedResponse['display_name'];

                          setState(() {});
                        }
                      });
                    });
                    print('jalgas' + locationMessage);
                  });


                  pickData().then((value){
                    var a = value.address;
                    setState(() {
                      _searchController.text = a;
                      print('jalgassss:${a}');
                    });
                  });
                },
                child: Icon(
                  Icons.my_location,
                  color: Colors.black,
                ),
              )),
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   right: 0,
          //   child: Container(
          //     margin: const EdgeInsets.all(15),
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.circular(5),
          //     ),
          //     child: Column(
          //       children: [
          //         StatefulBuilder(builder: ((context, setState) {
          //           return ListView.builder(
          //               shrinkWrap: true,
          //               physics: const NeverScrollableScrollPhysics(),
          //               itemCount: _options.length > 5 ? 5 : _options.length,
          //               itemBuilder: (context, index) {
          //                 return ListTile(
          //                   title: Text(_options[index].displayname),
          //                   subtitle: Text(
          //                       '${_options[index].lat},${_options[index].lon}'),
          //                   onTap: () {
          //                     _mapController.move(
          //                         LatLng(
          //                             _options[index].lat, _options[index].lon),
          //                         15.0);
          //
          //                     _focusNode.unfocus();
          //                     _options.clear();
          //                     setState(() {});
          //                   },
          //                 );
          //               });
          //         })),
          //       ],
          //     ),
          //   ),
          // ),
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: Center(
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: WideButton(widget.buttonText, onPressed: () async {
          //         pickData().then((value) {
          //           widget.onPicked(value);
          //         });
          //       }, backgroundcolor: widget.buttonColor),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  Future<PickedData> pickData() async {
    LatLong center = LatLong(
        _mapController.center.latitude, _mapController.center.longitude);
    var client = http.Client();
    String url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=${_mapController.center.latitude}&lon=${_mapController.center.longitude}&zoom=18&addressdetails=1';

    var response = await client.post(Uri.parse(url));
    var decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;
    String displayName = decodedResponse['display_name'];


    _searchController.text = decodedResponse['display_name'];
    return PickedData(center, displayName);
  }

  // Future<PickedData2> PickedData2() async {
  //   LatLong center = LatLong(
  //       _mapController.center.latitude, _mapController.center.longitude);
  //   var client = http.Client();
  //   String url =
  //       'https://nominatim.openstreetmap.org/reverse?format=json&lat=${_mapController.center.latitude}&lon=${_mapController.center.longitude}&zoom=18&addressdetails=1';
  //
  //   var response = await client.post(Uri.parse(url));
  //   var decodedResponse =
  //   jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;
  //   String displayName = decodedResponse['display_name'];
  //   //_searchController.text = decodedResponse['display_name'];
  //   return PickedData2(address);
  // }
}



class OSMdata {
  final String displayname;
  final double lat;
  final double lon;


  OSMdata({required this.displayname, required this.lat, required this.lon});

  @override
  String toString() {
    return '$displayname, $lat, $lon';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is OSMdata && other.displayname == displayname;
  }

  @override
  int get hashCode => Object.hash(displayname, lat, lon);
}

class LatLong {
  final double latitude;
  final double longitude;

  LatLong(this.latitude, this.longitude);
}

class PickedData {
  final LatLong latLong;
  final String address;

  PickedData( this.latLong,this.address);
}


Future<Position> getCurrentLocation2() async {
  bool serviceEnable = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnable) {
    return Future.error('Location service is disabled');
  }
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        "Location permissons are  permanentl danied, we cannot request permission");
  }
  return await Geolocator.getCurrentPosition();
}
