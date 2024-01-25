import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manjha/getxcontrollers/productlistingcontroller.dart';
import 'package:manjha/helper.dart';
import 'package:manjha/model/getbrandresponse.dart';
import 'package:manjha/model/productresponse.dart';
import 'package:manjha/screens/Product/productdetailsscreen.dart';
import 'package:manjha/widget/textstyle.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import '../../const.dart';
import '../../model/getcatogoriesresponse.dart';

class ProductListingPage extends StatefulWidget {
  final String? categoryid;
  final String? categoryname;
  final String? brandid;
  const ProductListingPage(
      {super.key, this.categoryid, this.categoryname, this.brandid});

  @override
  State<ProductListingPage> createState() => _ProductListingPageState();
}

class _ProductListingPageState extends State<ProductListingPage> {
  ProductListingController prductlist = Get.put(ProductListingController());
  @override
  void initState() {
    if (widget.categoryid != null) {
      prductlist.listcategory.add(Categorys(
          id: int.tryParse(widget.categoryid ?? "2"),
          imageUrl:
              "https://manjhaimages.s3.ap-south-1.amazonaws.com/product/1686555705.jpg",
          categoryName: "All"));
      prductlist.getcategories(categoryid: widget.categoryid ?? "2");
      prductlist.getbrand(categoryId: widget.categoryid ?? "2");
    }
    prductlist.productApiCall(
        categoryid: widget.categoryid, index: 0, brandid: widget.brandid);

    // TODO: implement initState
    super.initState();
  }
  Brands? selectedbrands;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          backgroundColor: Colors.white,
          // centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: kblack,
              )),
          title: ListTile(
            contentPadding: EdgeInsets.zero,
            minVerticalPadding: 0,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Brands"),
                        IconButton(onPressed: () {
                          Get.back();
                        }, icon: Icon(Icons.clear))
                      ],
                    ),
                    content: Container(
                      width: double.maxFinite,
                      height: screenheight(context,
                          dividedby: 1), // Adjust height as needed
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 0.78),
                        itemCount: prductlist
                            .listbrand.length, // Replace with your item count
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              prductlist.productApiCall(
                                  categoryid: widget.categoryid, index: 0, brandid:prductlist
                                  .listbrand[index].id.toString());
                              setState(() {
                                selectedbrands = prductlist
                                    .listbrand[index];
                              });
                              Get.back();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                children: [
                                  CachedNetworkImage(
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                    fadeInCurve: Curves.bounceIn,
                                    imageUrl:
                                        prductlist.listbrand[index].imageUrl ??
                                            "",
                                    placeholder: (context, url) =>
                                        Image.asset('assets/no-photo.png'),
                                    errorWidget: (context, url, error) =>
                                        Image.asset('assets/no-photo.png'),
                                  ),
                                  // Image.network(
                                  //     height: 40,
                                  //     width: 40,
                                  //     product.imageUrl ?? ""),
                                  Text(
                                      maxLines: 3,
                                      textAlign: TextAlign.center,
                                      prductlist.listbrand[index].brandName ?? "",
                                      style: const TextStyle(fontSize: 12)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            },
            visualDensity: VisualDensity.compact,
            title: Text(
              widget.categoryname ?? "Product",
              style: const TextStyle(fontSize: 20),
            ),
            subtitle:  Text(
              selectedbrands !=null ? "${selectedbrands?.brandName}" : "All",
              // style: TextStyle(fontSize: 24),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              widget.categoryid == "5" ||
                      widget.categoryid == "6" ||
                      widget.categoryid == null
                  ? const SizedBox()
                  : Expanded(
                      flex: 1,
                      child: Card(
                        elevation: 2,
                        child: SizedBox(
                          height: double.infinity,
                          child: Obx(
                            () => prductlist.getcategoriesapi.isFalse ||
                                    prductlist.currentindex.value == -1
                                ? const SizedBox()
                                : ListView.builder(
                                    itemCount: prductlist.listcategory.length,
                                    itemBuilder: (context, index) {
                                      Categorys product =
                                          prductlist.listcategory[index];

                                      return InkWell(
                                        onTap: () {
                                          prductlist.productApiCall(
                                              categoryid:
                                                  product.id.toString(),
                                              index: index);
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(5),
                                          // padding: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                width: 2,
                                                color: prductlist.currentindex
                                                            .value ==
                                                        index
                                                    ? Colors.green
                                                    : Colors.transparent,
                                              )),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Column(
                                              children: [
                                                CachedNetworkImage(
                                                  height: 40,
                                                  width: 40,
                                                  fit: BoxFit.cover,
                                                  fadeInCurve: Curves.bounceIn,
                                                  imageUrl:
                                                      product.imageUrl ?? "",
                                                  placeholder: (context, url) =>
                                                      Image.asset(
                                                          'assets/no-photo.png'),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      Image.asset(
                                                          'assets/no-photo.png'),
                                                ),
                                                // Image.network(
                                                //     height: 40,
                                                //     width: 40,
                                                //     product.imageUrl ?? ""),
                                                Text(
                                                    textAlign: TextAlign.center,
                                                    product.categoryName ?? "",
                                                    style: const TextStyle(
                                                        fontSize: 12)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ),
                      ),
                    ),
              // SizedBox(width: 10,),
              Expanded(
                flex: 4,
                child: Card(
                  color: Colors.grey.shade100,
                  elevation: 2,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: double.infinity,
                    child: Obx(
                      () => prductlist.productapicall.isFalse
                          ? const SizedBox()
                          : DynamicHeightGridView(
                              itemCount: prductlist.productlist.length,
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              builder: (BuildContext context, int index) {
                                return productview(
                                    prductlist.productlist[index], context);
                              }),
                    ),

                    // GridView.builder(
                    //         shrinkWrap: true,
                    //         primary: true,
                    //         padding: EdgeInsets.all(8),
                    //         // physics: NeverScrollableScrollPhysics(),
                    //         gridDelegate:
                    //             const SliverGridDelegateWithFixedCrossAxisCount(
                    //
                    //           crossAxisCount: 2,
                    //         ),
                    //         itemCount: prductlist.productlist.length,
                    //         itemBuilder: (BuildContext context, int index) {
                    //           return productview(
                    //               prductlist.productlist[index], context);
                    //         },
                    //       ),
                  ),
                ),
              ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget productview(Productdetails product, context) {
  return InkWell(
    onTap: () => Get.to(ProductDetailScreen(product: product)),
    child: Card(
      margin: EdgeInsets.zero,
      elevation: 5,
      child: Container(
        margin: const EdgeInsets.all(10),
        width: screenwidth(context, dividedby: 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  fit: BoxFit.scaleDown,
                  fadeInCurve: Curves.bounceIn,
                  imageUrl: product.imageUrl ?? "",
                  placeholder: (context, url) =>
                      Image.asset('assets/no-photo.png'),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/no-photo.png'),
                ),
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red),
                  child: Text("${product.discount}%",
                      style: TextStyle(
                          fontSize: 14,
                          color: kwhite,
                          fontWeight: FontWeight.w600)),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            BoldText("${product.productName}", 16, kblack),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (product.isTestingkit == true)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 3,
                      ),
                      TextCustomRow(
                        product.noOfTest.toString(),
                        kColorLabel,
                        12,
                        text2: 'No of Test: ',
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      TextCustomRow(
                        "${product.parametersCovered} ",
                        kgreyDark,
                        12,
                        fonntweight: FontWeight.w400,
                        text2: "Parameters Covered : ",
                      ),
                    ],
                  ),
                if (product.isFeed == true || product.isMedicine == true)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 3,
                      ),
                      TextCustomRow(
                        "${product.itemSize}",
                        kgreyDark,
                        12,
                        fonntweight: FontWeight.w500,
                        text2: "Size: ",
                      ),
                    ],
                  ),
                if (product.isFeed == true)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 3,
                      ),
                      TextCustomRow(
                        "${product.bagSize} Kg",
                        kgreyDark,
                        12,
                        fonntweight: FontWeight.w500,
                        text2: "Bag Size: ",
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                if (product.isFeed == true && !product.getIsPrawnFeed())
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextCustomRow(
                        "${product.proteinPerFat} Kg",
                        kgreyDark,
                        12,
                        fonntweight: FontWeight.w500,
                        text2: "Protein/fat: ",
                      ),
                    ],
                  ),
                if (product.isFeed == true && product.getIsPrawnFeed())
                  TextCustom(
                    "(Rs.${product.pricePerKg}/Kg)",
                    kgreyDark,
                    12,
                    fonntweight: FontWeight.w400,
                  ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextCustom(
                            "₹${product.specialPrice}",
                            kblack,
                            16,
                            fonntweight: FontWeight.w600,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          TextCustom("₹${product.price}", kgreyDark, 12,
                              fonntweight: FontWeight.w500, cancel: true),
                        ],
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: themecolor),
                    child: Text("Add",
                        style: TextStyle(
                            fontSize: 14,
                            color: kwhite,
                            fontWeight: FontWeight.w600)),
                  ),
                )
                // MaterialButton(color: themecolor,onPressed: () {
                //
                // },child: Row(children: [
                //   TextCustom("Add +",kwhite,16)
                // ],),)
              ],
            )
          ],
        ),
      ),
    ),
  );
}
