import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_jobs/screens/auth/auth_bloc/auth_bloc.dart';
import 'package:flutter_jobs/screens/auth/auth_bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_jobs/widgets/theme.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:provider/provider.dart';
import 'package:pinput/pinput.dart';

import '../screens/auth/auth_bloc/auth_bloc.dart';
class OtpPage extends StatefulWidget {
  const OtpPage(
      {Key? key,
      required TextEditingController otpController,
      required this.bloc,
      required this.phoneNumber})
      : _otpController = otpController,
        super(key: key);
  final TextEditingController _otpController;
  final AuthBloc bloc;
  final String phoneNumber;

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  int count = 15;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  void _startCountDown() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick > 15) {
        timer.cancel();
      } else {
        setState(() {
          --count;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //final state = Provider.of<AuthState>(context);
    var code = "";
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (_, state) {
        if (state is CodeSendState) {
          _startCountDown();
        }
      },
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                Image.asset(
                  'assets/img1.png',
                  width: 230,
                  height: 200,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Мы отправили вам код в sms ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "+998${widget.phoneNumber}",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ).paddingBottom(CityTheme.elementSpacing),
                Pinput(
                  controller: widget._otpController ,
                  length: 6,
                  showCursor: true,
                  onChanged: (value) {
                    code = value;
                  },
                  onCompleted: (pin) => print(pin),
                ),

                SizedBox(
                  height: 10,
                ),
                // PinFieldAutoFill(
                //   controller: widget._otpController,
                //   decoration: BoxLooseDecoration(
                //     textStyle: TextStyle(fontSize: 20, color: Colors.black),
                //     strokeColorBuilder: FixedColorBuilder(Colors.grey),
                //   ),
                //   currentCode: '',
                //   onCodeSubmitted: (code) {},
                //   onCodeChanged: (code) {
                //     if (code!.length == 6) {
                //       FocusScope.of(context).requestFocus(FocusNode());
                //     }
                //   },
                // ),
               // Spacer(),
                state is LoadingAuthState
                    ? Text(
                        'Проверка...',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontWeight: FontWeight.w400),
                      ).paddingBottom(8)
                    : SizedBox.shrink(),
                state is CodeSendState
                    ? Row(children: [
                        Text(
                          'Попробывать еще раз через ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                        Text(
                          '${count} секунд',
                          //'30 секунд:''$count',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontWeight: FontWeight.w400),
                        )
                      ]).paddingBottom(8)
                    : SizedBox.shrink(),
              ],
            ),
          ),
        );
      },
    );
  }
}
