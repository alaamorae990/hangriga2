
import 'package:flutter/cupertino.dart';


class ResModel with ChangeNotifier{
  final String  title, imageUrl,delievryCost,rankStar,hourTime,startTime,endTime,
  drink1,drink2,drink3,drink4,drink5,drink6,drink7,drink8,drink9,drink10,
  price1,price2,price3,price4,price5,price6,price7,price8,price9,price10,
      imagedrink2, imagedrink1,imagedrink3,imagedrink4,imagedrink5,imagedrink6,imagedrink7,imagedrink8,imagedrink9,imagedrink10
  ;
final bool isOnSale;

 

  ResModel(
      {
        required this.startTime,
        required this.endTime,
      required this.title,
      required this.isOnSale,
      required this.imageUrl,
        required this.delievryCost,
        required this.rankStar,
        required this.hourTime,
      required this.drink1,required this.drink4,required this.drink5,required this.drink8,required this.drink9,
        required this.drink2,required this.drink3,required this.drink6,required this.drink7,required this.drink10,
        required this.price1,required this.price4,required this.price5,required this.price7,required this.price9,
        required this.price2,required this.price3,required this.price6,required this.price8,required this.price10,
        required this.imagedrink1,required this.imagedrink4,required this.imagedrink5,required this.imagedrink8,required this.imagedrink9,
        required this.imagedrink3,required this.imagedrink2,required this.imagedrink6,required this.imagedrink7,required this.imagedrink10,
      });
}
