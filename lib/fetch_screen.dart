import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:hangry/providers/cart_provider.dart';
import 'package:hangry/providers/dark_theme_provider.dart';
import 'package:hangry/providers/orders_provider.dart';
import 'package:hangry/providers/wishlist_provider.dart';
import 'package:hangry/screens/btm_bar.dart';
import 'package:hangry/screens/cart/cart2/cart_show.dart';
import 'package:hangry/screens/cart/cart2/cart_show_backup.dart';
import 'package:hangry/services/global_methods.dart';
import 'package:provider/provider.dart';

import 'consts/contss.dart';
import 'consts/firebase_consts.dart';
import 'providers/products_provider.dart';

class FetchScreen extends StatefulWidget {
  const FetchScreen({Key? key}) : super(key: key);

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  List<String> images = Constss.authImagesPaths;
    // final _fullNameController = TextEditingController();
    // void dispose(){
    //       _fullNameController.dispose();
    // }
  @override
  void initState() {
    images.shuffle();
    Future.delayed(const Duration(microseconds: 5), () async {
      final productsProvider =
          Provider.of<ProductsProvider>(context, listen: false);

      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      final wishlistProvider =
          Provider.of<WishlistProvider>(context, listen: false);
          //       final orderProvider =
          // Provider.of<OrdersProvider>(context, listen: false);
           Provider.of<DarkThemeProvider>(context, listen: false);
      final User? user = authInstance.currentUser;
      int update=0;
      int version=1;
      try {

        final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('update').doc("VFgsRsooySWxsxUHwHV7").get();
        update = userDoc.get('update');
      } catch (error) {
        GlobalMethods.errorDialog(subtitle: '$error', context: context);
      }
      if(update>version){
        GlobalMethods.errorDialog(subtitle: "Applikationen måste uppdateras", context: context);
      }
      else {
        if (user == null) {
          await productsProvider.fetchProducts();
          cartProvider.clearLocalCart();
          await productsProvider.fetchResturant();
          wishlistProvider.clearLocalWishlist();
          // orderProvider.clearLocalOrder();


        } else {
          // await productsProvider.fetchOrder();
          await productsProvider.fetchProducts();
          await cartProvider.fetchCart();
          await wishlistProvider.fetchWishlist();
          await productsProvider.fetchResturant();
          await productsProvider.fetchTax();
        }

        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx) =>
              BottomBarScreen(
              ),
        ));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            images[0],
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          const Center(
            child: SpinKitFadingFour(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
