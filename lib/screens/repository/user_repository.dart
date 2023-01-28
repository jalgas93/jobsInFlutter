import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlng/latlng.dart';

import '../models/user.dart';

class UserRepository {
  UserRepository._();

  static UserRepository? _instance;

  static UserRepository? get instance {
    if (_instance == null) {
      _instance = UserRepository._();
    }

    return _instance;
  }

  ValueNotifier<User?> userNotifier = ValueNotifier<User?>(null);

  User? get currentUser {
    return userNotifier.value;
  }

  Future<User?> setUpAccount(String? uid, String firstname, String lastname,
      bool? isActive, LatLng? latlng) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'firstname': firstname,
      'lastname': lastname,
      'isVerified': true,
      'isActive': isActive,
      'latlng': {'lat': latlng?.latitude, 'lng': latlng?.longitude}
    });
    userNotifier.value = await UserRepository.instance!.getUser(uid);
    return userNotifier.value;
  }

  Future<User?> setUpdateTabbarSend(
      String? uid, String firstname, String address, String phone) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('userinfo')
        .add({'firstname': firstname, 'address': address, 'phone': phone});
    userNotifier.value = await UserRepository.instance!.getUser(uid);
    return userNotifier.value;
  }

  Future<User?> setUpdateTabbarAssept(
    String? uid,
    String firstname,
    String address,
    String carName,
    String carColor,
    String carNumber,
    String phone,
    int km,
    int summa,
  ) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('userinfo')
        .add({
      'firstname': firstname,
      'address': address,
      'carName': carName,
      'carColor': carColor,
      'carNumber': carNumber,
      'phone': phone,
      'km': km,
      'summa': summa,
    });
    userNotifier.value = await UserRepository.instance!.getUser(uid);
    return userNotifier.value;
  }

  Future<User?> getUser(String? uid) async {
    userNotifier.value = null;
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (!userSnapshot.exists) {
      return null;
    } else {
      Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;

      print(data['uid']);
      print(data['firstname']);
      print(data['lastname']);
      //print(data['image']);
      print(data['isVerified']);
      print(data['address']);
      print(data['phone']);
      print(data['km']);
      print(data['summa']);
      print(data['carName']);
      print(data['carColor']);
      print(data['carNumber']);
      print(data['isActive']);

      userNotifier.value = User.fromjson(uid, data);
    }
    return userNotifier.value;
  }

  Future<void> signInCurrentUser() async {
    if (UserRepository.instance!.currentUser == null) {
      auth.User? authUser = auth.FirebaseAuth.instance.currentUser;
      if (authUser == null) {
        print('no current user');
        try {
          authUser = await auth.FirebaseAuth.instance.authStateChanges().first;
        } catch (_) {}
      }
      if (authUser == null) {
        print('no state change user');
      } else {
        await UserRepository.instance!.getUser(authUser.uid);
      }
    }
  }

  Future<User?> updateDriverLocation(String? uid, LatLng position) async {
    if (uid != null) {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'latlng': {
          'lat': position.latitude,
          'lng': position.longitude,
        },
      });

      return userNotifier.value;
    }
  }

  Future<User?> updateOnlinePresense(String? uid, bool isActive) async {
    if (uid != null) {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({'is_active': isActive});
      return userNotifier.value;
    }
  }
}
