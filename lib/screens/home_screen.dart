import 'package:flutter/material.dart';
import 'package:flutter_jobs/screens/note_editor_screen.dart';
import 'package:flutter_jobs/screens/note_reader.dart';
import 'package:flutter_jobs/style/app_style.dart';
import 'package:flutter_jobs/widgets/note_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        elevation: 1.0,
        title: Text(
          'jalgas',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppStyle.mainColor,
      ),
      drawer: Drawer(
          child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 28,
              backgroundColor: Colors.blueGrey,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/joker.jpg'),
              ),
            ),
            title: Text(
              'Joaquin Phoenix',
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
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.
                collection("clientIswrite").doc('VIDY1jmz1COOj9PF7spN').collection('jalgas')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    return GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      children: snapshot.data!.docs
                          .map((note) => noteCard(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          NoteReaderScreen(note),
                                    ));
                              }, note))
                          .toList(),
                    );
                  }
                  return Text(
                    "There is no Notes",
                    style: GoogleFonts.nunito(color: Colors.white),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
            Navigator.push(context,
           MaterialPageRoute(builder: (context) => NoteEditorScreen()));
        },
        label: Text("Add note"),
        icon: Icon(Icons.add),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     _key.currentState!.openDrawer();
      //   },
      //   child: Icon(Icons.menu,color: Colors.black,),
      // ),
    );
  }
}
//import 'package:firebase_auth/firebase_auth.dart';
// sign out.  await FirebaseAuth.instance.signOut();
