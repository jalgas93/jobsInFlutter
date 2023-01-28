import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_jobs/style/app_style.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_map/flutter_map.dart';

class GeolocatorWidget extends StatefulWidget {
  const GeolocatorWidget({
    Key? key,
    //required this.locationMessage,
    required this.locationMessage,
     required this.lang,
     required this.latit
  }) : super(key: key);
  final String locationMessage;
 // final TextEditingController? locationMessage ;

    final double lang;
    final double latit;

  @override
  _GeolocatorWidgetState createState() => _GeolocatorWidgetState();
}

class _GeolocatorWidgetState extends State<GeolocatorWidget> {


  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: 5.0, right: 5.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Для работы приложение \n разрешите доступ к \n геолокации в настройках \n телефона',
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
