import 'package:badges/badges.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:provider/provider.dart';

import '../consts/contss.dart';
import '../consts/theme_data.dart';
import '../inner_screens/drawer_screen.dart';
import '../inner_screens/feeds_screen.dart';
import '../inner_screens/on_sale_screen.dart';
import '../inner_screens/search_screen.dart';
import '../models/products_model.dart';
import '../models/res_model.dart';
import '../providers/cart_provider.dart';
import '../providers/products_provider.dart';
import '../services/global_methods.dart';
import '../services/utils.dart';
import '../widgets/empty_products_widget.dart';
import '../widgets/feed_items.dart';
import '../widgets/on_sale_res_widget.dart';
import '../widgets/on_sale_widget.dart';
import '../widgets/text_widget.dart';
import 'cart/cart_screen.dart';
import 'categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController? _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  String searchQuery = '';
  @override
  void dispose() {
    _searchTextController!.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }
  List<ProductModel> listProdcutSearch = [];

  void nextPage(){

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultPage(searchQuery: searchQuery),
      ),
    );
    return ;
  }
  @override
  Widget build(BuildContext context) {


    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    final Color color = Utils(context).color;
    Size size = utils.getScreenSize;
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productProviders.getProducts;

    List<ProductModel> productsOnSale = productProviders.getOnSaleProducts;
    List<ResModel> resOnSale = productProviders.getOnSaleRes;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: (){}, icon: Icon(
              Icons.fastfood,
              size: 30,
              color: Colors.white,
            ),),
            // Icon(
            //   Icons.fastfood,
            //   size: 30,
            //   color: Colors.white,
            // ),
            const Text("H U N G R I G A",style: TextStyle(
              fontWeight: FontWeight.bold
            )),
          ],
        ),
        backgroundColor: primary,
        elevation: 0.0,

        actions: [

          IconButton(
            icon:Consumer<CartProvider>(builder: (_, myCart, ch) {

            return Badge(
            toAnimate: true,
            shape: BadgeShape.circle,
            badgeColor: Colors.green,
            borderRadius: BorderRadius.circular(8),
            position: BadgePosition.topEnd(top: -7, end: -7),
            badgeContent: FittedBox(
            child: TextWidget(
            text: myCart.getCartItems.length.toString(),
            color: Colors.white,
            textSize: 14)),
            child: Icon(
           IconlyBold.buy ),);
            }),

            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ),
              );
            },
          ),
        ],
      ),
      drawer:
      Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: primary,
              ),
              accountName: Text(
                'H U N G R I G A',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              accountEmail: null,
              currentAccountPicture: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/logo.jpeg',
                  width: 120, // Adjust the width as per your requirement
                  height: 120, // Adjust the height as per your requirement
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              //Complaints and suggestions
              title: Text('Klagomål och förslag'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComplaintsPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),

        body: SingleChildScrollView(
        child: Column(

          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomRight: Radius.circular(8),bottomLeft:Radius.circular(8) ),
                color: primary,
              ),
              // color: primary,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: kBottomNavigationBarHeight,
                  child:
                  TextField(


                    focusNode: _searchTextFocusNode,
                    style: TextStyle(color: Colors.grey),
                    onEditingComplete:(){
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchResultPage(searchQuery: searchQuery),
                      ),
                    );
                      },
                    controller: _searchTextController,
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(1),
                        borderSide:
                        const BorderSide(color: Colors.grey, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60),
                        borderSide:
                        const BorderSide(color: Colors.grey, width: 1),
                      ),
                      //What's in your mind
                      hintText: "vad tänker du på",

                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.search,color: Colors.grey),
                      suffix: IconButton(
                        onPressed: () {
                          _searchTextController!.clear();
                          _searchTextFocusNode.unfocus();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchResultPage(searchQuery: searchQuery),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.arrow_forward,
                          color: _searchTextFocusNode.hasFocus ? Colors.green : Colors.yellow,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),

            Container(
              height: 250,
              color: Colors.white,// set the height of the container as per your requirement
              child: Row(
                children: [
                  // Vertical image on the left
                  Container(
                    margin: EdgeInsets.all(5.0),
                    width: 100.0,
                    height: double.infinity,// set the width of the container as per your requirement
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        'assets/images/11.jpeg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  // Two square images on the right
                  Expanded(

                    child: Column(
                      children: [
                        Flexible(
                          flex: 4,
                          child: Container(

                            margin: EdgeInsets.all(5.0),
                            width: double.infinity,// add margin as per your requirement
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset(
                                'assets/images/8.jpeg',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex:1,
                          child: Container(
                            margin: EdgeInsets.all(5.0),
                            width: double.infinity,// add margin as per your requirement
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Image.asset(
                                'assets/images/9.jpeg',
                                fit: BoxFit.cover,
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
            Container(
              color: Colors.white.withOpacity(0.8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:   Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("Dina dagliga erbjudandem",
                          textAlign: TextAlign.start,

                          style: TextStyle(
                              fontWeight: FontWeight.bold,fontSize: 20
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),

            SizedBox(
              height: size.height * 0.38,

              child: Container(
                color:  Colors.white.withOpacity(0.8),
                child: Swiper(

                  itemBuilder: (BuildContext context, int index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.asset(
                        Constss.offerImages[index],
                        fit: BoxFit.cover,


                      ),
                    );
                  },
                  autoplay: true,
                  itemCount: Constss.offerImages.length,
                  pagination: const SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: DotSwiperPaginationBuilder(
                          color: Colors.white, activeColor: Colors.red)),
                  // control: const SwiperControl(color: Colors.black),
                ),
              ),
            ),
            // const SizedBox(
            //   height: 6,
            // ),
            // TextButton(
            //   onPressed: () {
            //     GlobalMethods.navigateTo(
            //         ctx: context, routeName: OnSaleScreen.routeName);
            //   },
            //   child: TextWidget(
            //     text: 'View all',
            //     maxLines: 1,
            //     color:const Color(0Xff900C3F),
            //     textSize: 20,
            //   ),
            // ),
            // const SizedBox(
            //   height: 6,
            // ),
            // Row(
            //   children: [
            //     RotatedBox(
            //       quarterTurns: -1,
            //       child: Row(
            //         children: [
            //           TextWidget(
            //             text: 'On sale'.toUpperCase(),
            //             color: primary,
            //             textSize: 22,
            //             isTitle: true,
            //           ),
            //           const SizedBox(
            //             width: 5,
            //           ),
            //           const Icon(
            //             IconlyLight.discount,
            //             color: primary,
            //           ),
            //         ],
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 8,
            //     ),
            //     Flexible(
            //       flex: 2,
            //       child: SizedBox(
            //         height: size.height * 0.33,
            //         child: ListView.builder(
            //             itemCount: productsOnSale.length < 10
            //                 ? productsOnSale.length
            //                 : 10,
            //             scrollDirection: Axis.horizontal,
            //             itemBuilder: (ctx, index) {
            //               return ChangeNotifierProvider.value(
            //                   value: productsOnSale[index],
            //                   child: const OnSaleWidget());
            //             }),
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: 'Restauranger ',
                    color: color.withOpacity(0.7),
                    textSize: 22,
                    isTitle: true,
                  ),
                  // const Spacer(),
                  TextButton(
                    onPressed: () {
                      GlobalMethods.navigateTo(
                          ctx: context, routeName: CategoriesScreen.routeName);
                    },
                    child: TextWidget(
                      //Browse all
                      text: 'Bläddra bland alla',
                      maxLines: 1,
                      color: primary,
                      textSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 1,
               padding: EdgeInsets.zero,
               crossAxisSpacing: 3,
              childAspectRatio: size.width / (size.height * 0.44),
              children: List.generate(
                  resOnSale.length < 4
                      ? resOnSale.length // length 3
                      : 4, (index) {
                return ChangeNotifierProvider.value(
                  value: resOnSale[index],
                  child: const OnSaleResWidget(),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
