import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hangry/consts/theme_data.dart';

import 'package:provider/provider.dart';

import '../../providers/viewed_prod_provider.dart';
import '../../services/global_methods.dart';
import '../../services/utils.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/empty_screen.dart';
import '../../widgets/text_widget.dart';
import 'viewed_widget.dart';

class ViewedRecentlyScreen extends StatefulWidget {
  static const routeName = '/ViewedRecentlyScreen';

  const ViewedRecentlyScreen({Key? key}) : super(key: key);

  @override
  _ViewedRecentlyScreenState createState() => _ViewedRecentlyScreenState();
}

class _ViewedRecentlyScreenState extends State<ViewedRecentlyScreen> {
  bool check = true;
  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).color;

    // Size size = Utils(context).getScreenSize;
    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    final viewedProdItemsList = viewedProdProvider.getViewedProdlistItems.values
        .toList()
        .reversed
        .toList();
    if (viewedProdItemsList.isEmpty) {
      return Scaffold(
        appBar: AppBar(

          leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
          backgroundColor: primary,
        ),
        body: const EmptyScreen(
          //Your history is empty
          title: 'Din historik är tom',
          //No order has been viewed yet!
          subtitle: 'Ingen beställning har visats ännu!',
          //Shop now
          buttonText: 'Shoppa nu',
          imagePath: 'assets/images/history.png',
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                GlobalMethods.warningDialog(
                  //Empty your history?
                    title: 'Töm din historia?',
                    //Are you sure?
                    subtitle: 'Är du säker?',
                    fct: () {

                     viewedProdProvider.clearHistory();
                    },
                    context: context);
              },
              icon: Icon(
                IconlyBroken.delete,
                color: color,
              ),
            )
          ],
          leading: const BackWidget(),
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          title: TextWidget(
            //History
            text: 'Historia',
            color: color,
            textSize: 24.0,
          ),
          backgroundColor:
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
        ),
        body: ListView.builder(
            itemCount: viewedProdItemsList.length,
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                child: ChangeNotifierProvider.value(
                    value: viewedProdItemsList[index],
                    child: ViewedRecentlyWidget()),
              );
            }),
      );
    }
  }
}
