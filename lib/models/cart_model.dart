import 'package:flutter/cupertino.dart';

class CartModel with ChangeNotifier {
  final String id, productId,details,productCategoryName;
  final double totalPrice;
  final int quantity;
  final String extra1,extra3,extra2,extra4,extra5,extra6,extra7,extra8,extra9,extra10;
  final String drink1,drink3,drink4,drink2,drink6,drink5,drink7,drink8,drink9,drink10;

  CartModel({
    required this.extra1,required this.extra2,required this.extra3,required this.extra4,required this.extra5,required this.extra6,required this.extra7,required this.extra8,required this.extra9,required this.extra10,
    required this.drink1,required this.drink2,required this.drink3,required this.drink4,required this.drink5,required this.drink6,required this.drink7,required this.drink8,required this.drink9,required this.drink10,
    required this .details,
    required this .totalPrice,
    required this .productCategoryName,
    required this.id,
    required this.productId,
    required this.quantity,
  });
}
