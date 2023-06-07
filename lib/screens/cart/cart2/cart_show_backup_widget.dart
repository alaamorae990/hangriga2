import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hangry/consts/theme_data.dart';
import 'package:hangry/screens/user.dart';

import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../consts/firebase_consts.dart';
import '../../../fetch_screen.dart';
import '../../../inner_screens/product_details.dart';
import '../../../models/cart_model.dart';
import '../../../providers/cart_provider.dart';
import '../../../providers/orders_provider.dart';
import '../../../providers/products_provider.dart';
import '../../../providers/wishlist_provider.dart';
import '../../../services/global_methods.dart';
import '../../../services/utils.dart';
import '../../../widgets/back_widget.dart';
import '../../../widgets/heart_btn.dart';
import '../../../widgets/text_widget.dart';

class CartShowBackupWidget extends StatefulWidget {
  const CartShowBackupWidget({Key? key, required this.q, required this.details, required this.time, required this.mous, required this.totalFood})
      : super(key: key);
  final int q;
  final double mous;
  final String totalFood,details,time;
  @override
  State<CartShowBackupWidget> createState() => _CartShowBackupWidgetState();
}

class _CartShowBackupWidgetState extends State<CartShowBackupWidget> {
  final _quantityTextController = TextEditingController();
  @override
  void initState() {
    _quantityTextController.text = widget.q.toString();
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
        Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    // Size size = Utils(context).getScreenSize;
    final productProvider = Provider.of<ProductsProvider>(context, listen: false);
    final cartModel = Provider.of<CartModel>(context, listen: false);
    final getCurrProduct = productProvider.findProdById(cartModel.productId);
        final cartProvider = Provider.of<CartProvider>(context, listen: false);
    //     cartProvider.getCartItems.forEach((key, value) {
    //   final getCurrProduct = productProvider.findProdById(value.productId);});
    // // double usedPrice = getCurrProduct.isOnSale
    //     ? getCurrProduct.salePrice
    //     : getCurrProduct.price;
    // final cartProvider = Provider.of<CartProvider>(context);
    // _checkout();

    return GestureDetector(
      onTap: () {
        _checkout();
            // cartProvider.clearOnlineCart();
            // cartProvider.clearLocalCart();
            // ordersProvider.fetchOrders();

  },
      
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: 
              
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                                       decoration: BoxDecoration(
                            color: primary.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child:


                           TextWidget(
                             //your order
                                      text:  'Du beställer '+'${getCurrProduct.title}',
                                      color: color,
                                      textSize: 16,
                                      isTitle: true,
                               ),




                           ),
                              Icon(Icons.check_circle_outline),
                              // TextWidget(text: "Your order has been placed and it need 20 min to be ready tap here to return to home page", color: color, textSize: 18),
                              // TextWidget(text: "Your order has been placed and it need 20 min to be ready tap here to return to home page", color: color, textSize: 18),
                            ],
                          ),
                      ),
                    )
                    )
                  ],
                ),
                   
                              
             
          ),
             //you can go to resturant and backup it, tap here to return to home page
             Center(child: TextWidget(text: " du kan gå till restaurangen och backup den, tryck här för att återgå till startsidan", color: color, textSize: 18,isTitle: true,)),
        ],
      ),
    );
  }

  Future<Widget> _checkout() async {
    User? user = authInstance.currentUser;
    final orderId = const Uuid().v4();
    String? phoneNumber;

    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);

    Size size = Utils(context).getScreenSize;
    final productProvider = Provider.of<ProductsProvider>(context, listen: false);
    final cartModel = Provider.of<CartModel>(context, listen: false);
    final getCurrProduct3 = productProvider.findProdById(cartModel.productId);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    double total = 0.0;
    String spacing = "*********";
    String quantityOfOrders = '';
    String extra='';
    String namesOfOrders = " ";
    String totalExtra='';
    String totlaDrink='';
    String food='';

    cartProvider.getCartItems.forEach((key, value) {
      final getCurrProduct = productProvider.findProdById(value.productId);
      total += value.totalPrice ;

      totalExtra+=(value.extra1==""?"":value.extra1+" , ")+(value.extra2==""?"":value.extra2+" , ")+(value.extra3==""?"":value.extra3+" , ")+(value.extra4==""?"":value.extra4+" , ")+(value.extra5==""?"":value.extra5+" , ")+(value.extra6==""?"":value.extra6+" , ")+(value.extra7==""?"":value.extra7+" , ")+(value.extra8==""?"":value.extra8+" , ")+(value.extra9==""?"":value.extra9+" , ")+(value.extra10==""?"":value.extra10+" , ");
      totlaDrink+=(value.drink1==""?"":value.drink1+" , ")+(value.drink2==""?"":value.drink2+" , ")+(value.drink3==""?"":value.drink3+" , ")+(value.drink4==""?"":value.drink4+" , ")+(value.drink5==""?"":value.drink5+" , ")+(value.drink6==""?"":value.drink6+" ,  ")+(value.drink7==""?"":value.drink7+" , ")+(value.drink8==""?"":value.drink8+" , ")+(value.drink9==""?"":value.drink9+" , ")+(value.drink10==""?"":value.drink10+" , ");
      namesOfOrders = (namesOfOrders + spacing + getCurrProduct.title);
      food+=value.quantity.toString()+" x "+getCurrProduct.title+': '+(value.quantity*getCurrProduct.price).toString()+" Kr )"+" ( "+totalExtra+" ) ";
      quantityOfOrders =
      (quantityOfOrders + spacing + value.quantity.toString());
      extra=(extra+spacing+value.extra1==""?"":(value.extra1+spacing)+value.extra2==""?"":(value.extra2+spacing)

      );
      totalExtra="";
      // yourList.add(value);
    });

      // final getCurrProduct2 = productProvider.findProdById(
      //   value.productId,
      // );
      // final loc.LocationData _locationResult =
      //     await location.getLocation();
      // final ProductDetails details = new ProductDetails(itemName: "",);

      try {
        final DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();
        phoneNumber = userDoc.get('phoneNumber');
        await FirebaseFirestore.instance.collection('ordersBackup').doc(orderId).set({
          'orderId': orderId,
          'userId': user.uid,
          // 'productId': value.productId,
          // 'price': (getCurrProduct3.isOnSale
          //         ? getCurrProduct3.salePrice
          //         : getCurrProduct3.price) *
          //     value.quantity,
          'totalPrice': total,
          'drink':totlaDrink,
          'quantity': quantityOfOrders,
          'imageUrl': getCurrProduct3.imageUrl,
          'userName': user.displayName,
          'isServed':false,
          'totalFood':widget.totalFood,
          // 'latitude': _locationResult.latitude,
          // 'longitude': _locationResult.longitude,
          'orderDate': Timestamp.now(),
          'phoneNumber': phoneNumber,
          'productCategoryName': getCurrProduct3.productCategoryName,
          'title': food,
          'details': widget.details,
          'ordertime':widget.time,
        });
        //payment fun is here with delivery
        await
            cartProvider.clearOnlineCart();
            cartProvider.clearLocalCart();
            // ordersProvider.fetchOrders();
            await Fluttertoast.showToast(
              //
          msg: "Din beställning har lagts och den behöver 20 minuter för att bli klar:",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (BuildContext context) => const FetchScreen()));

      } catch (error) {
        GlobalMethods.errorDialog(subtitle: error.toString(), context: context);
      } finally {}
    ;
    return Text("data");
  }
}
