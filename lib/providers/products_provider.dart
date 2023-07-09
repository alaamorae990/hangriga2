import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hangry/models/tax_model.dart';

import '../models/images_home_screen.dart';
import '../models/orders_model.dart';
import '../models/products_model.dart';
import '../models/res_model.dart';

class ProductsProvider with ChangeNotifier {
  static List<ResModel> _resturantsList = [];
  static List<ProductModel> _productsList = [];
  static List<OrderModel> _orderList = [];
  static List<TaxModel> _TaxList = [];
  static List<HomeImages> _imagesList = [];

  List<HomeImages> get getImagesHome {
    return _imagesList;
  }

  List<TaxModel> get getTax {
    return _TaxList;
  }

  List<OrderModel> get getorder {
    return _orderList;
  }

  List<ProductModel> get getProducts {
    return _productsList;
  }

  List<ResModel> get getResturants {
    return _resturantsList;
  }

  List<ProductModel> get getOnSaleProducts {
    return _productsList.where((element) => element.isOnSale).toList();
  }

  List<ResModel> get getOnSaleRes {
    return _resturantsList.where((element) => element.isOnSale).toList();
  }

  Future<void> fetchImagesHome() async {
    await FirebaseFirestore.instance
        .collection('images')
        .get()
        .then((QuerySnapshot HomeImagesSnapshot) {
      _imagesList = [];
      HomeImagesSnapshot.docs.forEach((element) {
        _imagesList.insert(
            0,
            HomeImages(
              image1:  element.get('image1'),
              image2:  element.get('image2'),
              image3: element.get('image3'),
              image4: element.get('image4'),
              image5: element.get('image5'),
              image6: element.get('image6'),
              image7: element.get('image7'),
              image8:element.get('image8'),
              image9: element.get('image9'),


            ));
      });
    });
    notifyListeners();
  }

  Future<void> fetchOrder() async {
    await FirebaseFirestore.instance
        .collection('orders')
        .get()
        .then((QuerySnapshot resturantSnapshot) {
      _orderList = [];
      resturantSnapshot.docs.forEach((element) {
        _orderList.insert(
            0,
            OrderModel(
                imageUrl:  element.get('imageUrl'),
                lati:  element.get('latitude'),
                long:  element.get('longitude'),
                orderDate:  element.get('orderDate'),
                orderId:  element.get('orderId'),
                price:  element.get('price'),
                productId:  element.get('productId'),
                quantity:  element.get('quantity'),
                userId:  element.get('userId'),
                userName:  element.get('userName'),
                ));
      });
    });
    notifyListeners();
  }

  Future<void> fetchTax() async {
    await FirebaseFirestore.instance
        .collection('driverTax')
        .get()
        .then((QuerySnapshot resturantSnapshot) {
      _TaxList = [];
      resturantSnapshot.docs.forEach((element) {
        _TaxList.insert(
            0,
            TaxModel(
              tax: element.get('Tax'),
              deliveryValue: element.get('deliveryValue'),
            ));
      });
    });
    notifyListeners();
  }

  Future<void> fetchResturant() async {
    await FirebaseFirestore.instance
        .collection('resturants')
        .get()
        .then((QuerySnapshot resturantSnapshot) {
      _resturantsList = [];
      resturantSnapshot.docs.forEach((element) {
        _resturantsList.insert(
            0,
            ResModel(
              startTime: element.get('StartTime'),
              endTime: element.get('EndTime'),
              title: element.get('title'),
              imageUrl: element.get('imageUrl'),
              isOnSale: element.get('isOnSale'),
              delievryCost: element.get('delievryCost'),
              hourTime: element.get('hourTime'),
              rankStar: element.get('rankStar'),
              drink1: element.get('drink1'),
              drink2: element.get('drink2'),
              drink3: element.get('drink3'),
              drink4: element.get('drink4'),
              drink5: element.get('drink5'),
              drink6: element.get('drink6'),
              drink7: element.get('drink7'),
              drink8: element.get('drink8'),
              drink9: element.get('drink9'),
              drink10: element.get('drink10'),
              price1: element.get('price1'),
              price2: element.get('price2'),
              price3: element.get('price3'),
              price4: element.get('price4'),
              price5: element.get('price5'),
              price6: element.get('price6'),
              price7: element.get('price7'),
              price8: element.get('price8'),
              price9: element.get('price9'),
              price10: element.get('price10'),
              imagedrink1: element.get('imagedrink1'),
              imagedrink2: element.get('imagedrink2'),
              imagedrink3: element.get('imagedrink3'),
              imagedrink4: element.get('imagedrink4'),
              imagedrink5: element.get('imagedrink5'),
              imagedrink6: element.get('imagedrink6'),
              imagedrink7: element.get('imagedrink7'),
              imagedrink8: element.get('imagedrink8'),
              imagedrink9: element.get('imagedrink9'),
              imagedrink10: element.get('imagedrink10'),

            ));
      });
    });
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot productSnapshot) {
      _productsList = [];
      // _productsList.clear();
      productSnapshot.docs.forEach((element) {
        _productsList.insert(
            0,
            ProductModel(
              id: element.get('id'),
              title: element.get('title'),
              imageUrl: element.get('imageUrl'),
              productCategoryName: element.get('productCategoryName'),
              price: double.parse(
                element.get('price'),
              ),
              salePrice: element.get('salePrice'),
              isOnSale: element.get('isOnSale'),
              isPiece: element.get('isPiece'),
              detiles: element.get("title"),
              extra1:element.get("extra1"),
              extra2:element.get("extra2"),
              extra3:element.get("extra3"),
              extra4:element.get("extra4"),
              extra5:element.get("extra5"),
              extra6:element.get("extra6"),
              extra7:element.get("extra7"),
              extra8:element.get("extra8"),
              extra9:element.get("extra9"),
              extra10:element.get("extra10"),
              price1: element.get("price1"),
              price2: element.get("price2"),
              price3: element.get("price3"),
              price4: element.get("price4"),
              price5: element.get("price5"),
              price6: element.get("price6"),
              price7: element.get("price7"),
              price8: element.get("price8"),
              price9: element.get("price9"),
              price10: element.get("price10"),

            ));
      });
    });
    notifyListeners();
  }

  ProductModel findProdById(String productId) {
    return _productsList.firstWhere((element) => element.id == productId);
  }
  List<ResModel> findDrinkByCategory(String categoryName) {
    List<ResModel> _category3List = _resturantsList
        .where((element) => element.title
        .toLowerCase()
        .contains(categoryName.toLowerCase()))
        .toList();
    return _category3List;
  }
  List<ProductModel> findByCategory(String categoryName) {
    List<ProductModel> _categoryList = _productsList
        .where((element) => element.productCategoryName
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();
    return _categoryList;
  }

  List<ProductModel> searchQuery(String searchText) {
    List<ProductModel> _searchList = _productsList
        .where(
          (element) => element.title.toLowerCase().contains(
                searchText.toLowerCase(),
              ),
        )
        .toList();
    return _searchList;
  }
}
