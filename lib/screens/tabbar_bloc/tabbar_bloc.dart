import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';
import '../repository/user_repository.dart';
import 'tabbar-state.dart';
import 'tabbar_event.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TabbarBloc extends Bloc<TabbarEvent, TabbarState> {
  TabbarBloc() :super(LoadingState());

  @override
  Stream<TabbarState> mapEventToState(TabbarEvent event) async* {
    if (event is LoadingEvent) {
      yield LoadingState();
    } else if (event is SendEvent) {
     // yield LoadingState();
    yield* _SendEventToState(event);
    } else if (event is ErrorEvent) {
      yield ErrorState(event.error);
    }  else if (event is AsseptEvent) {
     // yield LoadingState();
      yield* _AsseptEventToState(event);
    }
  }


  Stream<TabbarState> _SendEventToState(SendEvent event) async* {
   // yield LoadingState();
    final user = await UserRepository.instance!.setUpdateTabbarSend(
        event.uid, event.firstname, event.address, event.phone);
    yield SendState( user?.uid,user?.firstname, user?.address,user?.phone);
  }

  Stream<TabbarState> _AsseptEventToState(AsseptEvent event) async* {
   // yield LoadingState();
    final user = await UserRepository.instance!.setUpdateTabbarAssept(
        event.uid,
        event.firstname,
        event.address,
        event.carName,
        event.carColor,
        event.carNumber,
        event.phone,
        event.km,
        event.summa);
    yield AcceptState(
      user?.uid,
      user?.firstname,
      user?.address,
      user?.phone,
      user?.carName,
      user?.carColor,
      user?.carNumber,
      user?.km,
      user?.summa,
    );
  }


}
