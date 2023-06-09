import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hangry/widgets/price_widget.dart';
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

class FeedsWidget extends StatefulWidget {
  const FeedsWidget({Key? key}) : super(key: key);

  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
  final _quantityTextController = TextEditingController();
  @override
  void initState() {
    _quantityTextController.text = '1';
    _fetchData();
    super.initState();
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
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool? _isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? _isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(productModel.id);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  ProductDetails(
                id: productModel.id,
                itemName: productModel.productCategoryName,
              ),

              ),

            );
            // GlobalMethods.navigateTo(
            //     ctx: context, routeName: ProductDetails.routeName);
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(children: [
            
            FancyShimmerImage(
              imageUrl: productModel.imageUrl,
              height: size.width * 0.50,
              width: size.width * 0.40,
              boxFit: BoxFit.fill,
            ),
             const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // GestureDetector(
                              //   onTap: _isInCart
                              //       ? null
                              //       :  firstItem=="1" || firstItem==productModel.productCategoryName?
                              //       () async {
                              //           final User? user =
                              //               authInstance.currentUser;
                              //
                              //           if (user == null) {
                              //             GlobalMethods.errorDialog(
                              //                 subtitle:
                              //                     'No user found, Please login first',
                              //                 context: context);
                              //             return;
                              //           }
                              //           await GlobalMethods.addToCart(
                              //             totalPrice: productModel.price,
                              //               productCategoryName: productModel.productCategoryName,
                              //               productId: productModel.id,
                              //               details: "Enter details",
                              //               quantity: 1,
                              //               context: context);
                              //           await cartProvider.fetchCart();
                              //           final userCollection = FirebaseFirestore.instance.collection('users');
                              //           final DocumentSnapshot userDoc = await userCollection.doc(user!.uid).get();
                              //
                              //           firstItem=userDoc.get('userCart')[0]['productCategoryName'];
                              //       }:() {
                              //     showDialog(
                              //       context: context,
                              //       builder: (BuildContext context) {
                              //         return AlertDialog(
                              //           title: Text("you can order only from one resturant"),
                              //           content: Text("one order one resturant"),
                              //           actions: [
                              //             TextButton(
                              //               child: Text("OK"),
                              //               onPressed: () {
                              //                 Navigator.of(context).pop();
                              //               },
                              //             ),
                              //           ],
                              //         );
                              //       },
                              //     );
                              //         // cartProvider.addProductsToCart(
                              //           //     productId: productModel.id,
                              //           //     quantity: 1);
                              //         },
                              //   child: Icon(
                              //     _isInCart
                              //         ? IconlyBold.bag2
                              //         : IconlyLight.bag2,
                              //     size: 22,
                              //     color: _isInCart ? Colors.green : color,
                              //   ),
                              // ),
                              HeartBTN(
                                productId: productModel.id,
                                isInWishlist: _isInWishlist,
                              )
                            ],
                          ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: TextWidget(
                      text: productModel.title,
                      color: color,
                      maxLines: 1,
                      textSize: 18,
                      isTitle: true,
                    ),
                  ),
                  
                  // Flexible(
                  //     flex: 1,
                  //     child: HeartBTN(
                  //       productId: productModel.id,
                  //       isInWishlist: _isInWishlist,
                  //     )
                  //     ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: PriceWidget(
                      salePrice: productModel.salePrice,
                      price: productModel.price,
                      textPrice: _quantityTextController.text,
                      isOnSale: productModel.isOnSale,
                    ),
                  ),
                  Flexible(
                    child: Row(
                      children: const [
                        // Flexible(
                        //   flex: 6,
                        //   child: FittedBox(
                        //     child: TextWidget(
                        //       text: productModel.isPiece ? 'Piece' : 'kg',
                        //       color: color,
                        //       textSize: 20,
                        //       isTitle: true,
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          width: 5,
                        ),
                        // Flexible(
                        //     flex: 2,
                        //     // TextField can be used also instead of the textFormField
                        //     child: TextFormField(
                        //       controller: _quantityTextController,
                        //       key: const ValueKey('10'),
                        //       style: TextStyle(color: color, fontSize: 18),
                        //       keyboardType: TextInputType.number,
                        //       maxLines: 1,
                        //       enabled: true,
                        //       onChanged: (valueee) {
                        //         setState(() {});
                        //       },
                        //       inputFormatters: [
                        //         FilteringTextInputFormatter.allow(
                        //           RegExp('[0-9.]'),
                        //         ),
                        //       ],
                        //     )
                        //     )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            // SizedBox(
            //   width: double.infinity,
            //   child: TextButton(
            //     onPressed: _isInCart
            //         ? null
            //         :  firstItem=="1" || firstItem==productModel.productCategoryName?
            //         () async {
            //
            //             final User? user = authInstance.currentUser;
            //
            //             if (user == null) {
            //               GlobalMethods.errorDialog(
            //                   subtitle: 'No user found, Please login first',
            //                   context: context);
            //               return;
            //             }
            //             await GlobalMethods.addToCart(
            //                 productId: productModel.id,
            //                 totalPrice: productModel.price,
            //                 productCategoryName: productModel.productCategoryName,
            //                 details: "",
            //                 quantity: int.parse(_quantityTextController.text),
            //                 context: context);
            //             await cartProvider.fetchCart();
            //             final userCollection = FirebaseFirestore.instance.collection('users');
            //             final DocumentSnapshot userDoc = await userCollection.doc(user!.uid).get();
            //
            //             firstItem=userDoc.get('userCart')[0]['productCategoryName'];
            //         }:() {
            //       showDialog(
            //         context: context,
            //         builder: (BuildContext context) {
            //           return AlertDialog(
            //             title: Text("you can order only from one resturant"),
            //             content: Text("one order one resturant"),
            //             actions: [
            //               TextButton(
            //                 child: Text("OK"),
            //                 onPressed: () {
            //                   Navigator.of(context).pop();
            //                 },
            //               ),
            //             ],
            //           );
            //         },
            //       );
            //             // cartProvider.addProductsToCart(
            //             //     productId: productModel.id,
            //             //     quantity: int.parse(_quantityTextController.text));
            //           },
            //     child: TextWidget(
            //       text: _isInCart ? 'In cart' : 'Add to cart',
            //       maxLines: 1,
            //       color: color,
            //       textSize: 20,
            //     ),
            //     style: ButtonStyle(
            //         backgroundColor:
            //             MaterialStateProperty.all(Theme.of(context).cardColor),
            //         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //           const RoundedRectangleBorder(
            //             borderRadius: BorderRadius.only(
            //               bottomLeft: Radius.circular(12.0),
            //               bottomRight: Radius.circular(12.0),
            //             ),
            //           ),
            //         )),
            //   ),
            // )
          ]),
        ),
      ),
    );
  }
}
