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
import '../models/res_model.dart';
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
  final String itemName,id;
  const ProductDetails({Key? key, required this.itemName, required this.id, }) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {


  bool _isChecked1 = false  ;
  bool _isChecked2 = false  ;
  bool _isChecked3 = false  ;
  bool _isChecked4 = false  ;
  bool _isChecked5 = false  ;
  bool _isChecked6 = false  ;
  bool _isChecked7 = false  ;
  bool _isChecked8 = false  ;
  bool _isChecked9 = false  ;
  bool _isChecked10 = false  ;
  bool _drinkChecked1= false ;
  bool _drinkChecked2= false ;
  bool _drinkChecked3= false ;
  bool _drinkChecked4= false ;
  bool _drinkChecked5= false ;
  bool _drinkChecked6= false ;
  bool _drinkChecked7= false ;
  bool _drinkChecked8= false ;
  bool _drinkChecked9= false ;
  bool _drinkChecked10= false ;

  final _quantityExtra1Controller = TextEditingController(text: '1');
  final _quantityExtra2Controller = TextEditingController(text: '1');
  final _quantityExtra3Controller = TextEditingController(text: '1');
  final _quantityExtra4Controller = TextEditingController(text: '1');
  final _quantityExtra5Controller = TextEditingController(text: '1');
  final _quantityExtra6Controller = TextEditingController(text: '1');
  final _quantityExtra7Controller = TextEditingController(text: '1');
  final _quantityExtra8Controller = TextEditingController(text: '1');
  final _quantityExtra9Controller = TextEditingController(text: '1');
  final _quantityExtra10Controller = TextEditingController(text: '1');
  final _quantityTextController = TextEditingController(text: '1');
  final _quantityDrink1Controller = TextEditingController(text: '1');
  final _quantityDrink2Controller = TextEditingController(text: '1');
  final _quantityDrink3Controller = TextEditingController(text: '1');
  final _quantityDrink4Controller = TextEditingController(text: '1');
  final _quantityDrink5Controller = TextEditingController(text: '1');
  final _quantityDrink6Controller = TextEditingController(text: '1');
  final _quantityDrink7Controller = TextEditingController(text: '1');
  final _quantityDrink8Controller = TextEditingController(text: '1');
  final _quantityDrink9Controller = TextEditingController(text: '1');
  final _quantityDrink10Controller = TextEditingController(text: '1');
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _quantityTextController.dispose();

    super.dispose();
  }


  final User? user = authInstance.currentUser;

  final CollectionReference itemsCollection =
  FirebaseFirestore.instance.collection('resturants');


  double drinkpric1=0.0;
  double drinkpric2=0.0;
  double drinkpric3=0.0;
  double drinkpric4=0.0;
  double drinkpric5=0.0;
  double drinkpric6=0.0;
  double drinkpric7=0.0;
  double drinkpric8=0.0;
  double drinkpric9=0.0;
  double drinkpric10=0.0;
  double extrapric1=0.0;
  double extrapric2=0.0;
  double extrapric3=0.0;
  double extrapric4=0.0;
  double extrapric5=0.0;
  double extrapric6=0.0;
  double extrapric7=0.0;
  double extrapric8=0.0;
  double extrapric9=0.0;
  double extrapric10=0.0;



  late QuerySnapshot querySnapshot;
  bool isLoading = true;
  bool isLoading2 = true;
  @override
  void initState() {
    super.initState();

    _fetchData();

  }
  String firstItem='1';
  Future<void> _fetchData() async {

    try {

      querySnapshot = await itemsCollection
          .where('title', isEqualTo: widget.itemName)
          .get();
      final userCollection = FirebaseFirestore.instance.collection('users');
      final DocumentSnapshot userDoc = await userCollection.doc(user!.uid).get();
      userDoc.get('userCart')==null ? null :

      firstItem=userDoc.get('userCart')[0]['productCategoryName'];
      setState(() {
        isLoading2 = false;
      });

    } catch (e) {
      print(e.toString());
      setState(() {
        isLoading2 = false;
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    print(firstItem);
    if (isLoading2) {

      return Center(child: CircularProgressIndicator(
        color: Colors.pink,
      ));
    }
    else{}
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;


    final cartProvider = Provider.of<CartProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    final productProvider = Provider.of<ProductsProvider>(context);
    final getCurrProduct = productProvider.findProdById(widget.id);
    // List<ResModel> drinkByCat = productProvider.findDrinkByCategory(title);
    double usedPrice = getCurrProduct.isOnSale
        ? getCurrProduct.salePrice
        : getCurrProduct.price;



      bool? _isInCart = cartProvider.getCartItems.containsKey(getCurrProduct.id);
    String Drinkprice1=querySnapshot.docs.first['price1'];

    String Drinkprice2=querySnapshot.docs.first['price2'];
    String Drinkprice3=querySnapshot.docs.first['price3'];
    String Drinkprice4=querySnapshot.docs.first['price4'];
    String Drinkprice5=querySnapshot.docs.first['price5'];
    String Drinkprice6=querySnapshot.docs.first['price6'];
    String Drinkprice7=querySnapshot.docs.first['price7'];
    String Drinkprice8=querySnapshot.docs.first['price8'];
    String Drinkprice9=querySnapshot.docs.first['price9'];
    String Drinkprice10=querySnapshot.docs.first['price10'];

    double totalPrice = usedPrice * int.parse(_quantityTextController.text)
        +drinkpric1* int.parse(_quantityDrink1Controller.text)+drinkpric2* int.parse(_quantityDrink2Controller.text)+
        drinkpric3* int.parse(_quantityDrink3Controller.text)+drinkpric4* int.parse(_quantityDrink4Controller.text)+
        drinkpric5* int.parse(_quantityDrink5Controller.text)+drinkpric6* int.parse(_quantityDrink6Controller.text)+
        drinkpric7* int.parse(_quantityDrink7Controller.text)+drinkpric8* int.parse(_quantityDrink8Controller.text)
        +drinkpric9* int.parse(_quantityDrink9Controller.text)+drinkpric10* int.parse(_quantityDrink10Controller.text)+
          extrapric1* int.parse(_quantityExtra1Controller.text)+extrapric2* int.parse(_quantityExtra2Controller.text)+extrapric3* int.parse(_quantityExtra3Controller.text)
        +extrapric4* int.parse(_quantityExtra4Controller.text)+extrapric5* int.parse(_quantityExtra5Controller.text)+extrapric6* int.parse(_quantityExtra6Controller.text)+
        extrapric7* int.parse(_quantityExtra7Controller.text)+extrapric8* int.parse(_quantityExtra8Controller.text)+extrapric9* int.parse(_quantityExtra9Controller.text)
        +extrapric10* int.parse(_quantityExtra10Controller.text)
    ;
    bool? _isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(getCurrProduct.id);

    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);


    return
      WillPopScope(
      onWillPop: () async {
        viewedProdProvider.addProductToHistory(productId: widget.id);
        return true;
      },
      child:
      Scaffold(
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
        backgroundColor: primary.withOpacity(0.5),
        body:
        SingleChildScrollView(
          child: Column(children: [
              FancyShimmerImage(
                imageUrl: getCurrProduct.imageUrl,
                boxFit: BoxFit.contain,
                width: size.width,
              ),
             Container(
                decoration: const BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.only(
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
                          const EdgeInsets.only(top: 10, left: 30, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          TextWidget(
                      //price
                            text: 'pris: \$${usedPrice* int.parse(_quantityTextController.text)}',
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
                    const SizedBox(height: 15,),
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
                    const SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Exstra',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,
                        letterSpacing: 2,
                        )),
                      ],
                    ),


                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: primary.withOpacity(0.5),
                              width: 2,
                            ),
                            color: Colors.white,
                          ),

                          child: Column(
                            children: [
                              getCurrProduct.extra1 == ""?
                              const Text(""):
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: const Color(0xF5FFB9F8),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                      unselectedWidgetColor: Colors.pink,
                                    checkboxTheme: CheckboxThemeData(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  child: CheckboxListTile(
                                    title: Text(getCurrProduct.extra1+' :  +'+getCurrProduct.price1+' kr',style: TextStyle(
                                        color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.normal,letterSpacing: 2
                                    )),
                                    value: _isChecked1,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isChecked1 = value ?? false;
                                        // Use null-aware operator to set default value to false in case value is null
                                        _isChecked1 ? extrapric1=double.parse(getCurrProduct.price1) :

                                        extrapric1=0.0;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              _isChecked1?
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  quantityControl(
                                    fct: () {
                                      if (_quantityExtra1Controller.text == '1') {
                                        return;
                                      } else {
                                        setState(() {
                                          _quantityExtra1Controller.text =
                                              (int.parse(_quantityExtra1Controller.text) - 1)
                                                  .toString();
                                        });
                                      }
                                    },
                                    icon: CupertinoIcons.minus,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(

                                    child: TextField(
                                      controller: _quantityExtra1Controller,
                                      key: const ValueKey('extra1'),
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
                                            _quantityExtra1Controller.text = '1';
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
                                        _quantityExtra1Controller.text =
                                            (int.parse(_quantityExtra1Controller.text) + 1)
                                                .toString();
                                      });
                                    },
                                    icon: CupertinoIcons.plus,
                                    color: Colors.green,
                                  ),
                                ],
                              ):SizedBox.shrink(),

                              getCurrProduct.extra2 == ""?
                              const Text(""):
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              color: const Color(0xF5FFB9F8),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    unselectedWidgetColor: Colors.pink,
                                    checkboxTheme: CheckboxThemeData(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  child: CheckboxListTile(
                                    title: Text(getCurrProduct.extra2+' :  +'+getCurrProduct.price2+' kr',style: TextStyle(
                                        color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.normal,letterSpacing: 2
                                    )),
                                    value: _isChecked2,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isChecked2 = value ?? false;
                                        _isChecked2 ? extrapric2=double.parse(getCurrProduct.price2) :
                                        extrapric2=0.0;
                                        // Use null-aware operator to set default value to false in case value is null
                                      });
                                    },
                                  ),
                                ),
                              ),
                              _isChecked2?
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  quantityControl(
                                    fct: () {
                                      if (_quantityExtra2Controller.text == '1') {
                                        return;
                                      } else {
                                        setState(() {
                                          _quantityExtra2Controller.text =
                                              (int.parse(_quantityExtra2Controller.text) - 1)
                                                  .toString();
                                        });
                                      }
                                    },
                                    icon: CupertinoIcons.minus,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(

                                    child: TextField(
                                      controller: _quantityExtra2Controller,
                                      key: const ValueKey('extra2'),
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
                                            _quantityExtra2Controller.text = '1';
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
                                        _quantityExtra2Controller.text =
                                            (int.parse(_quantityExtra2Controller.text) + 1)
                                                .toString();
                                      });
                                    },
                                    icon: CupertinoIcons.plus,
                                    color: Colors.green,
                                  ),
                                ],
                              ):SizedBox.shrink(),
                              getCurrProduct.extra3 == ""?
                              const Text(""):
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: const Color(0xF5FFB9F8),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    unselectedWidgetColor: Colors.pink,
                                    checkboxTheme: CheckboxThemeData(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  child: CheckboxListTile(
                                    title: Text(getCurrProduct.extra3+' :  +'+getCurrProduct.price3+' kr',style: TextStyle(
                                        color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.normal,letterSpacing: 2
                                    )),
                                    value: _isChecked3,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isChecked3 = value ?? false;
                                        _isChecked3 ? extrapric3=double.parse(getCurrProduct.price3) :
                                        extrapric3=0.0;
                                        // Use null-aware operator to set default value to false in case value is null
                                      });
                                    },
                                  ),
                                ),
                              ),
                              _isChecked3?
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  quantityControl(
                                    fct: () {
                                      if (_quantityExtra3Controller.text == '1') {
                                        return;
                                      } else {
                                        setState(() {
                                          _quantityExtra3Controller.text =
                                              (int.parse(_quantityExtra3Controller.text) - 1)
                                                  .toString();
                                        });
                                      }
                                    },
                                    icon: CupertinoIcons.minus,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(

                                    child: TextField(
                                      controller: _quantityExtra3Controller,
                                      key: const ValueKey('extra3'),
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
                                            _quantityExtra3Controller.text = '1';
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
                                        _quantityExtra3Controller.text =
                                            (int.parse(_quantityExtra3Controller.text) + 1)
                                                .toString();
                                      });
                                    },
                                    icon: CupertinoIcons.plus,
                                    color: Colors.green,
                                  ),
                                ],
                              ):SizedBox.shrink(),

                              getCurrProduct.extra4 == ""?
                              const Text(""):
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: const Color(0xF5FFB9F8),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    unselectedWidgetColor: Colors.pink,
                                    checkboxTheme: CheckboxThemeData(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  child: CheckboxListTile(
                                    title: Text(getCurrProduct.extra4+' :  +'+getCurrProduct.price4+' kr',style: TextStyle(
                                        color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.normal,letterSpacing: 2
                                    )),
                                    value: _isChecked4,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isChecked4 = value ?? false;
                                        _isChecked4 ? extrapric4=double.parse(getCurrProduct.price4) :
                                        extrapric4=0.0;
                                        // Use null-aware operator to set default value to false in case value is null
                                      });
                                    },
                                  ),
                                ),
                              ),
                              _isChecked4?
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  quantityControl(
                                    fct: () {
                                      if (_quantityExtra4Controller.text == '1') {
                                        return;
                                      } else {
                                        setState(() {
                                          _quantityExtra4Controller.text =
                                              (int.parse(_quantityExtra4Controller.text) - 1)
                                                  .toString();
                                        });
                                      }
                                    },
                                    icon: CupertinoIcons.minus,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(

                                    child: TextField(
                                      controller: _quantityExtra4Controller,
                                      key: const ValueKey('extra4'),
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
                                            _quantityExtra4Controller.text = '1';
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
                                        _quantityExtra4Controller.text =
                                            (int.parse(_quantityExtra4Controller.text) + 1)
                                                .toString();
                                      });
                                    },
                                    icon: CupertinoIcons.plus,
                                    color: Colors.green,
                                  ),
                                ],
                              ):SizedBox.shrink(),
                              getCurrProduct.extra5 == ""?
                              const Text(""):
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: const Color(0xF5FFB9F8),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    unselectedWidgetColor: Colors.pink,
                                    checkboxTheme: CheckboxThemeData(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  child: CheckboxListTile(
                                    title: Text(getCurrProduct.extra5+' :  +'+getCurrProduct.price5+' kr',style: TextStyle(
                                        color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.normal,letterSpacing: 2
                                    )),
                                    value: _isChecked5,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isChecked5 = value ?? false;
                                        _isChecked5 ? extrapric5=double.parse(getCurrProduct.price5) :
                                        extrapric5=0.0;
                                        // Use null-aware operator to set default value to false in case value is null
                                      });
                                    },
                                  ),
                                ),
                              ),
                              _isChecked5?
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  quantityControl(
                                    fct: () {
                                      if (_quantityExtra5Controller.text == '1') {
                                        return;
                                      } else {
                                        setState(() {
                                          _quantityExtra5Controller.text =
                                              (int.parse(_quantityExtra5Controller.text) - 1)
                                                  .toString();
                                        });
                                      }
                                    },
                                    icon: CupertinoIcons.minus,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(

                                    child: TextField(
                                      controller: _quantityExtra5Controller,
                                      key: const ValueKey('extra5'),
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
                                            _quantityExtra5Controller.text = '1';
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
                                        _quantityExtra5Controller.text =
                                            (int.parse(_quantityExtra5Controller.text) + 1)
                                                .toString();
                                      });
                                    },
                                    icon: CupertinoIcons.plus,
                                    color: Colors.green,
                                  ),
                                ],
                              ):SizedBox.shrink(),
                              getCurrProduct.extra6 == ""?
                              const Text(""):
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: const Color(0xF5FFB9F8),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    unselectedWidgetColor: Colors.pink,
                                    checkboxTheme: CheckboxThemeData(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  child: CheckboxListTile(
                                    title: Text(getCurrProduct.extra6+' :  +'+getCurrProduct.price6+' kr',style: TextStyle(
                                        color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.normal,letterSpacing: 2
                                    )),
                                    value: _isChecked6,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isChecked6 = value ?? false;
                                        _isChecked6 ? extrapric6=double.parse(getCurrProduct.price6) :
                                        extrapric6=0.0;
                                        // Use null-aware operator to set default value to false in case value is null
                                      });
                                    },
                                  ),
                                ),
                              ),
                              _isChecked6?
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  quantityControl(
                                    fct: () {
                                      if (_quantityExtra6Controller.text == '1') {
                                        return;
                                      } else {
                                        setState(() {
                                          _quantityExtra6Controller.text =
                                              (int.parse(_quantityExtra6Controller.text) - 1)
                                                  .toString();
                                        });
                                      }
                                    },
                                    icon: CupertinoIcons.minus,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(

                                    child: TextField(
                                      controller: _quantityExtra6Controller,
                                      key: const ValueKey('extra6'),
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
                                            _quantityExtra6Controller.text = '1';
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
                                        _quantityExtra6Controller.text =
                                            (int.parse(_quantityExtra6Controller.text) + 1)
                                                .toString();
                                      });
                                    },
                                    icon: CupertinoIcons.plus,
                                    color: Colors.green,
                                  ),
                                ],
                              ):SizedBox.shrink(),
                              getCurrProduct.extra7 == ""?
                              const Text(""):
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: const Color(0xF5FFB9F8),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    unselectedWidgetColor: Colors.pink,
                                    checkboxTheme: CheckboxThemeData(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  child: CheckboxListTile(
                                    title: Text(getCurrProduct.extra7+' :  +'+getCurrProduct.price7+' kr',style: TextStyle(
                                        color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.normal,letterSpacing: 2
                                    )),
                                    value: _isChecked7,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isChecked7 = value ?? false;
                                        _isChecked7 ? extrapric7=double.parse(getCurrProduct.price7) :
                                        extrapric7=0.0;
                                        // Use null-aware operator to set default value to false in case value is null
                                      });
                                    },
                                  ),
                                ),
                              ),
                              _isChecked7?
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  quantityControl(
                                    fct: () {
                                      if (_quantityExtra7Controller.text == '1') {
                                        return;
                                      } else {
                                        setState(() {
                                          _quantityExtra7Controller.text =
                                              (int.parse(_quantityExtra7Controller.text) - 1)
                                                  .toString();
                                        });
                                      }
                                    },
                                    icon: CupertinoIcons.minus,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(

                                    child: TextField(
                                      controller: _quantityExtra7Controller,
                                      key: const ValueKey('extra7'),
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
                                            _quantityExtra7Controller.text = '1';
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
                                        _quantityExtra7Controller.text =
                                            (int.parse(_quantityExtra7Controller.text) + 1)
                                                .toString();
                                      });
                                    },
                                    icon: CupertinoIcons.plus,
                                    color: Colors.green,
                                  ),
                                ],
                              ):SizedBox.shrink(),
                              getCurrProduct.extra8 == ""?
                              const Text(""):
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: const Color(0xF5FFB9F8),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    unselectedWidgetColor: Colors.pink,
                                    checkboxTheme: CheckboxThemeData(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  child: CheckboxListTile(
                                    title: Text(getCurrProduct.extra8+' :  +'+getCurrProduct.price8+' kr',style: TextStyle(
                                        color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.normal,letterSpacing: 2
                                    )),
                                    value: _isChecked8,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isChecked8 = value ?? false;
                                        _isChecked8 ? extrapric8=double.parse(getCurrProduct.price8) :
                                        extrapric8=0.0;
                                        // Use null-aware operator to set default value to false in case value is null
                                      });
                                    },
                                  ),
                                ),
                              ),
                              _isChecked8?
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  quantityControl(
                                    fct: () {
                                      if (_quantityExtra8Controller.text == '1') {
                                        return;
                                      } else {
                                        setState(() {
                                          _quantityExtra8Controller.text =
                                              (int.parse(_quantityExtra8Controller.text) - 1)
                                                  .toString();
                                        });
                                      }
                                    },
                                    icon: CupertinoIcons.minus,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(

                                    child: TextField(
                                      controller: _quantityExtra8Controller,
                                      key: const ValueKey('extra8'),
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
                                            _quantityExtra8Controller.text = '1';
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
                                        _quantityExtra8Controller.text =
                                            (int.parse(_quantityExtra8Controller.text) + 1)
                                                .toString();
                                      });
                                    },
                                    icon: CupertinoIcons.plus,
                                    color: Colors.green,
                                  ),
                                ],
                              ):SizedBox.shrink(),
                              getCurrProduct.extra9 == ""?
                              const Text(""):
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: const Color(0xF5FFB9F8),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    unselectedWidgetColor: Colors.pink,
                                    checkboxTheme: CheckboxThemeData(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  child: CheckboxListTile(
                                    title: Text(getCurrProduct.extra9+' :  +'+getCurrProduct.price9+' kr',style: TextStyle(
                                        color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.normal,letterSpacing: 2
                                    )),
                                    value: _isChecked9,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isChecked9 = value ?? false;
                                        _isChecked9 ? extrapric9=double.parse(getCurrProduct.price9) :
                                        extrapric9=0.0;
                                        // Use null-aware operator to set default value to false in case value is null
                                      });
                                    },
                                  ),
                                ),
                              ),
                              _isChecked9?
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  quantityControl(
                                    fct: () {
                                      if (_quantityExtra9Controller.text == '1') {
                                        return;
                                      } else {
                                        setState(() {
                                          _quantityExtra9Controller.text =
                                              (int.parse(_quantityExtra9Controller.text) - 1)
                                                  .toString();
                                        });
                                      }
                                    },
                                    icon: CupertinoIcons.minus,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(

                                    child: TextField(
                                      controller: _quantityExtra9Controller,
                                      key: const ValueKey('extra9'),
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
                                            _quantityExtra9Controller.text = '1';
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
                                        _quantityExtra9Controller.text =
                                            (int.parse(_quantityExtra9Controller.text) + 1)
                                                .toString();
                                      });
                                    },
                                    icon: CupertinoIcons.plus,
                                    color: Colors.green,
                                  ),
                                ],
                              ):SizedBox.shrink(),
                              getCurrProduct.extra10 == ""?
                              const Text(""):
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: const Color(0xF5FFB9F8),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    unselectedWidgetColor: Colors.pink,
                                    checkboxTheme: CheckboxThemeData(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  child: CheckboxListTile(
                                    title: Text(getCurrProduct.extra10+' :  +'+getCurrProduct.price10+' kr',style: TextStyle(
                                        color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.normal,letterSpacing: 2
                                    )),
                                    value: _isChecked10,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isChecked10 = value ?? false;
                                        _isChecked10 ? extrapric10=double.parse(getCurrProduct.price10) :
                                        extrapric10=0.0;
                                        // Use null-aware operator to set default value to false in case value is null
                                      });
                                    },
                                  ),
                                ),
                              ),
                              _isChecked10?
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  quantityControl(
                                    fct: () {
                                      if (_quantityExtra10Controller.text == '1') {
                                        return;
                                      } else {
                                        setState(() {
                                          _quantityExtra10Controller.text =
                                              (int.parse(_quantityExtra10Controller.text) - 1)
                                                  .toString();
                                        });
                                      }
                                    },
                                    icon: CupertinoIcons.minus,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(

                                    child: TextField(
                                      controller: _quantityExtra10Controller,
                                      key: const ValueKey('extra10'),
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
                                            _quantityExtra10Controller.text = '1';
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
                                        _quantityExtra10Controller.text =
                                            (int.parse(_quantityExtra10Controller.text) + 1)
                                                .toString();
                                      });
                                    },
                                    icon: CupertinoIcons.plus,
                                    color: Colors.green,
                                  ),
                                ],
                              ):SizedBox.shrink(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('drycker',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 22,
                          letterSpacing: 2,
                        )),
                      ],
                    ),
                    const SizedBox(height: 8,),
                    querySnapshot.docs.isNotEmpty
                        ? Container(
                          child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        querySnapshot.docs.first['drink1'] == ""?
                        const Text(""):
                        FractionallySizedBox(
                          widthFactor: 0.9, // 90% of the available width
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: const Color(0xF5FFB9F8),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.pink,
                                checkboxTheme: CheckboxThemeData(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              child:
                              CheckboxListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: FancyShimmerImage(
                                        imageUrl: querySnapshot.docs.first['imagedrink1'],
                                        height: 50,
                                        width: 50,
                                        boxFit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        querySnapshot.docs.first['drink1'] + ' : +' + querySnapshot.docs.first['price1'] + ' kr',
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.8),
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                value: _drinkChecked1,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _drinkChecked1 = value ?? false;
                                    _drinkChecked1 ? drinkpric1=double.parse(Drinkprice1) :
                                        drinkpric1=0.0;

                                    // Use null-aware operator to set default value to false in case value is null
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        _drinkChecked1?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            quantityControl(
                              fct: () {
                                if (_quantityDrink1Controller.text == '1') {
                                  return;
                                } else {
                                  setState(() {
                                    _quantityDrink1Controller.text =
                                        (int.parse(_quantityDrink1Controller.text) - 1)
                                            .toString();
                                  });
                                }
                              },
                              icon: CupertinoIcons.minus,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(

                              child: TextField(
                                controller: _quantityDrink1Controller,
                                key: const ValueKey('quantity1'),
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
                                      _quantityDrink1Controller.text = '1';
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
                                  _quantityDrink1Controller.text =
                                      (int.parse(_quantityDrink1Controller.text) + 1)
                                          .toString();
                                });
                              },
                              icon: CupertinoIcons.plus,
                              color: Colors.green,
                            ),
                          ],
                        ):SizedBox.shrink(),
                        querySnapshot.docs.first['drink2'] == ""?
                        const Text(""):
                        FractionallySizedBox(
                          widthFactor: 0.9, // 90% of the available width
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: const Color(0xF5FFB9F8),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.pink,
                                checkboxTheme: CheckboxThemeData(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              child:
                              CheckboxListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: FancyShimmerImage(
                                        imageUrl: querySnapshot.docs.first['imagedrink2'],
                                        height: 50,
                                        width: 50,
                                        boxFit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        querySnapshot.docs.first['drink2'] + ' : +' + querySnapshot.docs.first['price2'] + ' kr',
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.8),
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                value: _drinkChecked2,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _drinkChecked2 = value ?? false;
                                    _drinkChecked2 ? drinkpric2=double.parse(Drinkprice2) :
                                    drinkpric2=0.0;

                                    // Use null-aware operator to set default value to false in case value is null
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        _drinkChecked2?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            quantityControl(
                              fct: () {
                                if (_quantityDrink2Controller.text == '1') {
                                  return;
                                } else {
                                  setState(() {
                                    _quantityDrink2Controller.text =
                                        (int.parse(_quantityDrink2Controller.text) - 1)
                                            .toString();
                                  });
                                }
                              },
                              icon: CupertinoIcons.minus,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(

                              child: TextField(
                                controller: _quantityDrink2Controller,
                                key: const ValueKey('quantity2'),
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
                                      _quantityDrink2Controller.text = '1';
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
                                  _quantityDrink2Controller.text =
                                      (int.parse(_quantityDrink2Controller.text) + 1)
                                          .toString();
                                });
                              },
                              icon: CupertinoIcons.plus,
                              color: Colors.green,
                            ),
                          ],
                        ):SizedBox.shrink(),
                        querySnapshot.docs.first['drink3'] == ""?
                        const Text(""):
                        FractionallySizedBox(
                          widthFactor: 0.9, // 90% of the available width
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: const Color(0xF5FFB9F8),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.pink,
                                checkboxTheme: CheckboxThemeData(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              child:
                              CheckboxListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: FancyShimmerImage(
                                        imageUrl: querySnapshot.docs.first['imagedrink3'],
                                        height: 50,
                                        width: 50,
                                        boxFit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        querySnapshot.docs.first['drink3'] + ' : +' + querySnapshot.docs.first['price3'] + ' kr',
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.8),
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                value: _drinkChecked3,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _drinkChecked3 = value ?? false;
                                    _drinkChecked3 ? drinkpric3=double.parse(Drinkprice3) :
                                    drinkpric3=0.0;

                                    // Use null-aware operator to set default value to false in case value is null
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        _drinkChecked3?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            quantityControl(
                              fct: () {
                                if (_quantityDrink3Controller.text == '1') {
                                  return;
                                } else {
                                  setState(() {
                                    _quantityDrink3Controller.text =
                                        (int.parse(_quantityDrink3Controller.text) - 1)
                                            .toString();
                                  });
                                }
                              },
                              icon: CupertinoIcons.minus,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(

                              child: TextField(
                                controller: _quantityDrink3Controller,
                                key: const ValueKey('quantity3'),
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
                                      _quantityDrink3Controller.text = '1';
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
                                  _quantityDrink3Controller.text =
                                      (int.parse(_quantityDrink3Controller.text) + 1)
                                          .toString();
                                });
                              },
                              icon: CupertinoIcons.plus,
                              color: Colors.green,
                            ),
                          ],
                        ):SizedBox.shrink(),

                        querySnapshot.docs.first['drink4'] == ""?
                        const Text(""):
                        FractionallySizedBox(
                          widthFactor: 0.9, // 90% of the available width
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: const Color(0xF5FFB9F8),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.pink,
                                checkboxTheme: CheckboxThemeData(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              child:
                              CheckboxListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: FancyShimmerImage(
                                        imageUrl: querySnapshot.docs.first['imagedrink4'],
                                        height: 50,
                                        width: 50,
                                        boxFit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        querySnapshot.docs.first['drink4'] + ' : +' + querySnapshot.docs.first['price4'] + ' kr',
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.8),
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                value: _drinkChecked4,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _drinkChecked4 = value ?? false;
                                    _drinkChecked4 ? drinkpric4=double.parse(Drinkprice4) :
                                    drinkpric4=0.0;

                                    // Use null-aware operator to set default value to false in case value is null
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        _drinkChecked4?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            quantityControl(
                              fct: () {
                                if (_quantityDrink4Controller.text == '1') {
                                  return;
                                } else {
                                  setState(() {
                                    _quantityDrink4Controller.text =
                                        (int.parse(_quantityDrink4Controller.text) - 1)
                                            .toString();
                                  });
                                }
                              },
                              icon: CupertinoIcons.minus,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(

                              child: TextField(
                                controller: _quantityDrink4Controller,
                                key: const ValueKey('quantity4'),
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
                                      _quantityDrink4Controller.text = '1';
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
                                  _quantityDrink4Controller.text =
                                      (int.parse(_quantityDrink4Controller.text) + 1)
                                          .toString();
                                });
                              },
                              icon: CupertinoIcons.plus,
                              color: Colors.green,
                            ),
                          ],
                        ):SizedBox.shrink(),
                        querySnapshot.docs.first['drink5'] == ""?
                        const Text(""):
                        FractionallySizedBox(
                          widthFactor: 0.9, // 90% of the available width
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: const Color(0xF5FFB9F8),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.pink,
                                checkboxTheme: CheckboxThemeData(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              child:
                              CheckboxListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: FancyShimmerImage(
                                        imageUrl: querySnapshot.docs.first['imagedrink5'],
                                        height: 50,
                                        width: 50,
                                        boxFit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        querySnapshot.docs.first['drink5'] + ' : +' + querySnapshot.docs.first['price5'] + ' kr',
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.8),
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                value: _drinkChecked5,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _drinkChecked5 = value ?? false;
                                    _drinkChecked5 ? drinkpric5=double.parse(Drinkprice5) :
                                    drinkpric5=0.0;

                                    // Use null-aware operator to set default value to false in case value is null
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        _drinkChecked5?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            quantityControl(
                              fct: () {
                                if (_quantityDrink5Controller.text == '1') {
                                  return;
                                } else {
                                  setState(() {
                                    _quantityDrink5Controller.text =
                                        (int.parse(_quantityDrink5Controller.text) - 1)
                                            .toString();
                                  });
                                }
                              },
                              icon: CupertinoIcons.minus,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(

                              child: TextField(
                                controller: _quantityDrink5Controller,
                                key: const ValueKey('quantity5'),
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
                                      _quantityDrink5Controller.text = '1';
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
                                  _quantityDrink5Controller.text =
                                      (int.parse(_quantityDrink5Controller.text) + 1)
                                          .toString();
                                });
                              },
                              icon: CupertinoIcons.plus,
                              color: Colors.green,
                            ),
                          ],
                        ):SizedBox.shrink(),
                        querySnapshot.docs.first['drink6'] == ""?
                        const Text(""):
                        FractionallySizedBox(
                          widthFactor: 0.9, // 90% of the available width
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: const Color(0xF5FFB9F8),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.pink,
                                checkboxTheme: CheckboxThemeData(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              child:
                              CheckboxListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: FancyShimmerImage(
                                        imageUrl: querySnapshot.docs.first['imagedrink6'],
                                        height: 50,
                                        width: 50,
                                        boxFit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        querySnapshot.docs.first['drink6'] + ' : +' + querySnapshot.docs.first['price6'] + ' kr',
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.8),
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                value: _drinkChecked6,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _drinkChecked6 = value ?? false;
                                    _drinkChecked6 ? drinkpric6=double.parse(Drinkprice6) :
                                    drinkpric6=0.0;

                                    // Use null-aware operator to set default value to false in case value is null
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        _drinkChecked6?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            quantityControl(
                              fct: () {
                                if (_quantityDrink6Controller.text == '1') {
                                  return;
                                } else {
                                  setState(() {
                                    _quantityDrink6Controller.text =
                                        (int.parse(_quantityDrink6Controller.text) - 1)
                                            .toString();
                                  });
                                }
                              },
                              icon: CupertinoIcons.minus,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(

                              child: TextField(
                                controller: _quantityDrink6Controller,
                                key: const ValueKey('quantity6'),
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
                                      _quantityDrink6Controller.text = '1';
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
                                  _quantityDrink6Controller.text =
                                      (int.parse(_quantityDrink6Controller.text) + 1)
                                          .toString();
                                });
                              },
                              icon: CupertinoIcons.plus,
                              color: Colors.green,
                            ),
                          ],
                        ):SizedBox.shrink(),
                        querySnapshot.docs.first['drink7'] == ""?
                        const Text(""):
                        FractionallySizedBox(
                          widthFactor: 0.9, // 90% of the available width
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: const Color(0xF5FFB9F8),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.pink,
                                checkboxTheme: CheckboxThemeData(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              child:
                              CheckboxListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: FancyShimmerImage(
                                        imageUrl: querySnapshot.docs.first['imagedrink7'],
                                        height: 50,
                                        width: 50,
                                        boxFit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        querySnapshot.docs.first['drink7'] + ' : +' + querySnapshot.docs.first['price7'] + ' kr',
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.8),
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                value: _drinkChecked7,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _drinkChecked7 = value ?? false;
                                    _drinkChecked7 ? drinkpric7=double.parse(Drinkprice7) :
                                    drinkpric7=0.0;

                                    // Use null-aware operator to set default value to false in case value is null
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        _drinkChecked7?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            quantityControl(
                              fct: () {
                                if (_quantityDrink7Controller.text == '1') {
                                  return;
                                } else {
                                  setState(() {
                                    _quantityDrink7Controller.text =
                                        (int.parse(_quantityDrink7Controller.text) - 1)
                                            .toString();
                                  });
                                }
                              },
                              icon: CupertinoIcons.minus,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(

                              child: TextField(
                                controller: _quantityDrink7Controller,
                                key: const ValueKey('quantity7'),
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
                                      _quantityDrink7Controller.text = '1';
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
                                  _quantityDrink7Controller.text =
                                      (int.parse(_quantityDrink7Controller.text) + 1)
                                          .toString();
                                });
                              },
                              icon: CupertinoIcons.plus,
                              color: Colors.green,
                            ),
                          ],
                        ):SizedBox.shrink(),

                        querySnapshot.docs.first['drink8'] == ""?
                        const Text(""):
                        FractionallySizedBox(
                          widthFactor: 0.9, // 90% of the available width
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: const Color(0xF5FFB9F8),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.pink,
                                checkboxTheme: CheckboxThemeData(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              child:
                              CheckboxListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: FancyShimmerImage(
                                        imageUrl: querySnapshot.docs.first['imagedrink8'],
                                        height: 50,
                                        width: 50,
                                        boxFit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        querySnapshot.docs.first['drink8'] + ' : +' + querySnapshot.docs.first['price8'] + ' kr',
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.8),
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                value: _drinkChecked8,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _drinkChecked8 = value ?? false;
                                    _drinkChecked8 ? drinkpric1=double.parse(Drinkprice8) :
                                    drinkpric8=0.0;

                                    // Use null-aware operator to set default value to false in case value is null
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        _drinkChecked8?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            quantityControl(
                              fct: () {
                                if (_quantityDrink8Controller.text == '1') {
                                  return;
                                } else {
                                  setState(() {
                                    _quantityDrink8Controller.text =
                                        (int.parse(_quantityDrink8Controller.text) - 1)
                                            .toString();
                                  });
                                }
                              },
                              icon: CupertinoIcons.minus,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(

                              child: TextField(
                                controller: _quantityDrink8Controller,
                                key: const ValueKey('quantity8'),
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
                                      _quantityDrink8Controller.text = '1';
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
                                  _quantityDrink8Controller.text =
                                      (int.parse(_quantityDrink8Controller.text) + 1)
                                          .toString();
                                });
                              },
                              icon: CupertinoIcons.plus,
                              color: Colors.green,
                            ),
                          ],
                        ):SizedBox.shrink(),

                        querySnapshot.docs.first['drink9'] == ""?
                        const Text(""):
                        FractionallySizedBox(
                          widthFactor: 0.9, // 90% of the available width
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: const Color(0xF5FFB9F8),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.pink,
                                checkboxTheme: CheckboxThemeData(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              child:
                              CheckboxListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: FancyShimmerImage(
                                        imageUrl: querySnapshot.docs.first['imagedrink9'],
                                        height: 50,
                                        width: 50,
                                        boxFit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        querySnapshot.docs.first['drink9'] + ' : +' + querySnapshot.docs.first['price9'] + ' kr',
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.8),
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                value: _drinkChecked9,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _drinkChecked9 = value ?? false;
                                    _drinkChecked9? drinkpric9=double.parse(Drinkprice9) :
                                    drinkpric9=0.0;

                                    // Use null-aware operator to set default value to false in case value is null
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        _drinkChecked9?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            quantityControl(
                              fct: () {
                                if (_quantityDrink9Controller.text == '1') {
                                  return;
                                } else {
                                  setState(() {
                                    _quantityDrink9Controller.text =
                                        (int.parse(_quantityDrink9Controller.text) - 1)
                                            .toString();
                                  });
                                }
                              },
                              icon: CupertinoIcons.minus,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(

                              child: TextField(
                                controller: _quantityDrink9Controller,
                                key: const ValueKey('quantity9'),
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
                                      _quantityDrink9Controller.text = '1';
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
                                  _quantityDrink9Controller.text =
                                      (int.parse(_quantityDrink9Controller.text) + 1)
                                          .toString();
                                });
                              },
                              icon: CupertinoIcons.plus,
                              color: Colors.green,
                            ),
                          ],
                        ):SizedBox.shrink(),

                        querySnapshot.docs.first['drink10'] == ""?
                        const Text(""):
                        FractionallySizedBox(
                          widthFactor: 0.9, // 90% of the available width
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: const Color(0xF5FFB9F8),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.pink,
                                checkboxTheme: CheckboxThemeData(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              child:
                              CheckboxListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: FancyShimmerImage(
                                        imageUrl: querySnapshot.docs.first['imagedrink10'],
                                        height: 50,
                                        width: 50,
                                        boxFit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        querySnapshot.docs.first['drink10'] + ' : +' + querySnapshot.docs.first['price10'] + ' kr',
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.8),
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                value: _drinkChecked10,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _drinkChecked10 = value ?? false;
                                    _drinkChecked10 ? drinkpric1=double.parse(Drinkprice10) :
                                    drinkpric10=0.0;

                                    // Use null-aware operator to set default value to false in case value is null
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        _drinkChecked10?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            quantityControl(
                              fct: () {
                                if (_quantityDrink10Controller.text == '1') {
                                  return;
                                } else {
                                  setState(() {
                                    _quantityDrink10Controller.text =
                                        (int.parse(_quantityDrink10Controller.text) - 1)
                                            .toString();
                                  });
                                }
                              },
                              icon: CupertinoIcons.minus,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(

                              child: TextField(
                                controller: _quantityDrink10Controller,
                                key: const ValueKey('quantity10'),
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
                                      _quantityDrink10Controller.text = '1';
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
                                  _quantityDrink10Controller.text =
                                      (int.parse(_quantityDrink10Controller.text) + 1)
                                          .toString();
                                });
                              },
                              icon: CupertinoIcons.plus,
                              color: Colors.green,
                            ),
                          ],
                        ):SizedBox.shrink(),
                      ],
                    ),
                        )
                        : const Center(
                      //No Drinks found
                      child: Text('Inga drycker hittades.'),
                    ),

                            const SizedBox(
                      height: 45,
                    ),


                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 30),
                      decoration: BoxDecoration(
                        color: primary.withOpacity(0.9),
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
                                  color: Colors.white,
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
                                        color: Colors.white,
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
                    child: Builder(builder: (context) => InkWell(
                        onTap: _isInCart
                            ? null
                              :  firstItem=="1" || firstItem==getCurrProduct.productCategoryName?
                              () async {

                                  final User? user =
                                      authInstance.currentUser;

                                  if (user == null) {
                                    GlobalMethods.errorDialog(
                                        subtitle:
                                            //No user found, Please login first
                                            'Ingen användare hittades, logga in först',
                                        context: context);
                                    return;
                                  }
                                  await GlobalMethods.addToCart(
                                    extra1: _isChecked1  ?  _quantityExtra1Controller.text+" x "+ getCurrProduct.extra1+" : "+"("+(int.parse(_quantityExtra1Controller.text)*int.parse(getCurrProduct.price1)).toString()+ " Kr" +")":"",
                                      extra2: _isChecked2  ?  _quantityExtra2Controller.text+" x "+ getCurrProduct.extra2+" :"+"("+(int.parse(_quantityExtra2Controller.text)*int.parse(getCurrProduct.price2)).toString()+ " Kr" +")":"",
                                      extra3: _isChecked3  ?  _quantityExtra3Controller.text+" x "+ getCurrProduct.extra3+" : "+"("+(int.parse(_quantityExtra3Controller.text)*int.parse(getCurrProduct.price3)).toString()+ " Kr" +")":"",
                                      extra4: _isChecked4  ? _quantityExtra4Controller.text+" x "+ getCurrProduct.extra4+" : "+"("+(int.parse(_quantityExtra4Controller.text)*int.parse(getCurrProduct.price4)).toString()+ " Kr" +")":"",
                                      extra5: _isChecked5  ?  _quantityExtra5Controller.text+" x "+ getCurrProduct.extra5+" : "+"("+(int.parse(_quantityExtra5Controller.text)*int.parse(getCurrProduct.price5)).toString()+ " Kr"+")":"",
                                      extra6: _isChecked6  ?  _quantityExtra6Controller.text+" x "+ getCurrProduct.extra6+" : "+"("+(int.parse(_quantityExtra6Controller.text)*int.parse(getCurrProduct.price6)).toString()+ " Kr"+")" :"",
                                      extra7: _isChecked7  ?  _quantityExtra7Controller.text+" x "+ getCurrProduct.extra7+" : "+"("+(int.parse(_quantityExtra7Controller.text)*int.parse(getCurrProduct.price7)).toString()+ " Kr"+")" :"",
                                      extra8: _isChecked8  ?  _quantityExtra8Controller.text+" x "+ getCurrProduct.extra8+" : "+"("+(int.parse(_quantityExtra8Controller.text)*int.parse(getCurrProduct.price8)).toString()+ " Kr"+")" :"",
                                      extra9: _isChecked9  ?  _quantityExtra9Controller.text+" x "+ getCurrProduct.extra9+" : "+"("+(int.parse(_quantityExtra9Controller.text)*int.parse(getCurrProduct.price9)).toString()+ " Kr"+")" :"",
                                      extra10: _isChecked10  ?  _quantityExtra10Controller.text+" x "+ getCurrProduct.extra10+" : "+"("+(int.parse(_quantityExtra10Controller.text)*int.parse(getCurrProduct.price10)).toString()+ " Kr"+")" :"",
                                    drink1: _drinkChecked1 ? _quantityDrink1Controller.text+" x "+ querySnapshot.docs.first['drink1']+" : "+"("+(int.parse(_quantityDrink1Controller.text)*int.parse(Drinkprice1)).toString()+ " Kr"+")" :"",
                                      drink2: _drinkChecked2 ? _quantityDrink2Controller.text+" x "+ querySnapshot.docs.first['drink2']+" : "+"("+(int.parse(_quantityDrink2Controller.text)*int.parse(Drinkprice2)).toString()+ " Kr"+")" :"",
                                      drink3: _drinkChecked3 ? _quantityDrink3Controller.text+" x "+ querySnapshot.docs.first['drink3']+" : "+"("+(int.parse(_quantityDrink3Controller.text)*int.parse(Drinkprice3)).toString()+ " Kr"+")" :"",
                                      drink4: _drinkChecked4 ? _quantityDrink4Controller.text+" x "+ querySnapshot.docs.first['drink4']+" : "+"("+(int.parse(_quantityDrink4Controller.text)*int.parse(Drinkprice4)).toString()+ " Kr"+")" :"",
                                      drink5: _drinkChecked5 ? _quantityDrink5Controller.text+" x "+ querySnapshot.docs.first['drink5']+" : "+"("+(int.parse(_quantityDrink5Controller.text)*int.parse(Drinkprice5)).toString()+ " Kr"+")" :"",
                                      drink6: _drinkChecked6 ? _quantityDrink6Controller.text+" x "+ querySnapshot.docs.first['drink6']+" : "+"("+(int.parse(_quantityDrink6Controller.text)*int.parse(Drinkprice6)).toString()+ " Kr"+")" :"",
                                      drink7: _drinkChecked7 ? _quantityDrink7Controller.text+" x "+ querySnapshot.docs.first['drink7']+" : "+"("+(int.parse(_quantityDrink7Controller.text)*int.parse(Drinkprice7)).toString()+ " Kr"+")" :"",
                                      drink8: _drinkChecked8 ? _quantityDrink8Controller.text+" x "+ querySnapshot.docs.first['drink8']+" : "+"("+(int.parse(_quantityDrink8Controller.text)*int.parse(Drinkprice8)).toString()+ " Kr"+")" :"",
                                      drink9: _drinkChecked9 ? _quantityDrink9Controller.text+" x "+ querySnapshot.docs.first['drink9']+" : "+"("+(int.parse(_quantityDrink9Controller.text)*int.parse(Drinkprice9)).toString()+ " Kr"+")" :"",
                                      drink10: _drinkChecked10 ? _quantityDrink10Controller.text+" x "+ querySnapshot.docs.first['drink10']+" : "+"("+(int.parse(_quantityDrink10Controller.text)*int.parse(Drinkprice10)).toString()+ " Kr"+")" :"",
                                    totalPrice:totalPrice,
                                      productCategoryName:getCurrProduct.productCategoryName ,
                                      productId: getCurrProduct.id,
                                      details: "s",
                                      quantity: int.parse(
                                          _quantityTextController.text),
                                      context: context);

                                  await cartProvider.fetchCart();

                                  final userCollection = FirebaseFirestore.instance.collection('users');
                                  final DocumentSnapshot userDoc = await userCollection.doc(user!.uid).get();

                                    firstItem=userDoc.get('userCart')[0]['productCategoryName'];

                                  // cartProvider.addProductsToCart(
                                  //     productId: getCurrProduct.id,
                                  //     quantity: int.parse(
                                  //         _quantityTextController.text));
                                }:() {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                //you can order only from one resturant
                                title: Text("Du kan endast beställa från en restaurang"),
                                //one order one resturant
                                content: Text("en beställning en restaurang"),
                                actions: [
                                  TextButton(
                                    child: Text("Okej"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },


                                  borderRadius: BorderRadius.circular(10),
                                  child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: TextWidget(
                                          text:
                                              _isInCart ? 'I vagnen' : 'Lägg till i kundvagn',
                                          color: Colors.white,
                                          textSize: 18)),
                                ),
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

  }


