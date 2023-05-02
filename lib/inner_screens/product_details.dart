import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:provider/provider.dart';

import '../consts/firebase_consts.dart';
import '../consts/theme_data.dart';
import '../providers/cart_provider.dart';
import '../providers/products_provider.dart';
import '../providers/viewed_prod_provider.dart';
import '../providers/wishlist_provider.dart';
import '../services/global_methods.dart';
import '../services/utils.dart';
import '../widgets/heart_btn.dart';
import '../widgets/text_widget.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/ProductDetails';

  const ProductDetails({Key? key}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool _isChecked1 = false;
  final _quantityTextController = TextEditingController(text: '1');

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _quantityTextController.dispose();

    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;

    final cartProvider = Provider.of<CartProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final productProvider = Provider.of<ProductsProvider>(context);
    final getCurrProduct = productProvider.findProdById(productId);

    double usedPrice = getCurrProduct.isOnSale
        ? getCurrProduct.salePrice
        : getCurrProduct.price;
    double totalPrice = usedPrice * int.parse(_quantityTextController.text);
    bool? _isInCart = cartProvider.getCartItems.containsKey(getCurrProduct.id);

    bool? _isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(getCurrProduct.id);

    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        viewedProdProvider.addProductToHistory(productId: productId);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
            leading: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () =>
                  Navigator.canPop(context) ? Navigator.pop(context) : null,
              child: Icon(
                IconlyLight.arrowLeft2,
                color: color,
                size: 24,
              ),
            ),
            elevation: 0,
            backgroundColor: primary),
        body: SingleChildScrollView(
          child: Column(children: [
              FancyShimmerImage(
                imageUrl: getCurrProduct.imageUrl,
                boxFit: BoxFit.scaleDown,
                width: size.width,
              ),
             Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 30, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: TextWidget(
                              text: getCurrProduct.title,
                              color: color,
                              textSize: 25,
                              isTitle: true,
                            ),
                          ),
                          HeartBTN(
                            productId: getCurrProduct.id,
                            isInWishlist: _isInWishlist,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 30, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          TextWidget(
                            text: 'price: \$${usedPrice.toStringAsFixed(2)}',
                            color: Colors.green,
                            textSize: 22,
                            isTitle: true,
                          ),
                          // TextWidget(
                          //   text: getCurrProduct.isPiece ? '/Piece' : '/Kg',
                          //   color: color,
                          //   textSize: 12,
                          //   isTitle: false,
                          // ),

                          const SizedBox(
                            width: 10,
                          ),
                          Visibility(
                            visible: getCurrProduct.isOnSale ? true : false,
                            child: Text(
                              '\$${getCurrProduct.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: color,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          ),


                        ],
                      ),
                    ),

                    Container(
                      child: Column(
                        children: [
                          getCurrProduct.extra1 == ""?
                          Text(""):
                          Theme(
                            data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.pink
                            ),
                            child: CheckboxListTile(
                              title: Text(getCurrProduct.extra1,style: TextStyle()),
                              value: _isChecked1,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked1 = value ?? false;
                                  // Use null-aware operator to set default value to false in case value is null
                                });
                              },
                            ),
                          ),

                          getCurrProduct.extra2 == ""?
                          Text(""):
                              Text(getCurrProduct.extra2,style: TextStyle(
                                color: color,fontSize: 22,
                              ),
                                textAlign: TextAlign.end,
                              ),

                          getCurrProduct.extra3 == ""?
                          Text(""):
                          TextWidget(
                            text: getCurrProduct.extra3,
                            color: Colors.green,
                            textSize: 22,
                            isTitle: true,
                          ),
                          getCurrProduct.extra4 == ""?
                          Text(""):
                          TextWidget(
                            text: getCurrProduct.extra4,
                            color: Colors.green,
                            textSize: 22,
                            isTitle: true,
                          ),
                          getCurrProduct.extra5 == ""?
                          Text(""):
                          TextWidget(
                            text: getCurrProduct.extra5,
                            color: Colors.green,
                            textSize: 22,
                            isTitle: true,
                          ),
                          getCurrProduct.extra6 == ""?
                          Text(""):
                          TextWidget(
                            text: getCurrProduct.extra6,
                            color: Colors.green,
                            textSize: 22,
                            isTitle: true,
                          ),
                          getCurrProduct.extra7 == ""?
                          Text(""):
                          TextWidget(
                            text: getCurrProduct.extra7,
                            color: Colors.green,
                            textSize: 22,
                            isTitle: true,
                          ),
                          getCurrProduct.extra8 == ""?
                          Text(""):
                          TextWidget(
                            text: getCurrProduct.extra8,
                            color: Colors.green,
                            textSize: 22,
                            isTitle: true,
                          ),
                          getCurrProduct.extra9 == ""?
                          Text(""):
                          TextWidget(
                            text: getCurrProduct.extra9,
                            color: Colors.green,
                            textSize: 22,
                            isTitle: true,
                          ),
                          getCurrProduct.extra10 == ""?
                          Text(""):
                          TextWidget(
                            text: getCurrProduct.extra10,
                            color: Colors.green,
                            textSize: 22,
                            isTitle: true,
                          ),

                        ],
                      ),
                    ),


                            const SizedBox(
                      height: 45,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        quantityControl(
                          fct: () {
                            if (_quantityTextController.text == '1') {
                              return;
                            } else {
                              setState(() {
                                _quantityTextController.text =
                                    (int.parse(_quantityTextController.text) - 1)
                                        .toString();
                              });
                            }
                          },
                          icon: CupertinoIcons.minus,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(

                          child: TextField(
                            controller: _quantityTextController,
                            key: const ValueKey('quantity'),
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                            ),
                            textAlign: TextAlign.center,
                            cursorColor: Colors.green,
                            enabled: true,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                            ],
                            onChanged: (value) {
                              setState(() {
                                if (value.isEmpty) {
                                  _quantityTextController.text = '1';
                                } else {}
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        quantityControl(
                          fct: () {
                            setState(() {
                              _quantityTextController.text =
                                  (int.parse(_quantityTextController.text) + 1)
                                      .toString();
                            });
                          },
                          icon: CupertinoIcons.plus,
                          color: Colors.green,
                        ),
                      ],
                    ),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 30),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: 'Total',
                                  color: Colors.red.shade300,
                                  textSize: 20,
                                  isTitle: true,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                FittedBox(
                                  child: Row(
                                    children: [
                                      TextWidget(
                                        text:
                                            '\$${totalPrice.toStringAsFixed(2)}',
                                        color: color,
                                        textSize: 20,
                                        isTitle: true,
                                      ),
                                      // TextWidget(
                                      //   text: '${_quantityTextController.text}Kg',
                                      //   color: color,
                                      //   textSize: 16,
                                      //   isTitle: false,
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Flexible(
                            child: Material(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                onTap: _isInCart
                                    ? null
                                    : () async {
                                        // if (_isInCart) {
                                        //   return;
                                        // }
                                        final User? user =
                                            authInstance.currentUser;

                                        if (user == null) {
                                          GlobalMethods.errorDialog(
                                              subtitle:
                                                  'No user found, Please login first',
                                              context: context);
                                          return;
                                        }
                                        await GlobalMethods.addToCart(
                                            productId: getCurrProduct.id,
                                            details: "s",
                                            quantity: int.parse(
                                                _quantityTextController.text),
                                            context: context);
                                        await cartProvider.fetchCart();
                                        // cartProvider.addProductsToCart(
                                        //     productId: getCurrProduct.id,
                                        //     quantity: int.parse(
                                        //         _quantityTextController.text));
                                      },
                                borderRadius: BorderRadius.circular(10),
                                child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: TextWidget(
                                        text:
                                            _isInCart ? 'In cart' : 'Add to cart',
                                        color: Colors.white,
                                        textSize: 18)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          
          ]),
        ),
      ),
    );
  }
  

  Widget quantityControl(
      {required Function fct, required IconData icon, required Color color}) {
    return Flexible(
      flex: 2,
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: color,
        child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              fct();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 25,
              ),
            )),
      ),
    );
  }

  // class <Future> details()async{
  //   final User? user = authInstance.currentUser;
  //    final _uid = user!.uid;
  //    await FirebaseFirestore.instance.collection('orders').doc(_uid).set({
  //     'details':detailOrder.text,
  //    });
  // }
 

}
