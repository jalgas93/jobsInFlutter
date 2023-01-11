import 'package:flutter/material.dart';
import 'package:flutter_jobs/style/app_style.dart';

class PhoneTextField extends StatefulWidget {
  const PhoneTextField(
      {Key? key, TextEditingController? numberController})
      : _numberController = numberController,
        super(key: key);

  final TextEditingController? _numberController;

  @override
  _PhoneTextFieldState createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  bool isFocus = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (v) {
        setState(() {
          isFocus = v;
        });
      },
      child: TextField(
        controller: widget._numberController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            enabledBorder: OutlineInputBorder(),
            hintText: 'Ваш номер телефона',
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppStyle.mainColor),
            ),
            border: OutlineInputBorder(),
            disabledBorder: OutlineInputBorder(),
            prefix: isFocus
                ? Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Text('+998'),
                  )
                : SizedBox.shrink(),
            prefixIcon: isFocus ? null : Icon(Icons.phone)),
      ),
    );
  }
}
