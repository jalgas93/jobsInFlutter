import 'package:flutter/material.dart';
import 'package:flutter_jobs/widgets/phone_textfield.dart';

class PhonePage extends StatelessWidget {
  const PhonePage({Key? key, required TextEditingController numberController})
      : _numberController = numberController,
        super(key: key);

  final TextEditingController _numberController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Image.asset(
              'assets/img1.png',
              width:230,
              height: 200,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Войдите по номеру телефона",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  PhoneTextField(numberController: _numberController,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
