import 'package:flutter/material.dart';
import 'package:flutter_jobs/screens/auth/auth_page.dart';
import 'package:flutter_jobs/screens/auth/auth_bloc/auth_bloc.dart';
import 'package:flutter_jobs/screens/auth/auth_bloc/auth_event.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_jobs/screens/geolocator/geolocator.dart';
import 'package:flutter_jobs/screens/home/home_page.dart';
import 'package:flutter_jobs/screens/home_screen.dart';
import 'package:flutter_jobs/screens/openstreet/example.dart';
import 'package:flutter_jobs/screens/repository/user_repository.dart';
import 'package:flutter_jobs/screens/tabbar_bloc/tabbar_bloc.dart';
import 'package:latlong2/latlong.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => bloc,
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false, title: "Nukus", home: HomePage()),
    );
  }
}
//OpenStreetMapExample(
//           center: LatLng(42.448194,59.602081),
//         ),
