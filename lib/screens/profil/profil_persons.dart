
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonsProfil extends StatefulWidget {
  const PersonsProfil({Key? key}) : super(key: key);

  @override
  _PersonsProfilState createState() => _PersonsProfilState();
}

class _PersonsProfilState extends State<PersonsProfil> {

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.blue[50],
      ),
      child: Drawer(
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.blueGrey,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/jalgas.jpg'),
                  ),
                ),
                title: Text(
                  'Ungarbaev jalgas',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                subtitle: Text(
                  "You wouldn't get it",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 10.0),
                ),
              )
            ],
          )),
    );
  }
}
