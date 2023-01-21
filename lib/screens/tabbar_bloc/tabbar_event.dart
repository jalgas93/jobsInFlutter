import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

abstract class TabbarEvent extends Equatable {
  const TabbarEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingEvent extends TabbarEvent {

}

class ErrorEvent extends TabbarEvent {
  final String error;

  ErrorEvent(this.error);
}

class SendEvent extends TabbarEvent {
  final String? uid;
  final String firstname;
  final String address;
  final String phone;

//   final LatLng latLng;
//   final DateTime date;
//   final bool isActive;
//
  SendEvent(this.firstname, this.address, this.phone, this.uid);
}

class AsseptEvent extends TabbarEvent {
  final String? uid;
  final String firstname;
  final String address;
  final String carName;
  final String carColor;
  final String carNumber;
  final String phone;
  final int km;
  final int summa;

  AsseptEvent( this.uid,this.firstname, this.address, this.carName, this.carColor,
      this.carNumber, this.phone, this.km, this.summa);
//   final LatLng latLng;
}
