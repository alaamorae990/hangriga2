import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hangry/consts/theme_data.dart';
import 'package:provider/provider.dart';
import '../../providers/wishlist_provider.dart';
import '../../services/global_methods.dart';
import '../../services/utils.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/empty_screen.dart';
import '../../widgets/text_widget.dart';
import 'wishlist_widget.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = "/WishlistScreen";
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlistItemsList =
        wishlistProvider.getWishlistItems.values.toList().reversed.toList();
    return wishlistItemsList.isEmpty
        ? Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),),
          body: const EmptyScreen(
            //Your Wishlist Is Empty
              title: 'Din önskelista är tom',
              //Explore more and shortlist some items
              subtitle: 'Explore more and shortlist some items',
              imagePath: 'assets/images/wishlist.png',
              //Add a wish
              buttonText: 'Lägg till en önskan',
            ),
        )
        : Scaffold(
            appBar: AppBar(
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title: TextWidget(
                  text: 'önskelista (${wishlistItemsList.length})',
                  color: color,
                  isTitle: true,
                  textSize: 22,
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      GlobalMethods.warningDialog(
                        //Empty your wishlist?
                          title: 'Töm din önskelista?',
                          subtitle: 'Are you sure?',
                          fct: () async {
                            await wishlistProvider.clearOnlineWishlist();
                            wishlistProvider.clearLocalWishlist();
                          },
                          context: context);
                    },
                    icon: Icon(
                      IconlyBroken.delete,
                      color: color,
                    ),
                  ),
                ]),
            body: MasonryGridView.count(
              itemCount: wishlistItemsList.length,
              crossAxisCount: 2,
              // mainAxisSpacing: 16,
              // crossAxisSpacing: 20,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                    value: wishlistItemsList[index],
                    child: const WishlistWidget());
              },
            ));
  }
}
