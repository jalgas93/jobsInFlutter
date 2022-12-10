import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_jobs/style/app_style.dart';

Widget noteCard(Function()? onTab, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: onTab,
    child: Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppStyle.cardsColor[doc['color_id']],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doc["note_title"],
            style: AppStyle.mainTitle,
          ),
          SizedBox(height: 4.0),
          Text(
            doc["creation_data"],
            style: AppStyle.dateTitle,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.0,),
        ],
      ),
    ),
  );
}
