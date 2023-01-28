import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlng/latlng.dart';

class User {
  String? uid;
  String? firstname;
  String? lastname;
  String? address;
  DateTime? creatAt;
  bool? isVerified;
  LatLng? latlng;
  String? phone;
  int? km;
  int? summa;
  String? carName;
  String? carColor;
  String? carNumber;
  bool? isActive;

  //String? image;

  User.fromjson(String? uid, Map<String, dynamic> data) {
    this.uid = uid;
    if (data.containsKey('firstname')) {
      firstname = data['firstname'];
    }
    if (data.containsKey('lastname')) {
      lastname = data['lastname'];
    }
    if (data.containsKey('isVerified')) {
      isVerified = data['isVerified'];
    }
    if (data.containsKey('creatAt')) {
      creatAt = DateTime.fromMicrosecondsSinceEpoch(
          data['creatAt'].millisecondsSinceEpoch);
    }
    if (data.containsKey('latlng')) {
      latlng = data['latlng'] == null
          ? LatLng(0, 0)
          : LatLng(data['latlng']['lat'], data['latlng']['lng']);
    }
    if (data.containsKey('address')) {
      address = data['address'];
    }
    if (data.containsKey('phone')) {
      phone = data['phone'];
    }
    if (data.containsKey('km')) {
      km = data['km'];

    }
    if (data.containsKey('summa')) {
      summa = data['summa'];
    }
    if (data.containsKey('carName')) {
      carName = data['carName'];
    }
    if (data.containsKey('carColor')) {
      carColor = data['carColor'];
    }
    if (data.containsKey('carNumber')) {
      carNumber = data['carNumber'];
    }
    if (data.containsKey('isActive')) {
      isActive = data['isActive'];
    }
    // if (data.containsKey('image')) {
    //   image = data['image'];
    // }
  }
}
