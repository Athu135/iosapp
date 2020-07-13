import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/model/wallpapers_model.dart';
import 'package:flutter_app/widgit/widgit.dart';

import 'package:http/http.dart' as http;


class Categories extends StatefulWidget {
  final String categoriesName;
  Categories({this.categoriesName});

  @override
  _CategoriesState createState() => _CategoriesState();



}

class _CategoriesState extends State<Categories> {

  List<WallpaperModel> wallpaper = new List();
  getSearchWallpapers(String query) async{
    var response = await http.get("https://api.pexels.com/v1/search?query=$query&per_page=80&page=1",
        headers: {
          "Authorization" : apiKey});
    //print(response.body.toString());

    Map<String,dynamic> jsonData= jsonDecode(response.body);
    jsonData["photos"].forEach((element){
      //print(element);
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpaper.add(wallpaperModel);
    });

    setState(() {});

  }

  @override
  void initState() {
    getSearchWallpapers(widget.categoriesName);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xff15191c),
      appBar: AppBar(
        title: Applogo(),
        centerTitle: true,
        elevation: 0.0,
      ),
      body:SingleChildScrollView(
        child: Container (
          child: Column(
            children: <Widget>[
              SizedBox(height: 16),
              wallpaperView(wallpaper: wallpaper , context: context)
            ],),),
      ),
    );
  }
}
