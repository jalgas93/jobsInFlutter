import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_jobs/style/app_style.dart';

class GeolocatorWidget extends StatefulWidget {
  const GeolocatorWidget({Key? key, required this.locationMessage})
      : super(key: key);
  final String locationMessage;

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
      backgroundColor: AppStyle.cardsColor[6],
      body: Padding(
        padding: EdgeInsets.only(left: 5.0,right: 5.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.locationMessage,
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.black45,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 150.0,
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Оброботка запроса...',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              )
              // ElevatedButton(
              //   onPressed: () {
              //     // getCurrentLocation2().then((value) {
              //     //   lang = double.parse('${value.longitude}');
              //     //   latit = double.parse('${value.latitude}');
              //     //   setState(() {
              //     //     locationMessage = 'longitude:$lang, latitude:$latit';
              //     //   });
              //     //   print('jalgas' + locationMessage);
              //     //   Navigator.push(context,
              //     //       MaterialPageRoute(builder: (context) => SetUpAccount()));
              //     // });
              //   },
              //   child: Text("Найти ваше меcто нахождение"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
