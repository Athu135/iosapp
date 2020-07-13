import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/model/wallpapers_model.dart';
import 'package:flutter_app/widgit/widgit.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  final String searchQuery;
  Search({this.searchQuery});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<WallpaperModel> wallpaper = new List();

  TextEditingController searchController = new TextEditingController();


  getSearchWallpapers(String query) async{
    var response = await http.get("https://api.pexels.com/v1/search?query=$query&per_page=80&page=1",
        headers: {
          "Authorization" : apiKey});
    //print(response.body.toString());

    Map<String,dynamic> jsonData= jsonDecode(response.body);
    wallpaper = new List();
    jsonData["photos"].forEach((element){

      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpaper.add(wallpaperModel);
      //print(wallpaperModel.toString()+ "  "+ wallpaperModel.src.portrait);
    });

    setState(() {});

  }


  @override
  void initState() {
    getSearchWallpapers(widget.searchQuery);
    super.initState();
    searchController.text = widget.searchQuery;
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
              Container(
                decoration: BoxDecoration(
                    color: Color(0xffF9A828),
                    borderRadius: BorderRadius.circular(30)
                ),
                padding: EdgeInsets.symmetric(horizontal: 24),
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            hintText: "search wallpaper",
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: (){
                          getSearchWallpapers(searchController.text);
                          },
                        child: Icon(Icons.search)),
                  ],),
              ),
              SizedBox(height: 16,),
              wallpaperView(wallpaper: wallpaper , context: context)
            ],),),
      ),
    );
  }
}
