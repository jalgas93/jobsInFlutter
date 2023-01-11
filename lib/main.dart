import 'package:flutter/material.dart';
import 'package:flutter_jobs/screens/auth/auth_page.dart';

import 'package:flutter_jobs/screens/auth/auth_bloc/auth_bloc.dart';
import 'package:flutter_jobs/screens/auth/auth_bloc/auth_event.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_jobs/screens/home/home_page.dart';
import 'package:flutter_jobs/screens/geolocator/geolocator.dart';
import 'package:flutter_jobs/screens/map/open_street_example.dart';
import 'package:flutter_jobs/screens/openstreet/example.dart';
import 'package:flutter_jobs/screens/openstreet/open_street_map.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    bloc = AuthBloc();
    bloc.add(LoginCurrentUserEvent());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => bloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Nukus",
        home: OpenStreetMapExample(
            //center: LatLong(42.4572731, 59.60738849620722),
            buttonColor: Colors.blueAccent),
      ),
    );
  }
}
