class WallpaperModel {
  String photographer;
  String photographer_url;
  int photographer_id;
  srcModel src;

  WallpaperModel({this.src,this.photographer_id,this.photographer_url,this.photographer});

  factory WallpaperModel.fromMap(Map<String,dynamic> jsonData){
    return WallpaperModel(
      src: srcModel.fromMap(jsonData["src"]),
      photographer_url: jsonData["photographer_url"],
      photographer_id: jsonData["photographer_id"],
      photographer: jsonData["photographer"]
    );
  }
}


class srcModel{
  String original;
  String small;
  String portrait;

  srcModel({this.portrait,this.small,this.original});

  factory srcModel.fromMap(Map<String,dynamic> jsonData){
    return srcModel(
      portrait: jsonData["portrait"],
      small: jsonData["small"],
      original: jsonData["original"]
    );
  }
}