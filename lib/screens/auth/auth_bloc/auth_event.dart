import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:latlng/latlng.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SignUpEvent extends AuthEvent {
  final String? uid;
  final String firstname;
  final String lastname;
  final bool? isActive;
  final LatLng? latLng;



  const SignUpEvent( this.firstname, this.lastname,this.uid, this.isActive, this.latLng,);
}

class PhoneNumberVerificationEvent extends AuthEvent {
  final String phone;
  PhoneNumberVerificationEvent(this.phone);
}

class PhoneAuthCodeVerificationEvent extends AuthEvent {
  final String phone;
  final String smsCode;
  final String verificationId;

  PhoneAuthCodeVerificationEvent( this.smsCode, this.verificationId,this.phone,);
}



class CompletedAuthEvent extends AuthEvent{
  final AuthCredential credential;

  CompletedAuthEvent(this.credential);

}

class ErrorOccuredEvent extends AuthEvent{
  final String error;

  ErrorOccuredEvent(this.error);

}

class CodeSendEvent extends AuthEvent{
  final int? token;
  final String verificationId;

  CodeSendEvent( this.verificationId,this.token);

}
class LoginCurrentUserEvent extends AuthEvent {}

