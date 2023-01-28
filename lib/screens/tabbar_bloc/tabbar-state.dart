import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

abstract class TabbarState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ErrorState extends TabbarState {
  final String error;

  ErrorState(this.error);
}

class LoadingState extends TabbarState {}

class SendState extends TabbarState {
  final String? uid;
  final String? firstname;
  final String? address;
  final String? phone;

//   final LatLng latLng;
//   final DateTime date;
//   final bool isActive;
  SendState(this.uid,this.firstname, this.address, this.phone);


}

class AcceptState extends TabbarState {
  final String? uid;
  final String? firstname;
  final String? address;
  final String? carName;
  final String? carColor;
  final String? carNumber;
  final String? phone;
  final int? km;
  final int? summa;

//   final LatLng latLng;

  AcceptState(this.uid,this.firstname, this.address, this.phone,  this.carName, this.carColor, this.carNumber, this.km, this.summa);
}
