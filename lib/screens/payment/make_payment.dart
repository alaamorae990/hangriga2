import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_swish_payment/flutter_swish_payment.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hangry/screens/payment/payment.dart';
import 'package:hangry/screens/payment/payment_delivery.dart';
import 'package:hangry/screens/payment/swich.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

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
import '../cart/cart2/cart_show_backup.dart';
import '../cart/cart_screen.dart';
import 'package:location/location.dart' as loc;

class makePayment extends StatefulWidget {
  final SwishClient swishClient;
  static const routeName = '/makePayment';

  const makePayment({Key? key, required this.swishClient}) : super(key: key);

  @override
  _makePaymentState createState() => _makePaymentState();
}

final loc.Location location = loc.Location();

class _makePaymentState extends State<makePayment> {
  DateTime? selectedTime;
  TextStyle style = TextStyle(fontFamily: 'Open Sans', fontSize: 15.0);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final detailOrder = TextEditingController();
    @override
    void dispose() {
      detailOrder.dispose();
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
    // String delivery = "";
    final de = productProvider.getResturants;
    final tax = productProvider.getTax;
    tax.map((e) => mok = e.tax).toList();
    double mous=double.parse(mok);
    String endTime = "";
    de.map((e) => endTime = e.endTime).toList();
    // de.map((e) => delivery = e.delievryCost).toList();

    double totalPricev = double.parse(mok)  + total;
    cartProvider.getCartItems.forEach((key, value) {
      final getCurrProduct = productProvider.findProdById(value.productId);

    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Column(
                children: cartProvider.getCartItems.values.map((value) {
                  final getCurrProduct = productProvider.findProdById(value.productId);
                  return Column(
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

                      value.extra1==""?const SizedBox.shrink()  :
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Exstra ',style: TextStyle(letterSpacing: 2,
                                fontWeight: FontWeight.normal,fontSize: 18
                            ),),
                            TextWidget(
                                text: '', color: color, textSize: 18, isTitle: true),
                            Flexible(
                              child: Text(value.extra1,style: const TextStyle(letterSpacing: 2,
                                  fontWeight: FontWeight.normal,fontSize: 18
                              ),),
                            ),
                          ],
                        ),
                      ),
                      value.extra2==""?const SizedBox.shrink()  :
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Exstra ',style: TextStyle(letterSpacing: 2,
                                fontWeight: FontWeight.normal,fontSize: 18
                            ),),
                            TextWidget(
                                text: '', color: color, textSize: 18, isTitle: true),
                            Flexible(
                              child: Text(value.extra2,style: const TextStyle(letterSpacing: 2,
                                  fontWeight: FontWeight.normal,fontSize: 18
                              ),),
                            ),
                          ],
                        ),
                      ),
                      value.extra3==""?const SizedBox.shrink() :
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Exstra ',style: TextStyle(letterSpacing: 2,
                                fontWeight: FontWeight.normal,fontSize: 18
                            ),),
                            TextWidget(
                                text: '', color: color, textSize: 18, isTitle: true),
                            Flexible(
                              child: Text(value.extra3,style: const TextStyle(letterSpacing: 2,
                                  fontWeight: FontWeight.normal,fontSize: 18
                              ),),
                            ),
                          ],
                        ),
                      ),
                      value.extra4==""?const SizedBox.shrink() :
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Exstra',style: TextStyle(letterSpacing: 2,
                                fontWeight: FontWeight.normal,fontSize: 18
                            ),),
                            TextWidget(
                                text: '', color: color, textSize: 18, isTitle: true),
                            Flexible(
                              child: Text(value.extra4,style: const TextStyle(letterSpacing: 2,
                                  fontWeight: FontWeight.normal,fontSize: 18
                              ),),
                            ),
                          ],
                        ),
                      ),
                      value.extra5==""?const SizedBox.shrink() :
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Exstra',style: TextStyle(letterSpacing: 2,
                                fontWeight: FontWeight.normal,fontSize: 18
                            ),),
                            TextWidget(
                                text: '', color: color, textSize: 18, isTitle: true),
                            Flexible(
                              child: Text(value.extra5,style: const TextStyle(letterSpacing: 2,
                                  fontWeight: FontWeight.normal,fontSize: 18
                              ),),
                            ),
                          ],
                        ),
                      ),
                      value.extra6==""?const SizedBox.shrink() :
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Exstra',style: TextStyle(letterSpacing: 2,
                                fontWeight: FontWeight.normal,fontSize: 18
                            ),),
                            TextWidget(
                                text: '', color: color, textSize: 18, isTitle: true),
                            Text(value.extra6,style: const TextStyle(letterSpacing: 2,
                                fontWeight: FontWeight.normal,fontSize: 18
                            ),),
                          ],
                        ),
                      ),
                      value.extra7==""?const SizedBox.shrink() :
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Exstra',style: TextStyle(letterSpacing: 2,
                                fontWeight: FontWeight.normal,fontSize: 18
                            ),),
                            TextWidget(
                                text: '', color: color, textSize: 18, isTitle: true),

                            Flexible(
                              child: Text(value.extra7,style: const TextStyle(letterSpacing: 2,
                                  fontWeight: FontWeight.normal,fontSize: 18
                              ),),
                            ),
                          ],
                        ),
                      ),
                      value.extra8==""?const SizedBox.shrink() :
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Exstra',style: TextStyle(letterSpacing: 2,
                                fontWeight: FontWeight.normal,fontSize: 18
                            ),),
                            TextWidget(
                                text: '', color: color, textSize: 18, isTitle: true),

                            Flexible(
                              child: Text(value.extra8,style: const TextStyle(letterSpacing: 2,
                                  fontWeight: FontWeight.normal,fontSize: 18
                              ),),
                            ),
                          ],
                        ),
                      ),
                      value.extra9==""?const SizedBox.shrink() :
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Exstra',style: TextStyle(letterSpacing: 2,
                                fontWeight: FontWeight.normal,fontSize: 18
                            ),),
                            TextWidget(
                                text: '', color: color, textSize: 18, isTitle: true),

                            Flexible(
                              child: Text(value.extra9,style: const TextStyle(letterSpacing: 2,
                                  fontWeight: FontWeight.normal,fontSize: 18
                              ),),
                            ),
                          ],
                        ),
                      ),value.extra10==""?const SizedBox.shrink() :
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Exstra',style: TextStyle(letterSpacing: 2,
                                fontWeight: FontWeight.normal,fontSize: 18
                            ),),
                            TextWidget(
                                text: '', color: color, textSize: 18, isTitle: true),

                            Flexible(
                              child: Text(value.extra10,style: const TextStyle(letterSpacing: 2,
                                  fontWeight: FontWeight.normal,fontSize: 18
                              ),),
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: Colors.black,),
                      value.drink1==""?const SizedBox.shrink() :
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('drycker',style: TextStyle(letterSpacing: 2,
                                fontWeight: FontWeight.normal,fontSize: 18
                            ),),
                            TextWidget(
                                text: '', color: color, textSize: 18, isTitle: true),

                            Flexible(
                              child: Text(value.drink1,style: const TextStyle(letterSpacing: 2,
                                  fontWeight: FontWeight.normal,fontSize: 18
                              ),),
                            ),
                          ],
                        ),
                      ),
                      value.drink2==""?const SizedBox.shrink() :
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('drycker',style: TextStyle(letterSpacing: 2,
                                fontWeight: FontWeight.normal,fontSize: 18
                            ),),
                            TextWidget(
                                text: '', color: color, textSize: 18, isTitle: true),

                            Flexible(
                              child: Text(value.drink2,style: const TextStyle(letterSpacing: 2,
                                  fontWeight: FontWeight.normal,fontSize: 18
                              ),),
                            ),
                          ],
                        ),
                      ),
                      value.drink3==""?const SizedBox.shrink() :
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('drycker',style: TextStyle(letterSpacing: 2,
                                fontWeight: FontWeight.normal,fontSize: 18
                            ),),
                            TextWidget(
                                text: '', color: color, textSize: 18, isTitle: true),

                            Flexible(
                              child: Text(value.drink3,style: const TextStyle(letterSpacing: 2,
                                  fontWeight: FontWeight.normal,fontSize: 18
                              ),),
                            ),
                          ],
                        ),
                      ),
                      value.drink4==""?const SizedBox.shrink() :
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('drycker',style: TextStyle(letterSpacing: 2,
                                fontWeight: FontWeight.normal,fontSize: 18
                            ),),
                            TextWidget(
                                text: '', color: color, textSize: 18, isTitle: true),

                            Flexible(
                              child: Text(value.drink4,style: const TextStyle(letterSpacing: 2,
                                  fontWeight: FontWeight.normal,fontSize: 18
                              ),),
                            ),
                          ],
                        ),
                      ),
                      value.drink5==""?const SizedBox.shrink() :
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('drycker',style: TextStyle(letterSpacing: 2,
                                fontWeight: FontWeight.normal,fontSize: 18
                            ),),
                            TextWidget(
                                text: '', color: color, textSize: 18, isTitle: true),

                            Flexible(
                              child: Text(value.drink5,style: const TextStyle(letterSpacing: 2,
                                  fontWeight: FontWeight.normal,fontSize: 18
                              ),),
                            ),
                          ],
                        ),
                      ),
                      value.drink6==""?const SizedBox.shrink() :
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('drycker',style: TextStyle(letterSpacing: 2,
                                fontWeight: FontWeight.normal,fontSize: 18
                            ),),
                            TextWidget(
                                text: '', color: color, textSize: 18, isTitle: true),

                            Flexible(
                              child: Text(value.drink6,style: const TextStyle(letterSpacing: 2,
                                  
                                  fontWeight: FontWeight.normal,fontSize: 18
                              ),),
                            ),
                          ],
                        ),
                      ),
                      value.drink7==""?const SizedBox.shrink() :
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('drycker',style: TextStyle(letterSpacing: 2,
                                fontWeight: FontWeight.normal,fontSize: 18
                            ),),
                            TextWidget(
                                text: '', color: color, textSize: 18, isTitle: true),

                            Flexible(
                              child: Text(value.drink7,style: const TextStyle(letterSpacing: 2,
                                  fontWeight: FontWeight.normal,fontSize: 18
                              ),),
                            ),
                          ],
                        ),
                      ),
                      value.drink8==""?const SizedBox.shrink() :
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('drycker',style: TextStyle(letterSpacing: 2,
                                fontWeight: FontWeight.normal,fontSize: 18
                            ),),
                            TextWidget(
                                text: '', color: color, textSize: 18, isTitle: true),

                            Flexible(
                              child: Text(value.drink8,style: const TextStyle(letterSpacing: 2,
                                  fontWeight: FontWeight.normal,fontSize: 18
                              ),),
                            ),
                          ],
                        ),
                      ),
                      value.drink9==""?const SizedBox.shrink() :
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('drycker',style: TextStyle(letterSpacing: 2,
                                fontWeight: FontWeight.normal,fontSize: 18
                            ),),
                            TextWidget(
                                text: '', color: color, textSize: 18, isTitle: true),

                            Flexible(
                              child: Text(value.drink9,style: const TextStyle(letterSpacing: 2,
                                  fontWeight: FontWeight.normal,fontSize: 18
                              ),),
                            ),
                          ],
                        ),
                      ),
                      value.drink10==""?const SizedBox.shrink() :
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('drycker',style: TextStyle(letterSpacing: 2,
                                fontWeight: FontWeight.normal,fontSize: 18
                            ),),
                            TextWidget(
                                text: '', color: color, textSize: 18, isTitle: true),

                            Flexible(
                              child: Text(value.drink10,style: const TextStyle(letterSpacing: 2,
                                  fontWeight: FontWeight.normal,fontSize: 18
                              ),),
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: Colors.black,),
                    ],
                  );
                }).toList(),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextWidget(
                      //Food Bill is
                        text: 'maträkningen är',
                        color: color,
                        textSize: 18,
                        isTitle: true),
                    TextWidget(
                        text: '', color: color, textSize: 18, isTitle: true),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextWidget(
                        text: 'moms är',
                        color: color,
                        textSize: 18,
                        isTitle: true),
                    TextWidget(
                        text: '', color: color, textSize: 18, isTitle: true),
                    TextWidget(
                        text: mok, color: color, textSize: 18, isTitle: true),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextWidget(
                      //Total bill is
                        text: 'Totala räkningen är ',
                        color: color,
                        textSize: 18,
                        isTitle: true),
                    TextWidget(
                        text: '', color: color, textSize: 18, isTitle: true),
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
                      //nothing
                      return "Ingenting";
                    } else {
                      return null;
                    }
                  },
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintText:
                        //Enter any details that you want EX: no onion for my burger
                    'Ange alla detaljer som du vill ha EX: ingen lök',
                    hintStyle: TextStyle(color: Color.fromARGB(255, 90, 82, 82)),
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
                'Valt datum och tid:',
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
                              title: Text('Ogiltig tid'),
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
                      color: const Color.fromARGB(255, 156, 147, 147).withOpacity(0.2)),
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
                                builder: (context) => CartShowBackup(
                                  // total: totalPricev,
                                  totalFood: total.toString(),
                                  mous: mous,
                                  time:selectedTime.toString().substring(0, 16),
                                  detiles: detailOrder.text,


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
                                  PaypalPaymentBackUp(
                                    total: totalPricev,
                                    totalFood: total.toString(),
                                    mous: mous,
                                    time:selectedTime.toString().substring(0, 16),
                                    detiles: detailOrder.text,
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
        ),
      ),
    );
  }

  // Widget _checkout({required BuildContext ctx}) {
  //   final Color color = Utils(ctx).color;
  //   Size size = Utils(ctx).getScreenSize;

  //   final cartProvider = Provider.of<CartProvider>(ctx);
  //   final productProvider = Provider.of<ProductsProvider>(ctx);
  //   final ordersProvider = Provider.of<OrdersProvider>(ctx);
  //   double total = 0.0;
  //   cartProvider.getCartItems.forEach((key, value) {
  //     final getCurrProduct = productProvider.findProdById(value.productId);
  //     total += (getCurrProduct.isOnSale
  //             ? getCurrProduct.salePrice
  //             : getCurrProduct.price) *
  //         value.quantity;
  //   });
  //   double mok = 0.5;
  //   double delivery = 5;
  //   double totalPricev = mok + delivery + total;
  //   return SizedBox(
  //     width: double.infinity,
  //     height: size.height * 0.1,
  //     // color: ,
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 12),
  //       child: Row(children: [
  //         Material(
  //           color: Colors.green,
  //           borderRadius: BorderRadius.circular(10),
  //           child: InkWell(
  //             borderRadius: BorderRadius.circular(10),
  //             onTap: () async {
  //               GlobalMethods.DeliveryOrBackup(
  //                 title:
  //                     'Do you want us tp delivery or you well take your meal by yourself?',
  //                 subtitle: 'choose one!',
  //                 fct2: () async {
  //                   User? user = authInstance.currentUser;
  //                   final orderId = const Uuid().v4();
  //                   final productProvider =
  //                       Provider.of<ProductsProvider>(ctx, listen: false);

  //                   cartProvider.getCartItems.forEach((key, value) async {
  //                     final getCurrProduct = productProvider.findProdById(
  //                       value.productId,
  //                     );
  //                     final loc.LocationData _locationResult =
  //                         await location.getLocation();

  //                     try {
  //                       final DocumentSnapshot userDoc = await FirebaseFirestore
  //                           .instance
  //                           .collection('users')
  //                           .doc(user!.uid)
  //                           .get();
  //                       phoneNumber = userDoc.get('phoneNumber');
  //                       await FirebaseFirestore.instance
  //                           .collection('orders')
  //                           .doc(orderId)
  //                           .set({
  //                         'orderId': orderId,
  //                         'userId': user.uid,
  //                         'productId': value.productId,
  //                         'price': (getCurrProduct.isOnSale
  //                                 ? getCurrProduct.salePrice
  //                                 : getCurrProduct.price) *
  //                             value.quantity,
  //                         'totalPrice': total,
  //                         'quantity': value.quantity,
  //                         'imageUrl': getCurrProduct.imageUrl,
  //                         'userName': user.displayName,
  //                         'latitude': _locationResult.latitude,
  //                         'longitude': _locationResult.longitude,
  //                         'orderDate': Timestamp.now(),
  //                         'phoneNumber': phoneNumber,
  //                         'productCategoryName':
  //                             getCurrProduct.productCategoryName,
  //                         'title': getCurrProduct.title,
  //                         'details': getCurrProduct.detiles
  //                       });
  //                       //payment fun is here with delivery
  //                       await cartProvider.clearOnlineCart();
  //                       cartProvider.clearLocalCart();
  //                       ordersProvider.fetchOrders();
  //                       await Fluttertoast.showToast(
  //                         msg:
  //                             "Your order has been placed and it need 20 min to be ready",
  //                         toastLength: Toast.LENGTH_LONG,
  //                         gravity: ToastGravity.CENTER,
  //                       );
  //                     } catch (error) {
  //                       GlobalMethods.errorDialog(
  //                           subtitle: error.toString(), context: ctx);
  //                     } finally {}
  //                   });
  //                 },
  //                 fct: () async {
  //                   User? user = authInstance.currentUser;
  //                   final orderId = const Uuid().v4();
  //                   final productProvider =
  //                       Provider.of<ProductsProvider>(ctx, listen: false);

  //                   cartProvider.getCartItems.forEach((key, value) async {
  //                     final getCurrProduct = productProvider.findProdById(
  //                       value.productId,
  //                     );

  //                     try {
  //                       // final loc.LocationData _locationResult = await location.getLocation();

  //                       final DocumentSnapshot userDoc = await FirebaseFirestore
  //                           .instance
  //                           .collection('users')
  //                           .doc(user!.uid)
  //                           .get();
  //                       phoneNumber = userDoc.get('phoneNumber');
  //                       await FirebaseFirestore.instance
  //                           .collection('ordersBackup')
  //                           .doc(orderId)
  //                           .set({
  //                         'orderId': orderId,
  //                         'userId': user.uid,
  //                         'productId': value.productId,
  //                         'price': (getCurrProduct.isOnSale
  //                                 ? getCurrProduct.salePrice
  //                                 : getCurrProduct.price) *
  //                             value.quantity,
  //                         'totalPrice': total,
  //                         'quantity': value.quantity,
  //                         'imageUrl': getCurrProduct.imageUrl,
  //                         'userName': user.displayName,
  //                         // 'latitude': _locationResult.latitude,
  //                         // 'longitude': _locationResult.longitude,
  //                         'orderDate': Timestamp.now(),
  //                         'phoneNumber': phoneNumber,
  //                         'productCategoryName':
  //                             getCurrProduct.productCategoryName,
  //                         'title': getCurrProduct.title,
  //                       });
  //                       //payment fun is here without delivery
  //                       await cartProvider.clearOnlineCart();
  //                       cartProvider.clearLocalCart();
  //                       ordersProvider.fetchOrders();
  //                       await Fluttertoast.showToast(
  //                         msg:
  //                             "You can go to the resturnat and backup your delivery ",
  //                         toastLength: Toast.LENGTH_LONG,
  //                         gravity: ToastGravity.CENTER,
  //                       );
  //                     } catch (error) {
  //                       GlobalMethods.errorDialog(
  //                           subtitle: error.toString(), context: ctx);
  //                     } finally {}
  //                   });
  //                 },
  //                 context: context,
  //               );
  //             },
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: TextWidget(
  //                 text: 'Order Now',
  //                 textSize: 20,
  //                 color: Colors.white,
  //               ),
  //             ),
  //           ),
  //         ),
  //         const Spacer(),
  //         FittedBox(
  //           child: TextWidget(
  //             text: 'Total: \$${total.toStringAsFixed(2)}',
  //             color: color,
  //             textSize: 18,
  //             isTitle: true,
  //           ),
  //         ),
  //       ]),
  //     ),
  //   );
  // }
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
