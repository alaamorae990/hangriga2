import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hangry/consts/theme_data.dart';
import 'package:hangry/screens/cart/backup_del_.dart';
import 'package:hangry/widgets/auth_button.dart';

import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../consts/firebase_consts.dart';
import '../../providers/cart_provider.dart';
import '../../providers/orders_provider.dart';
import '../../providers/products_provider.dart';
import '../../services/global_methods.dart';
import '../../services/utils.dart';
import '../../widgets/empty_screen.dart';
import '../../widgets/text_widget.dart';
import '../payment/make_payment.dart';
import 'cart_widget.dart';
import 'package:location/location.dart' as loc;

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

final loc.Location location = loc.Location();
String? phoneNumber;

class _CartScreenState extends State<CartScreen> {
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
        ? Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primary,

        title: const Text("",style: TextStyle(
            fontWeight: FontWeight.bold,color: Colors.white)),
      ),
      body: const EmptyScreen(
        title: 'Your cart is empty',
        subtitle: 'Add something and make me happy :)',
        buttonText: 'Shop now',
        imagePath: 'assets/images/cart.png',
      ),
    )

        : Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title: TextWidget(
                  text: 'Cart (${cartItemsList.length})',
                  color: color,
                  isTitle: true,
                  textSize: 22,
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      GlobalMethods.warningDialog(
                          title: 'Empty your cart?',
                          subtitle: 'Are you sure?',
                          fct: () async {
                            await cartProvider.clearOnlineCart();
                            cartProvider.clearLocalCart();
                          },
                          context: context);
                    },
                    icon: Icon(
                      IconlyBroken.delete,
                      color: color,
                    ),
                  ),
                ]),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(primary),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      side: BorderSide(color: Colors.red)))),
                          onPressed: () {
                            GlobalMethods.navigateTo(
                                ctx: context, routeName: BackupOrDel.routeName);
                          },
                          child: TextWidget(
                            text: 'Order Now',
                            color: Colors.white,
                            textSize: 18,
                            isTitle: true,
                          )),
                      const Spacer(),
                      FittedBox(
                        child: TextWidget(
                          text: 'Total: \$${total.toStringAsFixed(2)}',
                          color: color,
                          textSize: 18,
                          isTitle: true,
                        ),
                      ),
                    ],
                  ),
                ),

                // _checkout(ctx: context),
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItemsList.length,
                    itemBuilder: (ctx, index) {
                      return ChangeNotifierProvider.value(
                          value: cartItemsList[index],
                          child: CartWidget(
                            q: cartItemsList[index].quantity,
                          ));
                    },
                  ),
                ),
              ],
            ),
          );
  }

//                     GlobalMethods.navigateTo(
  // ctx: context, routeName: makePayment.routeName);
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
  //             onTap: ()

  //              async {
  //                   GlobalMethods.DeliveryOrBackup(
  //                     title: 'Do you want us tp delivery or you well take your meal by yourself?',
  //                     subtitle: 'choose one!',
  //                     fct2: () async {
  //               User? user = authInstance.currentUser;
  //               final orderId = const Uuid().v4();
  //               final productProvider =
  //                   Provider.of<ProductsProvider>(ctx, listen: false);

  //               cartProvider.getCartItems.forEach((key, value) async {
  //                 final getCurrProduct = productProvider.findProdById(
  //                   value.productId,
  //                 );
  //                  final loc.LocationData _locationResult = await location.getLocation();

  //                 try {

  //                 final DocumentSnapshot userDoc =  await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
  //                   phoneNumber = userDoc.get('phoneNumber');
  //                   await FirebaseFirestore.instance
  //                       .collection('orders')
  //                       .doc(orderId)
  //                       .set({
  //                     'orderId': orderId,
  //                     'userId': user.uid,
  //                     'productId': value.productId,
  //                     'price': (getCurrProduct.isOnSale
  //                             ? getCurrProduct.salePrice
  //                             : getCurrProduct.price) *
  //                         value.quantity,
  //                     'totalPrice': total,
  //                     'quantity': value.quantity,
  //                     'imageUrl': getCurrProduct.imageUrl,
  //                     'userName': user.displayName,
  //                     'latitude': _locationResult.latitude,
  //                     'longitude': _locationResult.longitude,
  //                     'orderDate': Timestamp.now(),
  //                     'phoneNumber':phoneNumber,
  //                     'productCategoryName':getCurrProduct.productCategoryName,
  //                     'title':getCurrProduct.title,
  //                     'details':getCurrProduct.detiles
  //                   });
  //                   //payment fun is here with delivery
  //                   await cartProvider.clearOnlineCart();
  //                   cartProvider.clearLocalCart();
  //                   ordersProvider.fetchOrders();
  //                   await Fluttertoast.showToast(
  //                     msg: "Your order has been placed and it need 20 min to be ready",
  //                     toastLength: Toast.LENGTH_LONG,
  //                     gravity: ToastGravity.CENTER,
  //                   );
  //                 } catch (error) {
  //                   GlobalMethods.errorDialog(
  //                       subtitle: error.toString(), context: ctx);
  //                 } finally {}
  //               });
  //               },
  //             fct: ()async{
  //               User? user = authInstance.currentUser;
  //               final orderId = const Uuid().v4();
  //               final productProvider =
  //                   Provider.of<ProductsProvider>(ctx, listen: false);

  //               cartProvider.getCartItems.forEach((key, value) async {
  //                 final getCurrProduct = productProvider.findProdById(
  //                   value.productId,
  //                 );

  //                 try {
  //                   // final loc.LocationData _locationResult = await location.getLocation();

  //                 final DocumentSnapshot userDoc =  await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
  //                   phoneNumber = userDoc.get('phoneNumber');
  //                   await FirebaseFirestore.instance
  //                       .collection('ordersBackup')
  //                       .doc(orderId)
  //                       .set({
  //                     'orderId': orderId,
  //                     'userId': user.uid,
  //                     'productId': value.productId,
  //                     'price': (getCurrProduct.isOnSale
  //                             ? getCurrProduct.salePrice
  //                             : getCurrProduct.price) *
  //                         value.quantity,
  //                     'totalPrice': total,
  //                     'quantity': value.quantity,
  //                     'imageUrl': getCurrProduct.imageUrl,
  //                     'userName': user.displayName,
  //                     // 'latitude': _locationResult.latitude,
  //                     // 'longitude': _locationResult.longitude,
  //                     'orderDate': Timestamp.now(),
  //                     'phoneNumber':phoneNumber,
  //                     'productCategoryName':getCurrProduct.productCategoryName,
  //                     'title':getCurrProduct.title,
  //                   });
  //                   //payment fun is here without delivery
  //                   await cartProvider.clearOnlineCart();
  //                   cartProvider.clearLocalCart();
  //                   ordersProvider.fetchOrders();
  //                   await Fluttertoast.showToast(
  //                     msg: "You can go to the resturnat and backup your delivery ",
  //                     toastLength: Toast.LENGTH_LONG,
  //                     gravity: ToastGravity.CENTER,
  //                   );
  //                 } catch (error) {
  //                   GlobalMethods.errorDialog(
  //                       subtitle: error.toString(), context: ctx);
  //                 } finally {}
  //               });
  //             },
  //                context: context, );
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
}
