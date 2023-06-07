import 'package:flutter/cupertino.dart';

class ProductModel with ChangeNotifier{
  final String id, title, imageUrl, productCategoryName,detiles;
  final double price, salePrice;
  final bool isOnSale, isPiece;
final String extra1,extra2,extra3,extra4,extra5,extra6,
  extra7,extra8,extra9,extra10,price1,price2,price3,price4,
    price5,price6,price7,price8,price9,price10
  ;

  ProductModel(  
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.productCategoryName,
      required this.price,
      required this.detiles,
      required this.salePrice,
      required this.isOnSale,
      required this.isPiece,
      required this.extra1,
        required this.extra2,
        required this.extra3,
        required this.extra4,
        required this.extra5,
        required this.extra6,
        required this.extra7,
        required this.extra8,
        required this.extra9,
        required this.extra10,
        required this.price1,
        required this.price2,
        required this.price3,
        required this.price4,
        required this.price5,
        required this.price6,
        required this.price7,
        required this.price8,
        required this.price9,
        required this.price10,
      });
}
