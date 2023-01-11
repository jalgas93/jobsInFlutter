import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:latlng/latlng.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

class LoadingAuthState extends AuthState {}

class LoggedInState extends AuthState {
  final String? uid;
  final String? firstname;
  final String? lastname;
  final bool? isActive;
  final LatLng? latLng;

  LoggedInState(this.uid, this.firstname, this.lastname, this.isActive, this.latLng);
}

class AutoLoggedInState extends LoggedInState {
  AutoLoggedInState(String uid, String firstname, String lastname,bool isActive,LatLng latLng)
      : super(uid, firstname, lastname, isActive,latLng);
}

class StateErrorSignUp extends AuthState {
  final String message;

  StateErrorSignUp(this.message);
}

class CodeSendState extends AuthState {
  final String verificationId;
  final int? token;

  CodeSendState(this.verificationId, this.token);
}
