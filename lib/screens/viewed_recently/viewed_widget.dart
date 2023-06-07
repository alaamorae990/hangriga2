import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import '../../consts/firebase_consts.dart';
import '../../inner_screens/product_details.dart';
import '../../models/viewed_model.dart';
import '../../models/wishlist_model.dart';
import '../../providers/cart_provider.dart';
import '../../providers/products_provider.dart';
import '../../services/global_methods.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart';

class ViewedRecentlyWidget extends StatefulWidget {
  const ViewedRecentlyWidget({Key? key}) : super(key: key);

  @override
  _ViewedRecentlyWidgetState createState() => _ViewedRecentlyWidgetState();
}

class _ViewedRecentlyWidgetState extends State<ViewedRecentlyWidget> {
  @override
  void initState() {
    super.initState();

    _fetchData();

  }
  final User? user = authInstance.currentUser;
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
    final productProvider = Provider.of<ProductsProvider>(context);

    final viewedProdModel = Provider.of<ViewedProdModel>(context);

    final getCurrProduct =
        productProvider.findProdById(viewedProdModel.productId);
    double usedPrice = getCurrProduct.isOnSale
        ? getCurrProduct.salePrice
        : getCurrProduct.price;
    final cartProvider = Provider.of<CartProvider>(context);
    bool? _isInCart = cartProvider.getCartItems.containsKey(getCurrProduct.id);
    Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  ProductDetails(
              id: getCurrProduct.id,
              itemName: getCurrProduct.productCategoryName,
            ),

            ),

          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FancyShimmerImage(
              imageUrl: getCurrProduct.imageUrl,
              boxFit: BoxFit.fill,
              height: size.width * 0.27,
              width: size.width * 0.25,
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              children: [
                TextWidget(
                  text: getCurrProduct.title,
                  color: color,
                  textSize: 24,
                  isTitle: true,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextWidget(
                  text: '\$${usedPrice.toStringAsFixed(2)}',
                  color: color,
                  textSize: 20,
                  isTitle: false,
                ),
              ],
            ),
            const Spacer(),
    //         Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 5),
    //           child: Flexible(
    //             child: Material(
    //               borderRadius: BorderRadius.circular(12),
    //               color: Colors.green,
    //               child:  Builder(builder: (context) => InkWell(
    //                   borderRadius: BorderRadius.circular(12),
    //                   onTap: _isInCart
    //                       ? null
    //                       :  firstItem=="1" || firstItem==getCurrProduct.productCategoryName?
    //                       () async {
    //
    //                     if (user == null) {
    //                             GlobalMethods.errorDialog(
    //                                 subtitle: 'No user found, Please login first',
    //                                 context: context);
    //                             return;
    //                           }
    //                       await    GlobalMethods.addToCart(
    //                               productId: getCurrProduct.id,
    //                               productCategoryName: getCurrProduct.productCategoryName,
    //                               totalPrice: getCurrProduct.price,
    //                               details: "",
    //                               quantity: 1,
    //                               context: context);await cartProvider.fetchCart();
    //                     final userCollection = FirebaseFirestore.instance.collection('users');
    //                     final DocumentSnapshot userDoc = await userCollection.doc(user!.uid).get();
    //
    //                     firstItem=userDoc.get('userCart')[0]['productCategoryName'];
    //
    //                         // cartProvider.addProductsToCart(
    //                           //   productId: getCurrProduct.id,
    //                           //   quantity: 1,
    //                           // );
    // }:() {
    //                     showDialog(
    //                       context: context,
    //                       builder: (BuildContext context) {
    //                         return AlertDialog(
    //                           title: Text("you can order only from one resturant"),
    //                           content: Text("one order one resturant"),
    //                           actions: [
    //                             TextButton(
    //                               child: Text("OK"),
    //                               onPressed: () {
    //                                 Navigator.of(context).pop();
    //                               },
    //                             ),
    //                           ],
    //                         );
    //                       },
    //                     );
    //                   },
    //                   child: Padding(
    //                     padding: const EdgeInsets.all(8.0),
    //                     child: Icon(
    //                       _isInCart ? Icons.check : IconlyBold.plus,
    //                       color: Colors.white,
    //                       size: 20,
    //                     ),
    //                   )),
    //             ),
    //           ),
    //         ),
    //         ),
          ],
        ),
      ),
    );
  }
}
