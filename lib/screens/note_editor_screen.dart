import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_jobs/style/app_style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({Key? key}) : super(key: key);

  @override
  _NoteEditorScreenState createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  int color_id = Random().nextInt(AppStyle.cardsColor.length);
  String date = DateTime.now().toString();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Note title'),
              style: AppStyle.mainTitle,
            ),
            Text(
              date,
              style: AppStyle.dateTitle,
            ),
            SizedBox(
              height: 28,
            ),
            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Note content'),
              style: AppStyle.mainContent,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: () async {
          // FirebaseFirestore.instance.collection("clientIswrite").doc('5').set({
          //   'uid':'5',
          //   "note_title": _titleController.text,
          //   "creation_data": date,
          //   "note_content": _mainController.text,
          //   "color_id": color_id,
          // });

          final usersCollectionRef = FirebaseFirestore.instance.collection("users");
          final alovelaceDocumentRef = FirebaseFirestore.instance.collection("clientIswrite").doc("jalgas");
          final alovelaceDocumentRef2 = FirebaseFirestore.instance.doc("clientIswrite/jalgas");
          final messageRef = FirebaseFirestore.instance
              .collection("clientIswrite")
              .doc("VIDY1jmz1COOj9PF7spN")
              .collection("jalgas");
          print('jalgas ref : ${usersCollectionRef}');
          print('jalgas2 ref : ${alovelaceDocumentRef}');
          print('jalgas3 ref : ${alovelaceDocumentRef}');
          print('jalgas4 ref : ${messageRef}');

          FirebaseFirestore.instance.collection("clientIswrite").doc('VIDY1jmz1COOj9PF7spN').collection('jalgas').add({

            "note_title": _titleController.text,
            "creation_data": date,
            "note_content": _mainController.text,
            "color_id": color_id,
          }).then((value) {
            print(value.id);
            Navigator.pop(context);
          }).catchError(
                  (error) => print("Failed to add new Note due to $error"));

          FirebaseFirestore.instance.collection("clientIswrite").add({

            "note_title": _titleController.text,
            "creation_data": date,
            "note_content": _mainController.text,
            "color_id": color_id,
          }).then((value) {
            print(value.id);
            Navigator.pop(context);
          }).catchError(
              (error) => print("Failed to add new Note due to $error"));
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
