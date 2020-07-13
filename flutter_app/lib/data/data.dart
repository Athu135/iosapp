
import 'package:flutter_app/model/categories_model.dart';

String apiKey="563492ad6f917000010000011b8b21c490074199a2d5e2d3517c477e";

List<CatergoriesModel> getCategories(){

  List<CatergoriesModel> categories = new List();
  CatergoriesModel catergoriesModel = new CatergoriesModel();


  //
  catergoriesModel.imgUrl =
  "https://images.pexels.com/photos/545008/pexels-photo-545008.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  catergoriesModel.categoriesName = "Street Art";
  categories.add(catergoriesModel);
  catergoriesModel = new CatergoriesModel();

  //
  catergoriesModel.imgUrl =
  "https://images.pexels.com/photos/704320/pexels-photo-704320.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  catergoriesModel.categoriesName = "Wild Life";
  categories.add(catergoriesModel);
  catergoriesModel = new CatergoriesModel();

  //
  catergoriesModel.imgUrl =
  "https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  catergoriesModel.categoriesName = "Nature";
  categories.add(catergoriesModel);
  catergoriesModel = new CatergoriesModel();

  //
  catergoriesModel.imgUrl =
  "https://images.pexels.com/photos/466685/pexels-photo-466685.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  catergoriesModel.categoriesName = "City";
  categories.add(catergoriesModel);
  catergoriesModel = new CatergoriesModel();

  //
  catergoriesModel.imgUrl =
  "https://images.pexels.com/photos/1434819/pexels-photo-1434819.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260";
  catergoriesModel.categoriesName = "Motivation";

  categories.add(catergoriesModel);
  catergoriesModel = new CatergoriesModel();

  //
  catergoriesModel.imgUrl =
  "https://images.pexels.com/photos/2116475/pexels-photo-2116475.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  catergoriesModel.categoriesName = "Bikes";
  categories.add(catergoriesModel);
  catergoriesModel = new CatergoriesModel();

  //
  catergoriesModel.imgUrl =
  "https://images.pexels.com/photos/1149137/pexels-photo-1149137.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  catergoriesModel.categoriesName = "Cars";
  categories.add(catergoriesModel);
  catergoriesModel = new CatergoriesModel();

  return categories;

}