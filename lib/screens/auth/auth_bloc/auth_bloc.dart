import 'package:flutter/material.dart';
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_jobs/screens/auth/auth_service.dart';
import '../../repository/user_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bloc/bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is PhoneNumberVerificationEvent) {
      yield* _phoneAuthVerificationToState(event);
    } else if (event is PhoneAuthCodeVerificationEvent) {
      final uid = await AuthService.instance
          .verifyAndLogin(event.verificationId, event.smsCode, event.phone);
      final user = await UserRepository.instance!.getUser(uid);
      yield LoggedInState(user?.uid, user?.firstname, user?.lastname,user?.isActive,user?.latlng);
    } else if (event is CodeSendEvent) {
      yield CodeSendState(event.verificationId, event.token);
    } else if (event is SignUpEvent) {
      yield* _setUpAccount(event);
    } else if (event is LoginCurrentUserEvent) {
      await UserRepository.instance!.signInCurrentUser();
    }
  }

  Stream<AuthState> _phoneAuthVerificationToState(
      PhoneNumberVerificationEvent event) async* {
    //yield LoadingAuthState();
    await AuthService.instance.verifyPhoneSendOtp(event.phone, completed: (credential) {
      print('Completed');
      add(CompletedAuthEvent(credential));
    }, failed: (error) {
      print('error');
      add(ErrorOccuredEvent(error.toString()));
    }, codeSent: (String id, int? token) {
      print('print code send $id');
      add(CodeSendEvent(id, token!));
    }, codeAutoRetrievalTimeout: (id) {
      print('timeOut $id');
      add(CodeSendEvent(id,0));
    });
  }

  Stream<AuthState> _setUpAccount(SignUpEvent event) async* {
    //yield LoadingAuthState();
    final user = await UserRepository.instance!
        .setUpAccount(event.uid, event.firstname, event.lastname,event.isActive,event.latLng);
    yield LoggedInState(user?.uid, user?.firstname, user?.lastname,user?.isActive,user?.latlng);
  }
}
