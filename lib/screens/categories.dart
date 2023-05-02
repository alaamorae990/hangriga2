import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../consts/theme_data.dart';
import '../inner_screens/cat_screen.dart';
import '../models/res_model.dart';
import '../services/global_methods.dart';
import '../services/utils.dart';
import '../widgets/categories_widget.dart';
import '../widgets/text_widget.dart';


class CategoriesScreen extends StatefulWidget {
    static const routeName = "/CategoriesScreen";
   CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final utils = Utils(context);
    Color color = utils.color;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: primary,
          
          title: const Text("Restaurants",style: TextStyle(
          fontWeight: FontWeight.bold,color: Colors.white)),
        ),
        body: StreamBuilder<QuerySnapshot>(
           stream: FirebaseFirestore.instance.collection('resturants').snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                          var data = snapshots.data!.docs[index].data()
                          as Map<String, dynamic>;
                          return
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                height: MediaQuery.of(context).size.width * 0.7,
                child: InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, CategoryScreen.routeName,
                        arguments: data['title']);
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,

                        height: MediaQuery.of(context).size.width * 0.7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, 15),
                                blurRadius: 25,
                                color: Colors.black12),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Stack(
                              children: [
                                FractionallySizedBox(
                                  widthFactor: 1.0,
                                  heightFactor: 1.6,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.3),
                                        BlendMode.darken,
                                      ),
                                      child: Image.network(
                                        snapshots.data!.docs[index]['imageUrl'],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Center(
                                    child: Text(
                                      snapshots.data!.docs[index]['hourTime'],
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 22,),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  Flexible(
                                    flex: 10,
                                    child: Text(snapshots.data!.docs[index]['title'],
                                      maxLines:2, // set the maximum number of lines
                                      overflow: TextOverflow.visible,
                                      textAlign: TextAlign.start,
                                    style: TextStyle(fontSize:MediaQuery.of(context).size.width * 0.06,
                                        color:color,
fontWeight: FontWeight.bold,
                                    ),
                                    ),
                                  ),

                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.star, color: Colors.yellow),
                                        onPressed: () {
                                          // add your logic here
                                        },
                                        tooltip: 'Add',

                                      ),
                                      Text(snapshots.data!.docs[index]['rankStar']),

                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ),
                          // TextWidget(
                          //   text: snapshots.data!.docs[index]['title'],
                          //   textSize: MediaQuery.of(context).size.width * 0.06,
                          //   color: Colors.black,
                          //   isTitle: true,
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.motorcycle_rounded),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextWidget(
                                    text: snapshots.data!.docs[index]['delievryCost']+' Kr',
                                    textSize: MediaQuery.of(context).size.width * 0.06,
                                    color: Colors.black,
                                    isTitle: false,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 50,)
                        ],
                      ),
                    ],
                  ),
                ),
              );



                  }
                );
          }
        )
        
        );
  }
}
