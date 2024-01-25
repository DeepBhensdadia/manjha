import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:manjha/const.dart';
import 'package:manjha/languagetranslation/apptranslation.dart';
import 'package:manjha/model/productresponse.dart';
import 'package:manjha/screens/cartscreens/cartscreen.dart';
import 'package:manjha/services/apiconst.dart';
import 'package:manjha/widget/textstyle.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic product;
  // final Productdetails product;
  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String ras = "";
  int itemCount = 0;

  @override
  void initState() {
    ras = languagecode() != "en" ? "৳" : "Rs.";
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF3F5F7),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width, 140.0),
                  ),
                ),
                child: Column(children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Image.asset(
                            "assets/images/back_icon.png",
                            width: 44,
                            height: 44,
                          ),
                        ),
                        // Image.asset(
                        //   "assets/images/search_icon.png",
                        //   width: 44,
                        //   height: 44,
                        // )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  FractionallySizedBox(
                    alignment: Alignment.center,
                    widthFactor: 0.6,
                    child: Container(child: imagecall(widget.product.imageUrl)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.product.productName ?? "",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  Text("${translate("Code")}: ${widget.product.productCode}"),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.red),
                        child: Text(
                            "${numbertranslate(widget.product.discount ?? 0)}% ${translate("off")}",
                            style: TextStyle(
                                fontSize: 14,
                                color: kwhite,
                                fontWeight: FontWeight.w500)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextCustom(
                        "${ras} ${widget.product.specialPrice}",
                        kgreyDark,
                        20,
                        cancel: true,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextCustom(
                    "${ras} ${widget.product.specialPrice}",
                    kColorPrice,
                    23,
                    fonntweight: FontWeight.w600,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ]),
              ),
              const SizedBox(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (itemCount > 0) itemCount--;
                            });
                          },
                          child: Image.asset(
                            "assets/images/remove_icon.png",
                            width: 50,
                            height: 50,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "$itemCount",
                          style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: (() {
                            setState(() {
                              itemCount++;
                            });
                          }),
                          child: Image.asset(
                            "assets/images/add_icon.png",
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            listwidget(
                                text1: "Brand",
                                text2: "${widget.product.brandName}"),
                            if (widget.product.isFeed == true ||
                                widget.product.isMedicine == true)
                              listwidget(
                                  text1: "Size",
                                  text2: "${widget.product.getItmSize()}"),
                            if (widget.product.isFeed == true)
                              listwidget(
                                  text1: "Bag Size",
                                  text2: "${widget.product.bagSize} KG"),
                            if (widget.product.isFeed == true)
                              listwidget(
                                  text1: "Nature of Feed",
                                  text2: "${widget.product.feedNature} "),
                            if (widget.product.isFeed == true &&
                                !widget.product.getIsPrawnFeed())
                              listwidget(
                                  text1: "Protein/Fat",
                                  text2: "${widget.product.proteinPerFat} "),
                            if (widget.product.isFeed == true)
                              listwidget(
                                  text1: "Price/kg",
                                  text2: "Rs.${widget.product.pricePerKg}/KG"),
                            if (widget.product.isTestingkit == true)
                              listwidget(
                                  text1: "No of Test",
                                  text2: "${widget.product.noOfTest}"),
                            if (widget.product.isTestingkit == true)
                              listwidget(
                                  text1: "Paramaters Covered",
                                  text2: "${widget.product.parametersCovered}"),
                            if (widget.product.isTestingkit == true)
                              listwidget(
                                  text1: "Range Covered",
                                  text2: "${widget.product.rangeCovered}"),
                            if (widget.product.isEquipmentAerator())
                              listwidget(
                                  text1: "Voltage/Frequency",
                                  text2: "${widget.product.voltage}"),
                            if (widget.product.isEquipmentAerator())
                              listwidget(
                                  text1: "Motor Power",
                                  text2: "${widget.product.getMotorPower()}"),
                            if (widget.product.isEquipmentAerator())
                              listwidget(
                                  text1: "Weight",
                                  text2: "${widget.product.getWeight()}"),
                            if (widget.product.isEquipmentAerator())
                              listwidget(
                                  text1: "Number of fans/Paddles",
                                  text2: "${widget.product.noOfFans}"),
                            if (widget.product.isEquipmentAerator())
                              listwidget(
                                  text1: "Phase",
                                  text2: "${widget.product.motorPhase}"),
                            if (widget.product.isEquipmentAerator())
                              listwidget(
                                  text1: "PhaseSpeed",
                                  text2: "${widget.product.getMotorSpeed()}"),
                            if (widget.product.isEquipmentMudPumps())
                              listwidget(
                                  text1: "Pump Size",
                                  text2: "${widget.product.pumpSize}"),
                            if (widget.product.isEquipmentMudPumps())
                              listwidget(
                                  text1: "Motor Horsepower",
                                  text2: "${widget.product.getMotorPower()}"),
                            if (widget.product.isEquipmentMudPumps())
                              listwidget(
                                  text1: "Motor Phase",
                                  text2: "${widget.product.motorPhase}"),
                            if (widget.product.isEquipmentMudPumps())
                              listwidget(
                                  text1: "Speed",
                                  text2: "${widget.product.getMotorSpeed()}"),
                            if (widget.product.isEquipmentMudPumps())
                              listwidget(
                                  text1: "Max Flow Rate",
                                  text2: "${widget.product.getMaxFlowRate()}"),
                            if (widget.product.isEquipmentFishingNet())
                              listwidget(
                                  text1: "Color",
                                  text2: "${widget.product.netColor}"),
                            if (widget.product.isEquipmentFishingNet())
                              listwidget(
                                  text1: "Weight",
                                  text2: "${widget.product.getWeight()}"),
                            if (widget.product.isEquipmentFishingNet())
                              listwidget(
                                  text1: "Size of net",
                                  text2: "${widget.product.getNetSize()}"),
                            if (widget.product.isEquipmentFishingNet())
                              listwidget(
                                  text1: "Mesh Size",
                                  text2: "${widget.product.netMeshSize}"),
                            listwidget(
                                text1: "Availability",
                                text2: "${widget.product.getStockStatus()}"),
                          ],
                        ),
                      ),
                    ),
                    if (widget.product.isEquipment == true &&
                        widget.product.hasYoutubeLink())
                      ListTile(
                        visualDensity: VisualDensity.comfortable,
                        title: const Text('Watch on Youtube'),
                        trailing: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                // color: kwhite,
                                shape: BoxShape.rectangle,

                                boxShadow: [
                                  BoxShadow(color: Colors.grey, blurRadius: 2)
                                ],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                              ),
                              child: FadeInImage.assetNetwork(
                                fadeInCurve: Curves.easeInOut,
                                fadeInDuration:
                                    const Duration(milliseconds: 100),
                                imageErrorBuilder:
                                    (context, error, stackTrace) =>
                                        Image.asset("assets/no-photo.png"),
                                placeholder: 'assets/no-photo.png',
                                image: widget.product.getYoutuebImage(),
                                height: 100.0,
                                width: 100.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            MaterialButton(
                              minWidth: 45,
                              height: 35,
                              color: kheader.withAlpha(150),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: const BorderSide(
                                      color: Colors.transparent)),
                              onPressed: () {},
                              child: const Icon(
                                FontAwesomeIcons.play,
                                color: Colors.white,
                                size: 15,
                              ),
                            )
                          ],
                        ),
                        onTap: () {
                          launchUrl(widget.product.youtubeLink);
                        },
                      ),
                    const SizedBox(height: 10),
                    Card(
                      elevation: 3,
                      // margin: const EdgeInsets.all(10),
                      child: Container(
                          // color: ,
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: InkWell(
                            onTap: () {
                              // Common.pushPage(context, CheckoutCancel('7122'));
                              launch("tel:+917071270718");
                            },
                            child: Text(
                              "For any assistance: +91 70712 70718".tr,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600),
                            ),
                          )),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      elevation: 3,
                      margin:
                          const EdgeInsets.only(bottom: 10, left: 4, right: 4),
                      child: ExpansionTile(
                          title: Text((widget.product.isEquipment == true)
                              ? "Package Details".tr
                              : "Description".tr),
                          initiallyExpanded: true,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: HtmlWidget(
                                  widget.product.productDescription ?? ""),
                            ),
                            const SizedBox(height: 10)
                          ]),
                    ),
                    if (widget.product.isMedicine == true)
                      Card(
                        elevation: 3,
                        // margin: const EdgeInsets.only(
                        //     bottom: 10, left: 4, right: 4),
                        child: ExpansionTile(
                            title: Text("Benefits".tr),
                            initiallyExpanded: true,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: HtmlWidget(
                                    widget.product.benefits ?? ""),
                              ),
                              const SizedBox(height: 10)
                            ]),
                      ),
                    const SizedBox(height: 10),

                    if (widget.product.isMedicine == true)
                      Card(
                        elevation: 3,
                        margin: const EdgeInsets.only(
                            bottom: 10, left: 4, right: 4),
                        child: ExpansionTile(
                            title: Text("Direction For Use".tr),
                            initiallyExpanded: true,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: HtmlWidget(
                                    widget.product.directionForUse ?? ""),
                              ),
                              const SizedBox(height: 10)
                            ]),
                      ),
                    const SizedBox(height: 10),

                    if (widget.product.isTestingkit == true)
                      Card(
                        child: ExpansionTile(
                            title: const Text("How to Conduct the test"),
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: HtmlWidget(
                                    widget.product.directionForUse ?? ""),
                              ),
                              const SizedBox(height: 10)
                            ]),
                      ),
                    const SizedBox(height: 10),

                    if (widget.product.isEquipmentAerator() ||
                        widget.product.isEquipmentMudPumps())
                      Card(
                        child: ExpansionTile(
                            title: const Text("Warranty"),
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: HtmlWidget(
                                    widget.product.directionForUse ?? ""),
                              ),
                              const SizedBox(height: 10)
                            ]),
                      ),
                    // FractionallySizedBox(
                    //   widthFactor: 1,
                    //   child: ElevatedButton(
                    //       onPressed: () {
                    //        Get.to(CartScreen());
                    //       },
                    //       style: TextButton.styleFrom(
                    //         padding: const EdgeInsets.symmetric(vertical: 16),
                    //         textStyle: TextStyle(
                    //             fontSize: 14, fontWeight: FontWeight.w500),
                    //         shape: StadiumBorder(),
                    //         backgroundColor: Color(0xff23AA49),
                    //       ),
                    //       child: Text("Add to cart")),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemKeyPointsView(String imagePath, String title, String desc) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            border: Border.all(color: const Color(0xffF1F1F5))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 40,
              height: 40,
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff23AA49)),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(desc,
                    style: const TextStyle(
                        fontSize: 14, color: Color(0xff979899))),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget listwidget({required String text1, required String text2}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0, top: 8, left: 8),
    child: Row(
      children: [
        Expanded(
            flex: 2,
            child: TextCustom(
              text1,
              kgreyDark,
              15,
              fonntweight: FontWeight.w600,
            )),
        TextCustom(
          " :   ",
          kblack,
          15,
          fonntweight: FontWeight.w600,
        ),
        Expanded(
            flex: 4,
            child: TextCustom(
              text2.tr,
              kblack,
              15,
              fonntweight: FontWeight.w600,
            )),
      ],
    ),
  );
}
