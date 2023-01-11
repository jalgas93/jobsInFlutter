import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jobs/widgets/theme.dart';
import 'package:latlng/latlng.dart';

import 'city_textfield.dart';

class SetUpAccount extends StatelessWidget {
  const SetUpAccount({
    Key? key,
    this.firstnameController,
    this.lastnameController,

    // this.phoneController
  }) : super(key: key);

  final TextEditingController? firstnameController;
  final TextEditingController? lastnameController;



  //final TextEditingController? phoneController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Добро пожаловать в Нукус такси !",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Давайте знакомиться",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 50,
                    ),

                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: TextField(
                            controller: firstnameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Имя",
                            ),
                          ))
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: TextField(
                            controller: lastnameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Фамилия",
                            ),
                          ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: CityTextField(
                    //         label: 'First Name',
                    //         controller: firstnameController,
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: CityTheme.elementSpacing,
                    //     ),
                    //     Expanded(
                    //       child: CityTextField(
                    //         label: 'Last Name',
                    //         controller: lastnameController,
                    //       ),
                    //     )
                    //   ],
                    // )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
