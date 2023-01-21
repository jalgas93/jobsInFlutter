import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_jobs/screens/auth/auth_bloc/auth_bloc.dart';
import 'package:flutter_jobs/screens/auth/auth_bloc/auth_event.dart';
import 'package:flutter_jobs/screens/auth/auth_bloc/auth_state.dart';
import 'package:flutter_jobs/screens/geolocator/geolocator.dart';
import 'package:flutter_jobs/style/app_style.dart';
import 'package:flutter_jobs/widgets/set_up_account.dart';
import 'package:flutter_jobs/widgets/theme.dart';
import 'package:latlng/latlng.dart';
import 'package:geolocator/geolocator.dart';
import '../../widgets/otp_page.dart';
import '../../widgets/phone_page.dart';
import '../serviceCard/service_card.dart';
import 'auth_bloc/auth_bloc.dart';

class AuthPage extends StatefulWidget {
  final int page;
  final String? uid;

  const AuthPage({Key? key, this.page = 0, this.uid}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  PageController? _controller = PageController();
  int _pageIndex = 0;
  String locationMessage = "Для работы приложения ${'\n'} "
      "разрешите доступ к ${'\n'}геолокации в настройках ${'\n'} "
      "телефона ";
  late double lang;
  late double latit;

  @override
  void initState() {
    // TODO: implement initState
    _controller = PageController(initialPage: widget.page);
    _pageIndex = widget.page;
    super.initState();
  }

  TextEditingController _phoneController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: context.watch<AuthBloc>(),
      listener: (_, state) {
        if (state is LoggedInState) {
          _controller!.animateToPage(3,
              duration: Duration(milliseconds: 200), curve: Curves.ease);
          setState(() {
            _pageIndex = 3;
          });
        }
      },
      builder: (context, state) {
        print('build $state');
        return Stack(
          children: [
            Container(
              height: screenSize.height,
              width: screenSize.width,
              color: Colors.white,
              child: PageView(
                controller: _controller,
                onPageChanged: onPageChanged,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  PhonePage(numberController: _phoneController),
                  OtpPage(
                      otpController: _otpController,
                      bloc: context.watch<AuthBloc>(),
                      phoneNumber: _phoneController.text),
                  GeolocatorWidget(
                    locationMessage: locationMessage,
                  ),
                  SetUpAccount(
                    firstnameController: _firstnameController,
                    lastnameController: _lastnameController,
                  ),
                ],
              ),
            ),
            _buildFloatActionButton(state, context),
          ],
        );
      },
    );
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      return Future.error('Location service is disabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Location permissons are  permanentl danied, we cannot request permission");
    }
    return await Geolocator.getCurrentPosition();
  }

  Positioned _buildFloatActionButton(AuthState state, BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: FloatingActionButton(
          backgroundColor:
              state is LoadingAuthState ? Colors.grey[300] : CityTheme.cityblue,
          child: Icon(
              _pageIndex == 2 ? Icons.check_rounded : Icons.arrow_forward_ios),
          onPressed: state is LoadingAuthState ? null
              : () {
                  if (_phoneController.text.isNotEmpty &&
                      state is AuthInitialState &&
                      _pageIndex == 0) {
                    BlocProvider.of<AuthBloc>(context).add(
                        PhoneNumberVerificationEvent(
                            '+998${_phoneController.text}'));
                    _controller?.animateToPage(1,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.ease);
                    setState(() {
                      _pageIndex = 1;
                    });
                  } else if (state is CodeSendState && _pageIndex == 1) {
                    BlocProvider.of<AuthBloc>(context).add(
                        PhoneAuthCodeVerificationEvent(
                            _otpController.text,
                            state.verificationId,
                            '+998${_phoneController.text}'));
                    setState(() {
                      _pageIndex = 3;
                    });
                  } else if (_pageIndex == 3) {
                    getCurrentLocation().then((value) {
                      lang = double.parse('${value.longitude}');
                      latit = double.parse('${value.latitude}');
                      setState(() {
                        locationMessage = '${latit},${lang}';
                      });
                      print('jalgas' + locationMessage);
                    });
                    setState(() {
                      _pageIndex = 2;
                    });
                  } else if (_pageIndex == 2) {
                    BlocProvider.of<AuthBloc>(context).add(
                      SignUpEvent(
                        _firstnameController.text,
                        _lastnameController.text,
                        state is LoggedInState ? state.uid : widget.uid,
                        true,
                        LatLng(latit, lang),
                      ),
                    );
                  }
                },
        ),
      ),
    );
  }

  void onPageChanged(int value) {
    print('Me here');
    print(value);
    setState(() {
      _pageIndex = value;
    });
  }
}
//
// onPageChanged: (page) {
// if (page == _allPages.length &&
// (_controller.index + 1) < _controller.length) {
// _controller.animateTo(_controller.index + 1);
// }
// },
// itemCount: _allPages.length + 1,
