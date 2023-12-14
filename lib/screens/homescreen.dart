import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manjha/helper.dart';
import 'package:manjha/screens/cartscreens/detailsscreen.dart';
import 'package:manjha/const.dart';
import 'package:manjha/widget/vegetable_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              color: backgroundcolor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined),
                            SizedBox(
                              width: 5,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Current Location",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "Surat, Gujarat",
                                  style: TextStyle(
                                      color: Color(0xff979899),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          ],
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.add_alert_outlined))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: [
                          Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Icon(Icons.menu),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: TextField(
                                scrollPadding: EdgeInsets.zero,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1),
                                      borderRadius: BorderRadius.circular(4)),
                                  hintText: "Search Product",
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xff979899),
                                      fontWeight: FontWeight.w500),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                  prefixIcon: Icon(
                                    CupertinoIcons.search,
                                    color: Color(0xff23AA49),
                                  ),
                                )),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Icon(Icons.sort),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Image.asset(
                        "assets/images/banner.png",
                        scale: 4.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _seeAllView(context, "Categories"),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      _categoriesView("assets/images/fruits.png", "Fruits"),
                      _categoriesView(
                          "assets/images/vegetables.png", "Vegetables"),
                      _categoriesView("assets/images/diary.png", "Diary"),
                      _categoriesView("assets/images/meat.png", "Meat")
                    ],
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  _seeAllView(context, "Best Selling"),
                  SizedBox(
                    height: 24,
                  ),
                  Wrap(
                    children: List.generate(6, (index) => vegitablecard()).toList(),
                  )
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Expanded(
                  //       child: VegetableCardWidget(
                  //         imagePath: "assets/images/bell_pepper_red.png",
                  //         name: "Bell Peppe",
                  //         price: "1kg, 4\$",
                  //         onTapCallback: () {},
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: VegetableCardWidget(
                  //           imagePath: "assets/images/lamb_meat.png",
                  //           name: "Bell Pepper",
                  //           price: "1kg, 4\$",
                  //           onTapCallback: () {}),
                  //     ),
                  //     Expanded(
                  //       child: VegetableCardWidget(
                  //           imagePath: "assets/images/lamb_meat.png",
                  //           name: "Bell Pepper",
                  //           price: "1kg, 4\$",
                  //           onTapCallback: () {}),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 2,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Expanded(
                  //       child: VegetableCardWidget(
                  //         imagePath: "assets/images/bell_pepper_red.png",
                  //         name: "Bell Peppe",
                  //         price: "1kg, 4\$",
                  //         onTapCallback: () {
                  //
                  //         },
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: VegetableCardWidget(
                  //           imagePath: "assets/images/lamb_meat.png",
                  //           name: "Bell Pepper",
                  //           price: "1kg, 4\$",
                  //           onTapCallback: () {}),
                  //     ),
                  //     Expanded(
                  //       child: VegetableCardWidget(
                  //           imagePath: "assets/images/lamb_meat.png",
                  //           name: "Bell Pepper",
                  //           price: "1kg, 4\$",
                  //           onTapCallback: () {}),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _seeAllView(BuildContext context, String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: () {
            // Navigator.pushNamed(context, MyRoutes.vegetablesRoute);
          },
          child: Text(
            "See All",
            style: TextStyle(
                fontSize: 14,
                color: Color(0xff23AA49),
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _categoriesView(String imagePath, String catName) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Color(0xffF3F5F7),
            radius: 32,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                imagePath,
                scale: 4.0,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            catName,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
          )
        ],
      ),
    );
  }


  Widget vegitablecard(){
    return      Container(
      width: screenwidth(context,dividedby: 3.3),
      child: VegetableCardWidget(
          imagePath: "assets/images/lamb_meat.png",
          name: "Bell Pepper",
          price: "1kg, 4\$",
          onTapCallback: () {}),
    );
  }
}
