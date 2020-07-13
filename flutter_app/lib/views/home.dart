import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/model/categories_model.dart';
import 'package:flutter_app/model/wallpapers_model.dart';
import 'package:flutter_app/views/search.dart';
import 'package:flutter_app/widgit/widgit.dart';

import 'package:http/http.dart' as http;

import 'categorie.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  List<CatergoriesModel> categories = new List();
  List<WallpaperModel> wallpaper = new List();
  TextEditingController searchController = new TextEditingController();



  getTrendingWallpapers() async{
    var response = await http.get("https://api.pexels.com/v1/curated?per_page=80&page=1",
    headers: {
      "Authorization" : apiKey});
     //print(response.body.toString());

     Map<String,dynamic> jsonData= jsonDecode(response.body);
     jsonData["photos"].forEach((element){

       WallpaperModel wallpaperModel = new WallpaperModel();
       wallpaperModel = WallpaperModel.fromMap(element);
       wallpaper.add(wallpaperModel);
     });

     setState(() {});

  }

  @override
  void initState() {
    getTrendingWallpapers();
    categories= getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xff15191c),
      appBar: AppBar(
        title: Applogo() ,//brandName() ,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: <Widget>[
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
                          hintText: "search wallpaper", fillColor: Colors.black,
                          border: InputBorder.none
                        ),
                      ),
                    ),
                 GestureDetector(
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(
                         builder: (context) => Search(
                           searchQuery: searchController.text,
                         )
                       ));
                       },
                     child: Icon(Icons.search,color: Colors.black,)),
               ],),
           ),
            SizedBox(
              height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
               Text(
              "Made By Kstudios",
              style: TextStyle(
                  color: Color(0xffECECEB),
                  fontSize: 12,
                  fontFamily: 'Overpass'),
            )]),
           SizedBox(height: 16,),
           Container(
             height: 80,
             child: ListView.builder(
               padding: EdgeInsets.symmetric(horizontal: 24),
                itemCount: categories.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  return CategoriesTile(
                    title: categories[index].categoriesName,
                    imgUrl: categories[index].imgUrl,
                  );
                }),
           ),
            wallpaperView(wallpaper: wallpaper , context: context)
        ],),),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String imgUrl, title;
  CategoriesTile({@required this.imgUrl,@required this.title});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Categories(
            categoriesName: title.toLowerCase(),
          )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 6),
        child: Stack(children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
              child: Image.network(imgUrl, height: 50, width: 100 , fit: BoxFit.cover)),
          Container(
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(8),
            ),
            height: 50, width: 100,
            alignment: Alignment.center,
            child: Text(title, style: TextStyle (color:Colors.white, fontWeight: FontWeight.w500, fontSize: 15 ), ),),
        ],),
      ),
    );
  }
}
