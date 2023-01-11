import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_jobs/widgets/set_up_account.dart';
import 'package:geolocator/geolocator.dart';

import '../home_screen.dart';

class GeolocatorWidget extends StatefulWidget {
  const GeolocatorWidget({Key? key}) : super(key: key);

  @override
  _GeolocatorWidgetState createState() => _GeolocatorWidgetState();
}

class _GeolocatorWidgetState extends State<GeolocatorWidget> {
  // String locationMessage = "Current location of the User";
  // late double lang;
  // late double latit;

  // Future<Position> getCurrentLocation2() async {
  //   bool serviceEnable = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnable) {
  //     return Future.error('Location service is disabled');
  //   }
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         "Location permissons are  permanentl danied, we cannot request permission");
  //   }
  //   return await Geolocator.getCurrentPosition();
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(''
             // locationMessage,
             // textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () {
                // getCurrentLocation2().then((value) {
                //   lang = double.parse('${value.longitude}');
                //   latit = double.parse('${value.latitude}');
                //   setState(() {
                //     locationMessage = 'longitude:$lang, latitude:$latit';
                //   });
                //   print('jalgas' + locationMessage);
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => SetUpAccount()));
                // });
              },
              child: Text("Найти ваше меcто нахождение"),
            ),
          ],
        ),
      ),
    );
  }
}
