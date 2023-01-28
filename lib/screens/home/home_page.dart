import 'package:flutter/material.dart';
import 'package:flutter_jobs/screens/home/user_page.dart';
import '../auth/auth_page.dart';
import '../models/user.dart';
import '../repository/user_repository.dart';

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
                    page: 3,
                    uid: value.uid,
                  );
                } else {
                  return UserPage(
                    page: 0,
                    uid: value.uid,
                    latit: value.latlng!.latitude,
                    long: value.latlng!.longitude,
                    firstname: value.firstname!,
                    phone: value.phone!,
                  );
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
