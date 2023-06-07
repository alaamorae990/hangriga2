import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hangry/widgets/text_widget.dart';

import 'package:provider/provider.dart';

import '../consts/firebase_consts.dart';
import '../inner_screens/on_sale_screen.dart';
import '../inner_screens/product_details.dart';
import '../models/products_model.dart';
import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';
import '../services/global_methods.dart';
import '../services/utils.dart';
import 'heart_btn.dart';
import 'price_widget.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({Key? key}) : super(key: key);

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  final User? user = authInstance.currentUser;
  @override
  void initState() {

    _fetchData();
    super.initState();
  }

  String firstItem='1';
  Future<void> _fetchData() async {

    try {
      final userCollection = FirebaseFirestore.instance.collection('users');
      final DocumentSnapshot userDoc = await userCollection.doc(user!.uid).get();
      userDoc.get('userCart')==null ? null :

      firstItem=userDoc.get('userCart')[0]['productCategoryName'];
    } catch (e) {
      print(e.toString());

    }
  }
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final productModel = Provider.of<ProductModel>(context);
    final theme = Utils(context).getTheme;
    Size size = Utils(context).getScreenSize;
    final cartProvider = Provider.of<CartProvider>(context);
    bool? _isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? _isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(productModel.id);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(

        color: Color.fromARGB(181, 253, 214, 230).withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(

          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pushNamed(context, ProductDetails.routeName,
                arguments: productModel.id);
            // GlobalMethods.navigateTo(
            //     ctx: context, routeName: ProductDetails.routeName);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      FancyShimmerImage(
                        imageUrl: productModel.imageUrl,
                        height: size.width * 0.24,
                        width: size.width * 0.30,
                        boxFit: BoxFit.fill,
                      ),
                      Column(
                        children: [
                          // TextWidget(
                          //   text: productModel.isPiece ? '1Piece' : '1KG',
                          //   color: color,
                          //   textSize: 22,
                          //   isTitle: true,
                          // ),
                          const SizedBox(
                            height: 12,
                          ),
        //                   Row(
        //                     children: [
        //                       GestureDetector(
        //                         onTap: _isInCart
        //                             ? null
        //                             :  firstItem=="1" || firstItem==productModel.productCategoryName?
        //                             () async {
        //                                   final User? user =
        //                                       authInstance.currentUser;
        //
        //                                   if (user == null) {
        //                                     GlobalMethods.errorDialog(
        //                                         subtitle:
        //                                             'No user found, Please login first',
        //                                         context: context);
        //                                     return;
        //                                   }
        //                                 await GlobalMethods.addToCart(
        //                                     productId: productModel.id,
        //                                     totalPrice: productModel.price,
        //                                     productCategoryName: productModel.productCategoryName,
        //                                     details: "",
        //                                     quantity: 1,
        //                                     context: context);
        //                                 await cartProvider.fetchCart();
        //   final userCollection = FirebaseFirestore.instance.collection('users');
        //   final DocumentSnapshot userDoc = await userCollection.doc(user!.uid).get();
        //
        //   firstItem=userDoc.get('userCart')[0]['productCategoryName'];
        //   }:() {
        // showDialog(
        // context: context,
        // builder: (BuildContext context) {
        // return AlertDialog(
        // title: Text("you can order only from one resturant"),
        // content: Text("one order one resturant"),
        // actions: [
        // TextButton(
        // child: Text("OK"),
        // onPressed: () {
        // Navigator.of(context).pop();
        // },
        // ),
        // ],
        // );
        // },
        // );
        //                                 // cartProvider.addProductsToCart(
        //                                 //     productId: productModel.id,
        //                                 //     quantity: 1);
        //                               },
        //                         child: Icon(
        //                           _isInCart
        //                               ? IconlyBold.bag2
        //                               : IconlyLight.bag2,
        //                           size: 22,
        //                           color: _isInCart ? Colors.green : color,
        //                         ),
        //                       ),
        //                       HeartBTN(
        //                         productId: productModel.id,
        //                         isInWishlist: _isInWishlist,
        //                       )
        //                     ],
        //                   ),
                        ],
                      )
                    ],
                  ),
                  PriceWidget(
                    salePrice: productModel.salePrice,
                    price: productModel.price,
                    textPrice: '1',
                    isOnSale: true,
                  ),
                  const SizedBox(height: 5),
                  TextWidget(
                    text: productModel.title,
                    color: color,
                    textSize: 16,
                    isTitle: true,
                    
                  ),
                  const SizedBox(height: 5),
                ]),
          ),
        ),
      ),
    );
  }
}
