import 'package:flutter/cupertino.dart';

class ProductModel with ChangeNotifier{
  final String id, title, imageUrl, productCategoryName,detiles;
  final double price, salePrice;
  final bool isOnSale, isPiece;
final String extra1,extra2,extra3,extra4,extra5,extra6,
  extra7,extra8,extra9,extra10
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
      });
}
