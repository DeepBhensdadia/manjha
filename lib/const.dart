import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manjha/model/productresponse.dart';
import 'helper.dart';
import 'widget/textstyle.dart';

const themecolor =Color(0xFF008CAB);
const backgroundcolor =Color(0xffF9FAFF);
const cartbackgroundcolor =Color(0xffDEFFE4);
const korange = Color(0xFFFF9933);
const korangelite = Color(0xFFFFBE83);
const kwhite = Color(0xFFFFFFFF);
const kdarkBlue = Color(0xFF333366);
const kblack = Color(0xFF000000);
final kgreyDark = Colors.grey.shade700;
final kgreyDivider = Colors.grey.shade400;
final kgreyFill = Colors.grey.shade100;
const kheader = Color(0xFF008CAB);
const kitembg = Color(0xFFE1FFFC);
const kitemlabel = Color(0xFF0E5C6D);
const kitemlabelselected = Color(0xFFdd5512);
const kWhatsApp = Color(0xFF4fce5d);
const kLocation = Color(0xFF560000);
const kCallNow = Color(0xFF008dab);

const kColorButtonCart = Color(0xFF008CAB);
const kColorButton = Color(0xFF008CAB);
const kColorAppDefault = Color(0xFF008CAB); //Color(0xFF882066);
final kColorLabel = Colors.grey.shade700;//Colors.grey[900];
const kColorNote = Colors.black54;
const kColorDivider = Colors.black12;
final kColorPrice = Colors.green.shade800;


const String main_url = "https://manjhaimages.s3.ap-south-1.amazonaws.com";
const String image_fish_url = "$main_url/fish/";
const String image_news_url = "$main_url/news/";
const String image_banner_url = "$main_url/banner/";
const String image_brand_url = "$main_url/brand/";
const String image_category_url = "$main_url/category/";
const String image_product_url = "$main_url/product/";
const String image_customer_url = "$main_url/customer/";
const String image_charcha_url = "$main_url/charcha/";
const String image_hatchery_url = "$main_url/hatchery/";
const String image_hatcheryseed_url = "$main_url/hatcheryseed/";
const String app_link =
    "https://play.google.com/store/apps/details?id=com.gnhub.manjha";
const String app_ios_link = "https://apps.apple.com/fi/app/manjha/id1607387435";


void showSnackbar(String message,context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

imagecall(imageurl){
  return    CachedNetworkImage(
    fit: BoxFit.cover,
    fadeInCurve: Curves.bounceIn,
    imageUrl: imageurl,
    placeholder: (context, url) =>
        Image.asset('assets/no-photo.png'),
    errorWidget: (context, url, error) =>
        Image.asset('assets/no-photo.png'),
  );
}

Widget seeAllView(
    BuildContext context, String name, void Function()? ontapfunction) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name.tr,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: ontapfunction,
          child: Text(
            "View More".tr,
            style: TextStyle(
                fontSize: 15, color: themecolor, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}

Widget cardWidget(context, Productdetails product) {
  return Card(
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
                fit: BoxFit.cover,
                // fadeInCurve: Curves.bounceIn,
                imageUrl: product.imageUrl ?? "",
                placeholder: (context, url) =>
                    Image.asset('assets/no-photo.png'),
                errorWidget: (context, url, error) =>
                    Image.asset('assets/no-photo.png'),
              ),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: Colors.red),
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
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
  );
}