import 'package:flutter/material.dart';

class UserModel{
  String? name;
  String? image;
  String? geoAddress;


  UserModel({this.name,this.image, this.geoAddress});

  UserModel.fromJson(Map<String,dynamic> json){
    name = json['name'];
    image = json['image'];
    geoAddress = json['geoAddress'];

  }
}