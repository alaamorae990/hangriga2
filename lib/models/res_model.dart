
import 'package:flutter/cupertino.dart';


class ResModel with ChangeNotifier{
  final String  title, imageUrl,delievryCost,rankStar,hourTime;
final bool isOnSale;
 

  ResModel(
      {
      required this.title,
      required this.isOnSale,
      required this.imageUrl,
        required this.delievryCost,
        required this.rankStar,
        required this.hourTime,
      });
}
