import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageView extends StatefulWidget {
  final String imgUrl;
  ImageView({ @required this.imgUrl});

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {

  var filePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
            tag: widget.imgUrl,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.network(widget.imgUrl, fit: BoxFit.cover,),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    _save();
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xffECECEB).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        width: MediaQuery.of(context).size.width/2,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width/2,
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                                colors: [
                                  Color(0x36FFFFFF),
                                  Color(0x0FFFFFFF)
                                ]
                            )
                        ),
                        child: Column(children: <Widget>[
                          Text ("Set Wallpaper", style: TextStyle(fontSize: 16,color: Color(0xff07617D)),),
                          Text ("Image will be saved to gallery",style: TextStyle(fontSize: 12,color: Color(0xff07617D)),)
                        ],),
                      ),
                    ],
                  ),
                ),
                SizedBox (height: 16,),
              GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Text ("Cancel" , style: TextStyle(color: Color(0xff07617D)),)),
                SizedBox (height: 50,)
            ],),
          )

        ],
      ),
    );
  }
  _save() async {
    if(Platform.isAndroid){
      PermissionStatus permissionStorage =
      await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
      if (permissionStorage != PermissionStatus.granted) {
        Map<PermissionGroup, PermissionStatus> permissionStatus =
        await PermissionHandler().requestPermissions([PermissionGroup.storage]);
        permissionStorage = permissionStatus[PermissionGroup.storage] ?? PermissionStatus.unknown;

        if (permissionStorage != PermissionStatus.granted) {
          print("❌----------has no Permission");
          return;
        }
      }
    }

    var response = await Dio().get(
        widget.imgUrl,
        options: Options(responseType: ResponseType.bytes));
    print(widget.imgUrl);
    //print();
    final result =
    await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(response.data);
    print(result);
    Navigator.pop(context);
  }

  _askPermission() async {
    if (Platform.isIOS) {
      Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler()
          .requestPermissions([PermissionGroup.photos]);
    } else {
       PermissionStatus permission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
    }
  }
}

