import 'package:flutter/material.dart';
import 'package:flutter_app/model/wallpapers_model.dart';
import 'package:flutter_app/views/imageview.dart';

Widget brandName(){
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      children: <TextSpan>[
        TextSpan(text: 'Wallpaper', style: TextStyle(color: Colors.amber)),
        TextSpan(text: 'Hub', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.amberAccent, fontSize: 30)),
     ],
    ),
  );
}

Widget Applogo(){
  return Image.asset(
    "images/photopexils2.png"
  );
}





Widget wallpaperView( {List<WallpaperModel> wallpaper, context}){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpaper.map((wallpaper){
        return GridTile(
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => ImageView(
                  imgUrl: wallpaper.src.portrait,
                )));
            },
            child: Hero(
              tag: wallpaper.src.portrait,
              child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(wallpaper.src.portrait, fit: BoxFit.cover,)),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}
