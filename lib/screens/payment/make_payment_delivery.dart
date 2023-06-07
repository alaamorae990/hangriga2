// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_swish_payment/flutter_swish_payment.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hangry/screens/payment/payment_delivery.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../consts/firebase_consts.dart';
import '../../consts/theme_data.dart';
import '../../fetch_screen.dart';
import '../../providers/cart_provider.dart';
import '../../providers/orders_provider.dart';
import '../../providers/products_provider.dart';
import '../../services/global_methods.dart';
import '../../services/utils.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/text_widget.dart';
import '../cart/cart2/cart_show.dart';
import '../cart/cart_screen.dart';

class MakePaymentDeliv extends StatefulWidget {
  final SwishClient swishClient;
  final LatLng selectedLocation;
  final Set<Marker> markers;
  static const routeName = '/MakePaymentDeliv';

  const MakePaymentDeliv({Key? key, required this.swishClient, required this.selectedLocation, required this.markers})
      : super(key: key);

  @override
  _MakePaymentDelivState createState() => _MakePaymentDelivState();
}

// final loc.Location location = loc.Location();

class _MakePaymentDelivState extends State<MakePaymentDeliv> {
  DateTime? selectedTime;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final detailOrder = TextEditingController();
    final detailAddrees = TextEditingController();
    @override
    void dispose() {
      detailAddrees.dispose();
      super.dispose();
    }
    User? user = authInstance.currentUser;
    final Color color = Utils(context).color;
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItemsList =
        cartProvider.getCartItems.values.toList().reversed.toList();
    final productProvider = Provider.of<ProductsProvider>(context);
    final ordersProvider = Provider.of<OrdersProvider>(context);
    double total = 0.0;
    String extra1="";
    cartProvider.getCartItems.forEach((key, value) {
      final getCurrProduct = productProvider.findProdById(value.productId);
      // extra1=value

      total += value.totalPrice ;
    });

    String mok = "";
    String delivery = "";

    final de = productProvider.getResturants;
    final tax = productProvider.getTax;
    tax.map((e) => mok = e.tax).toList();
    de.map((e) => delivery = e.delievryCost).toList();
    String endTime = "";
    de.map((e) => endTime = e.endTime).toList();
    double totalPricev = double.parse(mok) + double.parse(delivery) + total;
    double mous=double.parse(mok);
    double deliveryFee=double.parse(delivery);
    cartProvider.getCartItems.forEach((key, value) {
      final getCurrProduct = productProvider.findProdById(value.productId);

    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          backgroundColor: primary,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: constraints.maxHeight * 0.4, // Adjust the value as needed
                    width: double.infinity,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: widget.selectedLocation,
                        zoom: 14.0,
                      ),
                      markers: widget.markers,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      maxLines: 2,
                      controller: detailAddrees,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Ingenting";
                        } else {
                          return null;
                        }
                      },
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        hintText:
                            //Enter the apartment details
                        'Ange lägenhetsinformationen',
                        hintStyle: TextStyle(color: Color.fromARGB(
                            255, 90, 82, 82)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  Divider(color: primary,thickness: 2,),
                  Column(
                    children: cartProvider.getCartItems.values.map((value) {
                      final getCurrProduct = productProvider.findProdById(
                          value.productId);
                      return Container(
                        width: double.infinity,
                        child: Column(
                          children: [

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(getCurrProduct.title,
                                      style: const TextStyle(letterSpacing: 2,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18
                                      ),),
                                  ),
                                  TextWidget(
                                      text: '',
                                      color: color,
                                      textSize: 18,
                                      isTitle: true),
                                  Text('${value.quantity}'" x  : " +
                                      (getCurrProduct.price * value.quantity)
                                          .toString(),
                                    style: const TextStyle(letterSpacing: 2,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18
                                    ),),
                                ],
                              ),
                            ),

                            value.extra1 == "" ? const SizedBox.shrink() :
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  const Text(
                                    'Exstra', style: TextStyle(letterSpacing: 2,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18
                                  ),),
                                  TextWidget(
                                      text: '',
                                      color: color,
                                      textSize: 18,
                                      isTitle: true),
                                  Flexible(
                                    child: Text(value.extra1,
                                      style: const TextStyle(letterSpacing: 2,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18
                                      ),),
                                  ),
                                ],
                              ),
                            ),
                            value.extra2 == "" ? const SizedBox.shrink() :
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  const Text(
                                    'Exstra', style: TextStyle(letterSpacing: 2,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18
                                  ),),
                                  TextWidget(
                                      text: '',
                                      color: color,
                                      textSize: 18,
                                      isTitle: true),
                                  Flexible(
                                    child: Text(value.extra2,
                                      style: const TextStyle(letterSpacing: 2,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18
                                      ),),
                                  ),
                                ],
                              ),
                            ),
                            value.extra3 == "" ? const SizedBox.shrink() :
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  const Text(
                                    'Exstra', style: TextStyle(letterSpacing: 2,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18
                                  ),),
                                  TextWidget(
                                      text: '',
                                      color: color,
                                      textSize: 18,
                                      isTitle: true),
                                  Text(value.extra3,
                                    style: const TextStyle(letterSpacing: 2,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18
                                    ),),
                                ],
                              ),
                            ),
                            value.extra4 == "" ? const SizedBox.shrink() :
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  const Text(
                                    'Exstra', style: TextStyle(letterSpacing: 2,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18
                                  ),),
                                  TextWidget(
                                      text: '',
                                      color: color,
                                      textSize: 18,
                                      isTitle: true),

                                  Flexible(
                                    child: Text(value.extra4,
                                      style: const TextStyle(letterSpacing: 2,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18
                                      ),),
                                  ),
                                ],
                              ),
                            ),
                            value.extra5 == "" ? const SizedBox.shrink() :
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  const Text(
                                    'Exstra', style: TextStyle(letterSpacing: 2,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18
                                  ),),
                                  TextWidget(
                                      text: '',
                                      color: color,
                                      textSize: 18,
                                      isTitle: true),

                                  Flexible(
                                    child: Text(value.extra5,
                                      style: const TextStyle(letterSpacing: 2,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18
                                      ),),
                                  ),
                                ],
                              ),
                            ),
                            value.extra6 == "" ? const SizedBox.shrink() :
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  const Text(
                                    'Exstra', style: TextStyle(letterSpacing: 2,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18
                                  ),),
                                  TextWidget(
                                      text: '',
                                      color: color,
                                      textSize: 18,
                                      isTitle: true),

                                  Flexible(
                                    child: Text(value.extra6,
                                      style: const TextStyle(letterSpacing: 2,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18
                                      ),),
                                  ),
                                ],
                              ),
                            ),
                            value.extra7 == "" ? const SizedBox.shrink() :
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  const Text(
                                    'Exstra', style: TextStyle(letterSpacing: 2,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18
                                  ),),
                                  TextWidget(
                                      text: '',
                                      color: color,
                                      textSize: 18,
                                      isTitle: true),

                                  Flexible(
                                    child: Text(value.extra7,
                                      style: const TextStyle(letterSpacing: 2,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18
                                      ),),
                                  ),
                                ],
                              ),
                            ),
                            value.extra8 == "" ? const SizedBox.shrink() :
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  const Text(
                                    'Exstra', style: TextStyle(letterSpacing: 2,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18
                                  ),),
                                  TextWidget(
                                      text: '',
                                      color: color,
                                      textSize: 18,
                                      isTitle: true),

                                  Flexible(
                                    child: Text(value.extra8,
                                      style: const TextStyle(letterSpacing: 2,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18
                                      ),),
                                  ),
                                ],
                              ),
                            ),
                            value.extra9 == "" ? const SizedBox.shrink() :
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  const Text(
                                    'Exstra', style: TextStyle(letterSpacing: 2,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18
                                  ),),
                                  TextWidget(
                                      text: '',
                                      color: color,
                                      textSize: 18,
                                      isTitle: true),

                                  Flexible(
                                    child: Text(value.extra9,
                                      style: const TextStyle(letterSpacing: 2,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18
                                      ),),
                                  ),
                                ],
                              ),
                            ), value.extra10 == "" ? const SizedBox.shrink() :
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  const Text(
                                    'Exstra', style: TextStyle(letterSpacing: 2,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18
                                  ),),
                                  TextWidget(
                                      text: '',
                                      color: color,
                                      textSize: 18,
                                      isTitle: true),

                                  Flexible(
                                    child: Text(value.extra10,
                                      style: const TextStyle(letterSpacing: 2,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18
                                      ),),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(color: Colors.black,),
                            value.drink1 == "" ? const SizedBox.shrink() :
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  const Text(
                                    'drycker', style: TextStyle(letterSpacing: 2,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18
                                  ),),
                                  TextWidget(
                                      text: '',
                                      color: color,
                                      textSize: 18,
                                      isTitle: true),

                                  Flexible(
                                    child: Text(value.drink1,
                                      style: const TextStyle(letterSpacing: 2,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18
                                      ),),
                                  ),
                                ],
                              ),
                            ),
                            value.drink2 == "" ? const SizedBox.shrink() :
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  const Text(
                                    'drycker', style: TextStyle(letterSpacing: 2,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18
                                  ),),
                                  TextWidget(
                                      text: '',
                                      color: color,
                                      textSize: 18,
                                      isTitle: true),

                                  Flexible(
                                    child: Text(value.drink2,
                                      style: const TextStyle(letterSpacing: 2,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18
                                      ),),
                                  ),
                                ],
                              ),
                            ),
                            value.drink3 == "" ? const SizedBox.shrink() :
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  const Text(
                                    'drycker', style: TextStyle(letterSpacing: 2,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18
                                  ),),
                                  TextWidget(
                                      text: '',
                                      color: color,
                                      textSize: 18,
                                      isTitle: true),

                                  Flexible(
                                    child: Text(value.drink3,
                                      style: const TextStyle(letterSpacing: 2,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18
                                      ),),
                                  ),
                                ],
                              ),
                            ),
                            value.drink4 == "" ? const SizedBox.shrink() :
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  const Text(
                                    'drycker', style: TextStyle(letterSpacing: 2,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18
                                  ),),
                                  TextWidget(
                                      text: '',
                                      color: color,
                                      textSize: 18,
                                      isTitle: true),

                                  Flexible(
                                    child: Text(value.drink4,
                                      style: const TextStyle(letterSpacing: 2,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18
                                      ),),
                                  ),
                                ],
                              ),
                            ),
                            value.drink5 == "" ? const SizedBox.shrink() :
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  const Text(
                                    'drycker', style: TextStyle(letterSpacing: 2,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18
                                  ),),
                                  TextWidget(
                                      text: '',
                                      color: color,
                                      textSize: 18,
                                      isTitle: true),

                                  Flexible(
                                    child: Text(value.drink5,
                                      style: const TextStyle(letterSpacing: 2,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18
                                      ),),
                                  ),
                                ],
                              ),
                            ),
                            value.drink6 == "" ? const SizedBox.shrink() :
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  const Text(
                                    'drycker', style: TextStyle(letterSpacing: 2,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18
                                  ),),
                                  TextWidget(
                                      text: '',
                                      color: color,
                                      textSize: 18,
                                      isTitle: true),

                                  Flexible(
                                    child: Text(value.drink6,
                                      style: const TextStyle(letterSpacing: 2,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18
                                      ),),
                                  ),
                                ],
                              ),
                            ),
                            value.drink7 == "" ? const SizedBox.shrink() :
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  const Text(
                                    'drycker', style: TextStyle(letterSpacing: 2,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18
                                  ),),
                                  TextWidget(
                                      text: '',
                                      color: color,
                                      textSize: 18,
                                      isTitle: true),

                                  Flexible(
                                    child: Text(value.drink7,
                                      style: const TextStyle(letterSpacing: 2,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18
                                      ),),
                                  ),
                                ],
                              ),
                            ),
                            value.drink8 == "" ? const SizedBox.shrink() :
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  const Text(
                                    'drycker', style: TextStyle(letterSpacing: 2,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18
                                  ),),
                                  TextWidget(
                                      text: '',
                                      color: color,
                                      textSize: 18,
                                      isTitle: true),

                                  Flexible(
                                    child: Text(value.drink8,
                                      style: const TextStyle(letterSpacing: 2,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18
                                      ),),
                                  ),
                                ],
                              ),
                            ),
                            value.drink9 == "" ? const SizedBox.shrink() :
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  const Text(
                                    'drycker', style: TextStyle(letterSpacing: 2,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18
                                  ),),
                                  TextWidget(
                                      text: '',
                                      color: color,
                                      textSize: 18,
                                      isTitle: true),

                                  Flexible(
                                    child: Text(value.drink9,
                                      style: const TextStyle(letterSpacing: 2,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18
                                      ),),
                                  ),
                                ],
                              ),
                            ),
                            value.drink10 == "" ? const SizedBox.shrink() :
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  const Text(
                                    'drycker', style: TextStyle(letterSpacing: 2,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18
                                  ),),
                                  TextWidget(
                                      text: '',
                                      color: color,
                                      textSize: 18,
                                      isTitle: true),

                                  Flexible(
                                    child: Text(value.drink10,
                                      style: const TextStyle(letterSpacing: 2,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18
                                      ),),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(color: Colors.black,),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          //Food Bill is
                            text: 'Food Bill är',
                            color: color,
                            textSize: 18,
                            isTitle: true),
                        TextWidget(
                            text: '',
                            color: color,
                            textSize: 18,
                            isTitle: true),
                        TextWidget(
                            text: '$total',
                            color: color,
                            textSize: 18,
                            isTitle: true),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                            text: 'moms är',
                            color: color,
                            textSize: 18,
                            isTitle: true),
                        TextWidget(
                            text: '',
                            color: color,
                            textSize: 18,
                            isTitle: true),
                        TextWidget(
                            text: mok,
                            color: color,
                            textSize: 18,
                            isTitle: true),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          //delivery is
                            text: 'leverans är',
                            color: color,
                            textSize: 18,
                            isTitle: true),
                        TextWidget(
                            text: '',
                            color: color,
                            textSize: 18,
                            isTitle: true),
                        TextWidget(
                            text: delivery,
                            color: color,
                            textSize: 18,
                            isTitle: true),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          //Total bill is
                            text: 'Totala räkningen är ',
                            color: color,
                            textSize: 18,
                            isTitle: true),
                        TextWidget(
                            text: '',
                            color: color,
                            textSize: 18,
                            isTitle: true),
                        TextWidget(
                            text: '$totalPricev',
                            color: color,
                            textSize: 18,
                            isTitle: true),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Divider(thickness: 5, color: primary),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      maxLines: 2,
                      controller: detailOrder,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Ingenting";
                        } else {
                          return null;
                        }
                      },
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        hintText:
                       // 'Enter any details that you want EX: no onion for my burger',
                        'Ange alla detaljer som du vill ha EX: ingen lök',
                        hintStyle: TextStyle(color: Color.fromARGB(
                            255, 90, 82, 82)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    //Select Date and Time:
                    'Välj datum och tid:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  RaisedButton(
                    onPressed: () {
                      DateTime now = DateTime.now();
                      DateTime minDate = DateTime.now();
                      // Exclude current date
                      DateTime maxDate = now.add(Duration(days: 3));
                      DatePicker.showDateTimePicker(
                        context,
                        showTitleActions: true,
                        minTime: minDate,
                        maxTime: maxDate,
                        onChanged: (time) {
                          // Update the selectedTime variable in the UI when the time changes
                          // setState(() {
                          //   selectedTime = time;
                          // });
                        },
                        onConfirm: (time) {
                          // Check if the selected time is before 10 PM (22:00)
                          if (time.hour <= int.parse(endTime)) { // 21 corresponds to 9 PM
                            setState(() {
                              selectedTime = DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                                time.hour,
                                time.minute,

                              );
                            });
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  //Invalid Time
                                  title: Text('Välj en tid innan'),
                                  //Please select a time before
                                  content: Text('Välj en tid innan $endTime PM.'),
                                  actions: [
                                    FlatButton(
                                      child: Text('Okej'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        currentTime: DateTime.now(),
                        locale: LocaleType.en,
                      );
                    },
                    //selected
                    child: Text('vald'),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                selectedTime != null
                    ? Text(
                  //Selected Date and Time
                  'Valt datum och tid: ${selectedTime.toString().substring(0, 16)}',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),

                  //Not selected
                  ):Text("Ej valt"),
                  const SizedBox(
                    height: 30,
                  ),
                  TextWidget(
                    //Choose Payment Method
                      text: "Välj betalsätt",
                      color: color,
                      textSize: 20,
                      isTitle: true),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 156, 147, 147)
                              .withOpacity(0.2)),
                      width: 300,
                      height: 200,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          RaisedButton(
                            onPressed: () async {
                              try {
                                await initPayment(
                                    amount: totalPricev * 100,
                                    context: context,
                                    email: user!.email ?? '');
                              } catch (error) {
                                return;
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CartShow(
                                          totalFood:total.toString(),
                                          delevryFee: deliveryFee,
                                          mous: mous,
                                          selectedLocation: widget.selectedLocation,
                                          detiles: detailOrder.text,
                                          addrees:detailAddrees.text,
                                          time:selectedTime.toString().substring(0, 16),
                                        )),
                              );
                            },
                            child: const Text(
                              //Pay with Credit Card
                              'Betala med kreditkort ',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          RaisedButton(
                            onPressed: () {
                              // make PayPal payment
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PaypalPaymentDelivery(
                                        totalFood:total.toString(),
                                        deliveryFee: deliveryFee,
                                        mous: mous,
                                        selectedLocation: widget.selectedLocation,
                                        addrees:detailAddrees.text,
                                        time:selectedTime.toString().substring(0, 16),
                                        total: totalPricev,
                                        detiles:detailOrder.text,

                                        onFinish: (number) async {
                                          // payment done

                                        },
                                      ),
                                ),
                              );
                            },
                            child: const Text(
                              //Pay with Paypal
                              'Betala med PayPal ',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          // RaisedButton(
                          //   onPressed: () {
                          //     //           // make PayPal payment
                          //     //  Navigator.pushNamed(context, HomePage.routeName,
                          //     //    arguments: totalPricev);
                          //     Navigator.of(context).push(
                          //       MaterialPageRoute(
                          //         builder: (BuildContext context) => HomePageDelivery(
                          //           name: totalPricev.toString(),
                          //           details: detailOrder.text,
                          //           swishClient: widget.swishClient,
                          //         ),
                          //       ),
                          //     );
                          //   },
                          //   child: const Text(
                          //     'Pay with Swish',
                          //     textAlign: TextAlign.center,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );

          }
        ),
      ),
    );
  }


  Future<void> initPayment(
      {required String email,
      required double amount,
      required BuildContext context}) async {
    try {
      // 1. Create a payment intent on the server
      final response = await http.post(
          Uri.parse(
              'https://us-central1-hangry-94bea.cloudfunctions.net/stripePaymentIntentRequest'),
          body: {
            'email': email,
            'amount': amount.toString(),
          });

      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse.toString());
      if (jsonResponse['success'] == false) {
        GlobalMethods.errorDialog(
            subtitle: jsonResponse['error'], context: context);
            throw jsonResponse['error'];
      }
      // 2. Initialize the payment sheet
      
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: jsonResponse['paymentIntent'],
        merchantDisplayName: 'HANGRIGA',
        customerId: jsonResponse['customer'],
        customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
        // merchantCountryCode: 'SG',
      ));
      await Stripe.instance.presentPaymentSheet();
    
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payment is successful'),
        ),
      );
    } catch (errorr) {
      if (errorr is StripeException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occured ${errorr.error.localizedMessage}'),
          ),
        );
       
      } 
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occured $errorr'),
          ),
        );
        
      } throw '$errorr';
    }
  }
}
