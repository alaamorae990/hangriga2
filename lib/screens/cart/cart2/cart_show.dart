import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hangry/consts/theme_data.dart';
import 'package:hangry/screens/cart/backup_del_.dart';
import 'package:hangry/widgets/auth_button.dart';

import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../providers/cart_provider.dart';
import '../../../providers/orders_provider.dart';
import '../../../providers/products_provider.dart';
import '../../../services/global_methods.dart';
import '../../../services/utils.dart';
import '../../../widgets/empty_screen.dart';
import '../../../widgets/text_widget.dart';
import 'cart_show_backup_widget.dart';
import 'cart_show_widger.dart';

import 'package:location/location.dart' as loc;

class CartShow extends StatefulWidget {
  const CartShow({Key? key, required this.detiles, required this.time,  this.addrees,  this.selectedLocation, required this.mous, required this.delevryFee, required this.totalFood}) : super(key: key);
  final String detiles,totalFood;
  final double mous,delevryFee;
  final String? addrees;
  final String time;
  final LatLng? selectedLocation;
  @override
  State<CartShow> createState() => _CartShowState();
}

final loc.Location location = loc.Location();
String? phoneNumber;

class _CartShowState extends State<CartShow> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItemsList =
    cartProvider.getCartItems.values.toList().reversed.toList();
    final productProvider = Provider.of<ProductsProvider>(context);
    final ordersProvider = Provider.of<OrdersProvider>(context);
    double total = 0.0;
    cartProvider.getCartItems.forEach((key, value) {
      final getCurrProduct = productProvider.findProdById(value.productId);
      total += (getCurrProduct.isOnSale
          ? getCurrProduct.salePrice
          : getCurrProduct.price) *
          value.quantity;
    });
    return cartItemsList.isEmpty
        ? const EmptyScreen(
      title: 'Your cart is empty',
      subtitle: 'Add something and make me happy :)',
      buttonText: 'Shop now',
      imagePath: 'assets/images/cart.png',
    )
        : Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),),
      body: Column(
        children: [
          // _checkout(ctx: context),
          Expanded(
            flex: 1,
            child: ListView.builder(

              itemCount: cartItemsList.length,
              itemBuilder: (ctx, index) {
                return ChangeNotifierProvider.value(
                    value: cartItemsList[index],
                    child: CartShowWidget(
                      totalFood:widget.totalFood,
                      delevryFee: widget.delevryFee,
                      mous: widget.mous,
                      addrees:widget.addrees.toString() ,
                      q: cartItemsList[index].quantity,
                      details: widget.detiles,
                      time:widget.time,
                      selectedLocation: widget.selectedLocation,
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }

}
