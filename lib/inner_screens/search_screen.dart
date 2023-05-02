import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hangry/consts/theme_data.dart';
import 'package:hangry/inner_screens/product_details.dart';
import 'package:provider/provider.dart';

import '../consts/firebase_consts.dart';
import '../models/products_model.dart';
import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';
import '../services/global_methods.dart';
import '../services/utils.dart';
import '../widgets/heart_btn.dart';
import '../widgets/price_widget.dart';
import '../widgets/text_widget.dart';
class SearchResultPage extends StatelessWidget {
  final String searchQuery;

  const SearchResultPage({required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    // final productModel = Provider.of<ProductModel>(context);
    final Color color = Utils(context).color;
    final cartProvider = Provider.of<CartProvider>(context);
    // bool? _isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    Size size = Utils(context).getScreenSize;
    // final wishlistProvider = Provider.of<WishlistProvider>(context);
    // bool? _isInWishlist =
    // wishlistProvider.getWishlistItems.containsKey(productModel.id);
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
        backgroundColor: primary,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('products')
            .where('title', isGreaterThanOrEqualTo: searchQuery)
            .where('title', isLessThan: searchQuery + 'z')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('An error occurred while loading search results.'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final querySnapshot = snapshot.data!;

          if (querySnapshot.size == 0) {
            return Center(
              child: Text('No search results found.'),
            );
          }

          return ListView.builder(
            itemCount: querySnapshot.docs.length,
            itemBuilder: (context, index) {
              final product = querySnapshot.docs[index].data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: GestureDetector(

                  onTap: () {
                    // Navigate to the details page
                    Navigator.pushNamed(context, ProductDetails.routeName,
                        arguments:product['id']);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          product['imageUrl'],
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        product['title'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(thickness: 2,color: primary,)
                    ],
                  ),
                ),
              );

            },
          );

        },
      ),
    );
  }
}
