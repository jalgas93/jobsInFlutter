import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_jobs/screens/openstreet/example.dart';
import 'package:flutter_jobs/screens/repository/user_repository.dart';

import '../auth/auth_page.dart';

import '../home_screen.dart';
import '../models/user.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

import '../note_reader.dart';
import '../openstreet/open_street_map.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ValueListenableBuilder<User?>(
        valueListenable: UserRepository.instance!.userNotifier,
        builder: (context, value, child) {
          if (value != null) {
            return Builder(
              builder: (context) {
                if (!value.isVerified!) {
                  return AuthPage(
                    page: 2,
                    uid: value.uid,
                  );
                }else {

                // } else if (value.'mina jerin birinshi baslaw kerek!!!!') {
                //   return OpenStreetMapExample();
                // } else {
                  return MyApp2();
                }
              },
            );
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}
// OpenStreetMapSearchAndPick(
// center: LatLong(42.457247, 59.607034),
// // buttonColor: Colors.blue,
//
// // buttonText: 'Set Current Location',
// onPicked: (pickedData) {
// // print(pickedData.latLong.latitude);
// // print(pickedData.latLong.longitude);
// // print(pickedData.address);
// // Navigator.push(
// //     context,
// //     MaterialPageRoute(
// //       builder: (context) =>
// //           HomeScreen( address: pickedData.address,geo: pickedData.latLong,),
// //     ));
// },
// );
