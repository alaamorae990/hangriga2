import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


import '../consts/firebase_consts.dart';
import '../models/cart_model.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> _cartItems = {};
  var firstItem="";
  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  // void addProductsToCart({
  //   required String productId,
  //   required int quantity,
  // }) {
  //   _cartItems.putIfAbsent(
  //     productId,
  //     () => CartModel(
  //       id: DateTime.now().toString(),
  //       productId: productId,
  //       quantity: quantity,
  //     ),
  //   );
  //   notifyListeners();
  // }

  final userCollection = FirebaseFirestore.instance.collection('users');
  Future<void> fetchCart() async {
    final User? user = authInstance.currentUser;
    final DocumentSnapshot userDoc = await userCollection.doc(user!.uid).get();
    if (userDoc == null ) {
      return;
    } else {
      final leng = userDoc
          .get('userCart')
          .length;
      // firstItem=userDoc.get('userCart')[0]['productCategoryName'];
      for (int i = 0; i < leng; i++) {
        _cartItems.putIfAbsent(
            userDoc.get('userCart')[i]['productId'],
                () =>
                CartModel(

                  extra1: userDoc.get('userCart')[i]['extra1'],
                  extra2: userDoc.get('userCart')[i]['extra2'],
                  extra3: userDoc.get('userCart')[i]['extra3'],
                  extra4: userDoc.get('userCart')[i]['extra4'],
                  extra5: userDoc.get('userCart')[i]['extra5'],
                  extra6: userDoc.get('userCart')[i]['extra6'],
                  extra7: userDoc.get('userCart')[i]['extra7'],
                  extra8: userDoc.get('userCart')[i]['extra8'],
                  extra9: userDoc.get('userCart')[i]['extra9'],
                  extra10: userDoc.get('userCart')[i]['extra10'],
                  drink1: userDoc.get('userCart')[i]['drink1'],
                  drink3: userDoc.get('userCart')[i]['drink3'],
                  drink2: userDoc.get('userCart')[i]['drink2'],
                  drink4: userDoc.get('userCart')[i]['drink4'],
                  drink5: userDoc.get('userCart')[i]['drink5'],
                  drink6: userDoc.get('userCart')[i]['drink6'],
                  drink7: userDoc.get('userCart')[i]['drink7'],
                  drink8: userDoc.get('userCart')[i]['drink8'],
                  drink9: userDoc.get('userCart')[i]['drink9'],
                  drink10: userDoc.get('userCart')[i]['drink10'],
                  totalPrice: userDoc.get('userCart')[i]['totalPrice'],
                  id: userDoc.get('userCart')[i]['cartId'],
                  productId: userDoc.get('userCart')[i]['productId'],
                  quantity: userDoc.get('userCart')[i]['quantity'],
                  details: userDoc.get('userCart')[i]['details'],
                  productCategoryName: userDoc.get(
                      'userCart')[i]['productCategoryName'],
                ));
      }
    }
    notifyListeners();
  }

  void reduceQuantityByOne(String productId) {
    _cartItems.update(
      productId,
      (value) => CartModel(
        totalPrice: value.totalPrice,
        productCategoryName: value.productCategoryName,
        extra1: value.extra1,
        extra2: value.extra1,
        extra3: value.extra1,
        extra4: value.extra1,
        extra5: value.extra1,
        extra6: value.extra1,
        extra7: value.extra1,
        extra8: value.extra1,extra9: value.extra1,
        extra10: value.extra10,
        drink1: value.drink1,drink3: value.drink3,drink6: value.drink6,drink7: value.drink7,drink9: value.drink9,
        drink2: value.drink2,drink4: value.drink4,drink5: value.drink5,drink8: value.drink8,drink10: value.drink10,

        id: value.id,
        productId: productId,
        quantity: value.quantity - 1,
        details: value.details,
      ),
    );

    notifyListeners();
  }

  void increaseQuantityByOne(String productId) {
    _cartItems.update(
      productId,
      (value) => CartModel(
        productCategoryName: value.productCategoryName,
        totalPrice: value.totalPrice,
        extra1: value.extra1,
        extra2: value.extra2,
        extra3: value.extra3,
        extra4: value.extra4,
        extra5: value.extra5,
        extra6: value.extra6,
        extra7: value.extra7,
        extra8: value.extra8,extra9: value.extra9,
        extra10: value.extra10,
        drink1: value.drink1,drink3: value.drink3,drink6: value.drink6,drink7: value.drink7,drink9: value.drink9,
        drink2: value.drink2,drink4: value.drink4,drink5: value.drink5,drink8: value.drink8,drink10: value.drink10,
        id: value.id,
        productId: productId,
        quantity: value.quantity + 1,
        details: value.details,
      ),
    );
    notifyListeners();
  }

  Future<void> removeOneItem(
      {required String cartId,
      required String details,
      required String productId,
      required int quantity}) async {
    final User? user = authInstance.currentUser;
    await userCollection.doc(user!.uid).update({
      'userCart': FieldValue.arrayRemove([
        {'cartId': cartId, 'productId': productId, 'quantity': quantity,'details':details,}
      ])
    });
    _cartItems.remove(productId);
    await fetchCart();
    notifyListeners();
  }

  Future<void> clearOnlineCart() async {
    final User? user = authInstance.currentUser;
    await userCollection.doc(user!.uid).update({
      'userCart': [],
    });
    _cartItems.clear();
    notifyListeners();
  }

  void clearLocalCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
