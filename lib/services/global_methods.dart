import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:uuid/uuid.dart';

import '../consts/firebase_consts.dart';
import '../widgets/text_widget.dart';

class GlobalMethods {
  static navigateTo({required BuildContext ctx, required String routeName}) {
    Navigator.pushNamed(ctx, routeName);
  }


  static Future<void> warningDialog({
    required String title,
    required String subtitle,
    required Function fct,
    required BuildContext context, 
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(children: [
              Image.asset(
                'assets/images/warning-sign.png',
                height: 20,
                width: 20,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(title),
            ]),
            content: Text(subtitle),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: TextWidget(
                  color: Colors.cyan,
                  text: 'Cancel',
                  textSize: 18,
                ),
              ),
              TextButton(
                onPressed: () {
                  fct();
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: TextWidget(
                  color: Colors.red,
                  text: 'OK',
                  textSize: 18,
                ),
              ),
            ],
          );
        });
  }
  
  static Future<void> DeliveryOrBackup({
    required String title,
    required String subtitle,
    required Function fct,
    required Function fct2,
    required BuildContext context,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: 
            
               Text(title),
            // ]),
            content: Text(subtitle),
            actions: [
              TextButton(
                onPressed: () {
                  fct2();
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: TextWidget(
                  color: Colors.cyan,
                  text: 'Delivry',
                  textSize: 18,
                ),
              ),
              TextButton(
                onPressed: () {
                  fct();
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: TextWidget(
                  color: Colors.red,
                  text: 'backup',
                  textSize: 18,
                ),
              ),
            ],
          );
        });
  }

  static Future<void> errorDialog({
    required String subtitle,
    required BuildContext context,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(children: [
              Image.asset(
                'assets/images/warning-sign.png',
                height: 20,
                width: 20,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text('An Error occured'),
            ]),
            content: Text(subtitle),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: TextWidget(
                  color: Colors.cyan,
                  text: 'Ok',
                  textSize: 18,
                ),
              ),
            ],
          );
        });
  }

  static Future<void> addToCart(
      {required String productId,
      required int quantity,
      required String details,

        required double totalPrice,
         String? extra1,extra2,extra3,extra4,extra5,extra6,extra8,extra7,extra9,extra10,
        drink1,drink3,drink2,drink5,drink4,drink6,drink7,drink8,drink9,drink10,
        required String productCategoryName,
      required BuildContext context, }) async {
    final User? user = authInstance.currentUser;
    final _uid = user!.uid;
    // final String typeRes = nameRes;
    // if(nameRes==typeRes);
    final cartId = const Uuid().v4();
    try {
      FirebaseFirestore.instance.collection('users').doc(_uid).update({
        'userCart': FieldValue.arrayUnion([
          {
            'productCategoryName':productCategoryName,
            'totalPrice':totalPrice,
            'cartId': cartId,
            'productId': productId,
            'quantity': quantity,
            'details':details,
            'extra1':extra1,
            'extra2':extra2,
            'extra3':extra3,
            'extra4':extra4,
            'extra5':extra5,
            'extra6':extra6,
            'extra7':extra7,
            'extra8':extra8,
            'extra9':extra9,
            'extra10':extra10,
            'drink1':drink1,
            'drink2':drink2,
            'drink3':drink3,
            'drink4':drink4,
            'drink5':drink5,
            'drink6':drink6,
            'drink7':drink7,
            'drink8':drink8,
            'drink9':drink9,
            'drink10':drink10,

          }
        ])
      });
      await Fluttertoast.showToast(
        //Item has been added to your cart
        msg: "Varan har lagts till i din kundvagn",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } catch (error) {
      errorDialog(subtitle: error.toString(), context: context);
    }
  }

  static Future<void> addToWishlist(
      {required String productId, required BuildContext context}) async {
    final User? user = authInstance.currentUser;
    final _uid = user!.uid;
    final wishlistId = const Uuid().v4();
    try {
      FirebaseFirestore.instance.collection('users').doc(_uid).update({
        'userWish': FieldValue.arrayUnion([
          {
            'wishlistId': wishlistId,
            'productId': productId,
          }
        ])
      });
      await Fluttertoast.showToast(
        //Item has been added to your wishlist
        msg: "Objektet har lagts till på din önskelista",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } catch (error) {
      errorDialog(subtitle: error.toString(), context: context);
    }
  }

}
