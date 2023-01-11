
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlng/latlng.dart';

class User{
  String? uid;
  String? firstname;
  String? lastname;
  DateTime? creatAt;
  bool? isVerified;
  LatLng? latlng;
  bool? isActive;


  User.fromjson(String? uid,Map<String,dynamic>data){
    this.uid = uid;
    if (data.containsKey('isVerified')) {
      isVerified = data['isVerified'];
    }
    if (data.containsKey('firstname')) {
      firstname = data['firstname'];
    }
    if (data.containsKey('lastname')) {
      lastname = data['lastname'];
    }
    if (data.containsKey('latlng')) {
      latlng = data['latlng'];
    }
    if (data.containsKey('isActive')) {
      isActive = data['isActive'];
    }
    if (data.containsKey('creatAt')) {
      creatAt = DateTime.fromMicrosecondsSinceEpoch(data['creatAt'].millisecondsSinceEpoch);

    }


  }


}