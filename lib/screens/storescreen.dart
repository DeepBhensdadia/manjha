import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:manjha/getxcontrollers/productcontroller.dart';
import 'package:manjha/getxcontrollers/storescreencontroller.dart';

import 'package:manjha/helper.dart';
import 'package:manjha/model/getstorebannerresponse.dart';
import 'package:manjha/model/productresponse.dart';
import 'package:manjha/screens/Product/productcategoryscreen.dart';
import 'package:manjha/screens/Product/productdetailsscreen.dart';
import 'package:manjha/const.dart';
import 'package:manjha/widget/textstyle.dart';
import 'package:manjha/widget/vegetable_card.dart';
import 'package:shimmer/shimmer.dart';

import 'Product/productlistingpage.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen>
    with SingleTickerProviderStateMixin {
  StoreScreenController storecontroller = Get.put(StoreScreenController());
  ProductController _productController = Get.put(ProductController());

  void fetchData() {
    if (!_productController.testingproduct.value) {
      _productController.testingproductApiCall(
        categoryid: "3",
      );
      log("data fatch testing");
      _productController.testingproduct.value = true;
    } else if (!_productController.fishfeedproduct.value) {
      _productController.fishproductApiCall(
        categoryid: "5",
      );
      log("data fishfeed testing");
      _productController.fishfeedproduct.value = true;
    } else if (!_productController.shrimpyfeedproduct.value) {
      _productController.shimpyproductApiCall(
        categoryid: "6",
      );
      log("data shrimpy testing");
      _productController.shrimpyfeedproduct.value = true;
    } else if (!_productController.equipmentproduct.value) {
      _productController.equipmentproductApiCall(
        categoryid: "4",
      );
      log("data equipment testing");
      _productController.equipmentproduct.value = true;
    } else {
      print("no data found");
    }
  }

  @override
  void initState() {
    if (storecontroller.getbannerapi.isFalse) {
      storecontroller.getbanner();
      _productController.helthcareproductApiCall(
        categoryid: "2",
      );
    }
    // TODO: implement initState
    super.initState();
  }

  int _current = 0;
  final _controller = PageController(
    initialPage: 0,
    viewportFraction: 1,
    keepPage: true,
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: LazyLoadScrollView(
          onEndOfPage: () {
            fetchData();
          },
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                // color: cartbackgroundcolor,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined),
                              const SizedBox(
                                width: 5,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
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
                              icon: const Icon(Icons.person_outline_sharp))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextField(
                            scrollPadding: EdgeInsets.zero,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 1),
                                  borderRadius: BorderRadius.circular(4)),
                              hintText: "Search Product",
                              hintStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff979899),
                                  fontWeight: FontWeight.w500),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              prefixIcon: const Icon(
                                CupertinoIcons.search,
                                color: Color(0xff23AA49),
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Obx(() => storecontroller.getbannerapi.isTrue
                                ? Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                        CarouselSlider(
                                          items: storecontroller.listbanners
                                              .map((banner) => GestureDetector(
                                                    onTap: () {
                                                      Get.to(ProductDetailScreen(
                                                          product:
                                                              banner.product ??
                                                                  Product()));
                                                    },
                                                    child: CachedNetworkImage(
                                                      width: double.infinity,
                                                      fadeInCurve:
                                                          Curves.bounceIn,
                                                      imageUrl:
                                                          banner.imageUrl!,
                                                      placeholder: (context,
                                                              url) =>
                                                          Image.asset(
                                                              'assets/no-photo.png'),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Image.asset(
                                                              'assets/no-photo.png'),
                                                    ),
                                                  ))
                                              .toList(),
                                          options: CarouselOptions(
                                              //       options: CarouselOptions(
                                              height: 150,
                                              enlargeCenterPage: true,
                                              enableInfiniteScroll: true,
                                              enlargeFactor: 0,
                                              viewportFraction: 1,
                                              enlargeStrategy:
                                                  CenterPageEnlargeStrategy
                                                      .zoom,
                                              autoPlay: true,
                                              onPageChanged: (index, reason) {
                                                setState(() {
                                                  _current = index;
                                                });
                                              }),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: storecontroller
                                                .listbanners
                                                .map((banner) {
                                              int index = storecontroller
                                                  .listbanners
                                                  .indexOf(banner);
                                              return Container(
                                                width: 6.0,
                                                height: 6.0,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 2.0),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: _current == index
                                                      ? const Color.fromRGBO(
                                                          0, 0, 0, 0.9)
                                                      : const Color.fromRGBO(
                                                          0, 0, 0, 0.4),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ])
                                : Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(
                                      height: 150,
                                      width: double.infinity,
                                      color: Colors.grey.shade300,
                                    ),
                                  )

                            // Image.asset(
                            //   "assets/images/banner.png",
                            //   scale: 4.0,
                            // ),
                            ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Categories",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              _controller.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.ease);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.black,
                            )),
                        IconButton(
                            onPressed: () {
                              _controller.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.ease);
                            },
                            icon: const Icon(Icons.arrow_forward_ios_rounded,
                                color: Colors.black)),
                      ],
                    )
                  ],
                ),
              ),
              Obx(
                () => storecontroller.getcategoriesapi.isFalse
                    ? Container(
                        height: 100,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                              4,
                              (index) => Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  height: 80,
                                  width: screenwidth(context, dividedby: 5),
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ).toList()),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              child: PageView(
                                // reverse: true,
                                physics: const NeverScrollableScrollPhysics(),
                                controller: _controller,
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Row(
                                      children: List.generate(
                                    4,
                                    (index) => _categoriesView(
                                        storecontroller
                                            .listcategory[index].imageUrl!,
                                        storecontroller.listcategory[index]
                                                .categoryName ??
                                            "", () {
                                      if (storecontroller
                                              .listcategory[index].id !=
                                          1) {
                                        Get.to(
                                          ProductListingPage(
                                            categoryid: storecontroller
                                                .listcategory[index].id
                                                .toString(),
                                            categoryname: storecontroller
                                                .listcategory[index]
                                                .categoryName
                                                .toString(),
                                          ),
                                        );
                                      } else {
                                        Get.to(StoreCategoryPage(storecontroller
                                            .listcategory[index]));
                                      }
                                    }),
                                  ).toList()),
                                  Row(
                                      children: List.generate(
                                    4,
                                    (index) => _categoriesView(
                                        storecontroller
                                            .listcategory[index].imageUrl!,
                                        storecontroller.listcategory[index]
                                                .categoryName ??
                                            "",
                                        () {}),
                                  ).toList()),
                                ],
                              ),
                            ),

                            // Wrap(
                            //   children:
                            //   List.generate(6, (index) => vegitablecard()).toList(),
                            // )
                          ],
                        ),
                      ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      "Brands".tr,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => storecontroller.getbarandapi.isFalse
                    ? Container(
                        height: 150,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                              3,
                              (index) => Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  height: 150,
                                  width: screenwidth(context, dividedby: 3.5),
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ).toList()),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  // border: Border.all(width: 0, color: kheader),

                                  // color: kgreyFill,
                                  ),
                              height: 150.0,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  // primary: true,
                                  // padding: EdgeInsets.all(8),
                                  // physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  // gridDelegate:
                                  //     const SliverGridDelegateWithFixedCrossAxisCount(
                                  //   crossAxisCount: 2,
                                  // ),
                                  itemCount: storecontroller.listbrand.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                      elevation: 5,
                                      // shape: CircleBorder(),
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.to(ProductListingPage(
                                              brandid: storecontroller
                                                  .listbrand[index].id
                                                  .toString(),
                                              categoryname: storecontroller
                                                  .listbrand[index].brandName
                                                  .toString(),
                                            ));
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ClipOval(
                                                child: Image.network(
                                                  storecontroller
                                                      .listbrand[index]
                                                      .getImageUrl(),
                                                  fit: BoxFit.cover,
                                                  height: 110.0,
                                                  width: 110.0,
                                                ),
                                              ),
                                              // Container(
                                              //   // color: Colors.amber,
                                              //   alignment: Alignment.center,
                                              //   height: 40,
                                              //   padding:
                                              //       EdgeInsets.symmetric(horizontal: 10),
                                              //   child: NormalText(
                                              //       brandList[index].brandName,
                                              //       kblack,
                                              //       16,
                                              //       textAlign: TextAlign.center),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
              ),
              Obx(
                () => _productController.productapicall.isFalse
                    ? const SizedBox.shrink()
                    : Column(
                        children: [
                          seeAllView(context, "Aqua Helthcare", () {
                            Get.to(const ProductListingPage(
                              categoryid: "2",
                              categoryname: "Healthcare",
                            ));
                          }),
                          Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              height: 242,
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  Productdetails product =
                                      _productController.productlist[index];
                                  return InkWell(
                                    onTap: () => Get.to(
                                        ProductDetailScreen(product: product)),
                                    child: cardWidget(context, product),
                                  );
                                },
                                itemCount: 5,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                              )),
                        ],
                      ),
              ),
              Obx(
                () => _productController.testingproductapicall.isFalse
                    ? const SizedBox.shrink()
                    : Column(
                        children: [
                          seeAllView(context, "Aqua Testing Kit", () {
                            Get.to(const ProductListingPage(
                              categoryid: "3",
                              categoryname: "Testing Kit",
                            ));
                          }),
                          Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              height: 275,
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  Productdetails product = _productController
                                      .testingproductlist[index];
                                  return InkWell(
                                    onTap: () => Get.to(
                                        ProductDetailScreen(product: product)),
                                    child: cardWidget(context, product),
                                  );
                                },
                                itemCount: 5,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                              )),
                        ],
                      ),
              ),
              Obx(
                () => _productController.fishproductapicall.isFalse
                    ? const SizedBox.shrink()
                    : Column(
                        children: [
                          seeAllView(context, "Aqua Fish Feed", () {
                            Get.to(const ProductListingPage(
                              categoryid: "5",
                              categoryname: "Fish Feed",
                            ));
                          }),
                          Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              height: 280,
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  Productdetails product =
                                      _productController.fishproductlist[index];
                                  return InkWell(
                                      onTap: () => Get.to(ProductDetailScreen(
                                          product: product)),
                                      child: cardWidget(context, product));
                                },
                                itemCount: 5,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                              )),
                        ],
                      ),
              ),
              Obx(
                () => _productController.shimpyproductapicall.isFalse
                    ? const SizedBox.shrink()
                    : Column(
                        children: [
                          seeAllView(context, "Aqua Shrimp Feed", () {
                            Get.to(const ProductListingPage(
                              categoryid: "6",
                              categoryname: "Shrimp Feed",
                            ));
                          }),
                          Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              height: 280,
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  Productdetails product = _productController
                                      .shimpyproductlist[index];
                                  return InkWell(
                                    onTap: () => Get.to(
                                        ProductDetailScreen(product: product)),
                                    child: cardWidget(context, product),
                                  );
                                },
                                itemCount: 5,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                              )),
                        ],
                      ),
              ),
              Obx(
                () => _productController.equipmentproductapicall.isFalse
                    ? const SizedBox.shrink()
                    : Column(
                        children: [
                          seeAllView(context, "Aqua Equipments", () {
                            Get.to(const ProductListingPage(
                              categoryid: "4",
                              categoryname: "Equipments",
                            ));
                          }),
                          Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              height: 225,
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  Productdetails product = _productController
                                      .equipmentproductlist[index];
                                  return InkWell(
                                    onTap: () => Get.to(
                                        ProductDetailScreen(product: product)),
                                    child: cardWidget(context, product),
                                  );
                                },
                                itemCount: 5,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                              )),
                        ],
                      ),
              ),
// SizedBox(height: 300,),
              // Container(
              //   // color: kitemlabel,
              //   padding: EdgeInsets.symmetric(vertical: 10),
              //   child: Container(
              //       color: kgreyFill,
              //       padding: EdgeInsets.all(16),
              //       alignment: Alignment.center,
              //       width: double.infinity,
              //       child: InkWell(
              //         onTap: () {
              //           // showDialogIfFirstLoaded(context, bypass: true);
              //         },
              //         child: Column(children: [
              //           Text(
              //             "We are delivering products in following states only,",
              //             style: TextStyle(
              //               fontSize: 14,
              //               color: kblack,
              //             ),
              //             textAlign: TextAlign.center,
              //           ),
              //           SizedBox(height: 4),
              //           Text(
              //             "Haryana, Punjab, Uttar Pradesh, Rajasthan, Gujarat, Bihar",
              //             style: TextStyle(
              //                 fontSize: 18,
              //                 color: kblack,
              //                 fontWeight: FontWeight.bold),
              //             textAlign: TextAlign.center,
              //           ),
              //         ]),
              //       )),
              // ),
              SizedBox(
                height: 10,
              ),
              Obx(() => _productController.isloading.isTrue
                  ? CircularProgressIndicator()
                  : SizedBox.shrink()),
              const SizedBox(
                height: 50,
              )
            ]),
          ), // A subclass of `ScrollView`
        ),
      ),
    );
  }

  Widget _categoriesView(
      String imagePath, String catName, void Function()? onpress) {
    return Expanded(
      child: InkWell(
        onTap: onpress,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2, color: Colors.grey.shade300)),
                child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CachedNetworkImage(
                      fadeInCurve: Curves.bounceIn,
                      imageUrl: imagePath,
                      placeholder: (context, url) =>
                          Image.asset('assets/no-photo.png'),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/no-photo.png'),
                    )),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              catName,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            )
          ],
        ),
      ),
    );
  }

  Widget vegitablecard() {
    return Container(
      width: screenwidth(context, dividedby: 3.3),
      child: VegetableCardWidget(
          imagePath: "assets/images/lamb_meat.png",
          name: "Bell Pepper",
          price: "1kg, 4\$",
          onTapCallback: () {}),
    );
  }

  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
