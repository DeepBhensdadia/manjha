import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:manjha/const.dart';
import 'package:manjha/getxcontrollers/homecotroller.dart';
import 'package:manjha/model/gethitcheryresponse.dart';
import 'package:manjha/model/searchfishresponse.dart';
import 'package:manjha/screens/seddpages/seeddetailpage.dart';
import 'package:manjha/widget/textstyle.dart';
import '../../localconst.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../seddpages/fishdetailsscreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomePageController homePageController = Get.put(HomePageController());

  @override
  void initState() {
    if (homePageController.seedloading.isFalse) {
      homePageController.gethitcheryCall();
    }
    if (homePageController.fidhloading.isFalse) {
      homePageController.getsalefishCall();
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey.shade300,
          // drawer: Drawer(child: MenuDrawer()),
          appBar: AppBar(
            backgroundColor: kheader,
            automaticallyImplyLeading: false,
            flexibleSpace: const Image(
                image: AssetImage('assets/appbar.png'),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter),
            title: Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 0),
              child: NormalText("Manjha", kwhite, 30.0),
            ),
            centerTitle: false,
          ),
          body: GetBuilder<HomePageController>(
            builder: (controller) {
              return controller.seedloading.isFalse
                  ? Center(child: CircularProgressIndicator())
                  : LazyLoadScrollView(
                      onEndOfPage: () {
                        print("iycsgdhc");
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            if (controller.fishseed.isNotEmpty)
                              ListTile(
                                dense: true,
                                tileColor: kwhite,
                                visualDensity: VisualDensity.compact,
                                title: BoldText("Fish Hatcheries", 18, kblack,
                                    overflow: TextOverflow.ellipsis),
                                // title: Text("Fish Hatcheries", style: TextStyle(fontSize: 16)),
                                // leading: Icon(FontAwesomeIcons.list,
                                //     size: 18, color: kblack),
                                // leading: SizedBox(),
                                trailing: Text(
                                  "View All",
                                  style: TextStyle(color: Colors.lightBlue),
                                ),
                                onTap: () {},
                              ),
                            if (controller.fishseed.isNotEmpty)
                              Container(
                                color: kwhite,
                                margin: EdgeInsets.only(bottom: 8),
                                padding: EdgeInsets.only(bottom: 8),
                                height: 350.0,
                                child: ListView.builder(
                                    itemCount: controller.fishseed.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return hatcharyItem(
                                          controller.fishseed[index]);
                                    }),
                              ),
                            if (controller.shrimpyseed.isNotEmpty)
                              ListTile(
                                dense: true,
                                tileColor: kwhite,
                                visualDensity: VisualDensity.compact,
                                title: BoldText("Shrimp Hatcheries", 18, kblack,
                                    overflow: TextOverflow.ellipsis),
                                // title: Text("Shrimp Hatcheries", style: TextStyle(fontSize: 16)),
                                // leading: Icon(FontAwesomeIcons.list,
                                //     size: 18, color: kblack),
                                // leading: SizedBox(),
                                trailing: Text(
                                  "View All",
                                  style: TextStyle(color: Colors.lightBlue),
                                ),
                                onTap: () {},
                              ),
                            if (controller.shrimpyseed.isNotEmpty)
                              Container(
                                color: kwhite,
                                margin: EdgeInsets.only(bottom: 8),
                                padding: EdgeInsets.only(bottom: 8),
                                height: 350.0,
                                child: ListView.builder(
                                    itemCount: controller.shrimpyseed.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return hatcharyItem(
                                          controller.shrimpyseed[index]);
                                    }),
                              ),
                            Container(
                              // padding: EdgeInsets.only(top: 10, bottom: 1),
                              child: ListTile(
                                dense: true,
                                tileColor: kwhite,
                                visualDensity: VisualDensity.compact,
                                title: BoldText(
                                    "Sellers near by you", 18, kblack,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                            Container(
                              child: ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                cacheExtent: 5,
                                addSemanticIndexes: true,
                                semanticChildCount:
                                    (controller.fishlist.length <= 3
                                        ? controller.fishlist.length
                                        : 5),
                                physics: ClampingScrollPhysics(),
                                itemCount: controller.fishlist.length,
                                // separatorBuilder: (BuildContext context, int index) {
                                //   return SizedBox(height: 0);
                                // },
                                itemBuilder: (BuildContext context, int index) {
                                  return searchresult(
                                      controller.fishlist[index]);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    );
            },
          )),
    );
  }
}

Widget searchresult(Fishes saleitem) {
  return Container(
      //height: 100,
      padding: EdgeInsets.only(bottom: 1.0),
      child: Card(
        elevation: 0.0, //4,
        margin: EdgeInsets.all(0), //EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0), //10.0
        ),
        color: kwhite,
        child: InkWell(
          onTap: () {
            Get.to(FishDetailsScreen(saleItem: saleitem));
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        color: kheader,
                        width: 100.0, // ++ ARJUN to SET DESIGN
                        child: ClipRRect(
                            clipBehavior: Clip.antiAlias,
                            // borderRadius: BorderRadius.circular(5.0),
                            child:
                                // new Image.network(
                                //   image_fish_url +
                                //       (!saleitem.hasImage()
                                //           ? "no-photo.png"
                                //           : saleitem.fish_image),
                                //   fit: BoxFit.cover,
                                //   height: 135.0,
                                //   width: 100.0,
                                // ),
                                FadeInImage.assetNetwork(
                              fadeInCurve: Curves.easeInOut,
                              fadeInDuration: Duration(milliseconds: 100),
                              imageErrorBuilder: (context, error, stackTrace) =>
                                  Image.asset("assets/no-photo.png"),
                              placeholder: 'assets/no-photo.png',
                              image: saleitem.getImageURL(),
                              height: 155.0,
                              width: 100.0,
                              fit: BoxFit.cover,
                            ))),
                    // new Image.asset(
                    //   //list.thumbnailUrl,
                    //   "assets/fish.jpg",
                    //   fit: BoxFit.cover,
                    //   height: 100.0,
                    //   width: 100.0,
                    // ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.0),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                BoldText("Fish" + ": ", 16.0, kblack),
                                Expanded(
                                  child: BoldText(saleitem.fishTypeName ?? "",
                                      16.0, kitemlabelselected,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ]),
                          NormalText(
                              saleitem.sellerName ?? '', kgreyDark, 14.0),
                          SizedBox(height: 4.0),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Icon(
                                    FontAwesomeIcons.building,
                                    color: korange,
                                    size: 14.0,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                BoldText(saleitem.getCity(), 13.0, kgreyDark),
                                SizedBox(height: 10),
                                Flexible(fit: FlexFit.tight, child: SizedBox()),
                                Container(
                                  padding: EdgeInsets.only(right: 4),
                                  decoration: BoxDecoration(
                                    // color: kwhite,
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(0),
                                        child: Icon(
                                          Icons.location_on,
                                          color: korange,
                                          size: 18.0,
                                        ),
                                      ),
                                     BoldText(saleitem.getDistance(),
                                              13.0, kgreyDark),

                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ]),
                          SizedBox(height: 6.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BoldText(
                                    "Price" + ":",
                                    12.0,
                                    kgreyDark,
                                  ),
                                  BoldText(saleitem.getPrice(), 12.0, kheader),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BoldText("Size" + ":", 12.0, kgreyDark),
                                  BoldText(saleitem.fishSizeType.toString(),
                                      12.0, kheader),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BoldText("Weight" + ":", 12.0, kgreyDark),
                                  BoldText(saleitem.getWeight(), 12.0, kheader),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              //phone_in_talk
                              Container(
                                  child: BoldText(
                                      'Updates on,\n' +
                                          saleitem.getLastUpdateDate(),
                                      10.0,
                                      kgreyDark)),
                              // Spacer(),
                              MaterialButton(
                                  child: Icon(
                                    saleitem.is_favorite()
                                        ? FontAwesomeIcons.solidHeart
                                        : FontAwesomeIcons.heart,
                                    color: Colors.red,
                                    size: 18,
                                  ),
                                  minWidth: 35,
                                  color: Colors.white,
                                  elevation: 6,
                                  shape: CircleBorder(),
                                  onPressed: () async {}),
                              MaterialButton(
                                  child: Icon(
                                    FontAwesomeIcons.phoneAlt,
                                    color: kheader,
                                    size: 18,
                                  ),
                                  padding: EdgeInsets.only(bottom: 3),
                                  minWidth: 35,
                                  color: Colors.white,
                                  elevation: 6,
                                  shape: CircleBorder(),
                                  onPressed: () {
                                    // getSellerContact(saleitem.id);
                                  }),
                              MaterialButton(
                                  child: Icon(
                                    FontAwesomeIcons.whatsapp,
                                    color: kWhatsApp,
                                    size: 18,
                                  ),
                                  padding: EdgeInsets.only(bottom: 3),
                                  minWidth: 35,
                                  color: Colors.white,
                                  elevation: 6,
                                  shape: CircleBorder(),
                                  onPressed: () async {
                                    //getSellerWhatApp(saleitem.id);
                                  }),
                              MaterialButton(
                                  child: Icon(
                                    FontAwesomeIcons.shareAlt,
                                    color: kdarkBlue,
                                    size: 18,
                                  ),
                                  minWidth: 35,
                                  color: Colors.white,
                                  elevation: 6,
                                  shape: CircleBorder(),
                                  onPressed: () async {}),
                            ],
                          )
                        ],
                      ),
                    )), //"Lorem ipsum"
                  ],
                ),
              ],
            ),
          ),
        ),
      ));
}

Widget hatcharyItem(Fish hatchery) {
  return GestureDetector(
    onTap: () {
      Get.to(SeedDetailsPage(hatchery: hatchery));
    },
    child: Container(
        margin: EdgeInsets.all(4),
        // padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: kwhite,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)]),
        // elevation: 4,
        // color: kitembg,
        // margin: EdgeInsets.all(10),
        width: 310,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FadeInImage.assetNetwork(
                            fadeInCurve: Curves.easeInOut,
                            fadeInDuration: Duration(milliseconds: 100),
                            imageErrorBuilder: (context, error, stackTrace) =>
                                Image.asset("assets/no-photo.png"),
                            placeholder: 'assets/no-photo.png',
                            image: hatchery.getImageUrl(),
                            // height: 100.0,
                            // width: 100.0,
                            fit: BoxFit.cover,
                          ).image,
                        ),
                        color: kitembg,
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    // width: 310,
                  ),
                  if (hatchery.isManjhaTrusted == true)
                    Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: kheader.withAlpha(200),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      padding: EdgeInsets.all(4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Spacer(),
                          Icon(
                            FontAwesomeIcons.solidCheckCircle,
                            color: kwhite,
                            size: 12,
                          ),
                          Text(
                            " Trusted by Manjha ",
                            style: TextStyle(color: kwhite, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  if (hatchery.isCaaApproved == true)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.redAccent.withAlpha(200),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        padding: EdgeInsets.all(4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Spacer(),
                            Icon(
                              FontAwesomeIcons.certificate,
                              color: kwhite,
                              size: 12,
                            ),
                            Text(
                              " CAA Approved ",
                              style: TextStyle(color: kwhite, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (hatchery.isNfbdApproved == true)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent.withAlpha(220),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        padding: EdgeInsets.all(4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Spacer(),
                            Icon(
                              FontAwesomeIcons.certificate,
                              color: kwhite,
                              size: 12,
                            ),
                            Text(
                              " NFBD Approved ",
                              style: TextStyle(color: kwhite, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Spacer(),
                        MaterialButton(
                            child: Icon(
                              FontAwesomeIcons.phoneAlt,
                              color: kblack,
                              size: 18,
                            ),
                            minWidth: 40,
                            padding: EdgeInsets.zero,
                            color: Colors.white,
                            elevation: 6,
                            shape: CircleBorder(),
                            onPressed: () {
                              // TODO: LOG EVENTS
                              // hatcheryLog(hatchery.id, hatchery.ACTION_CALL);
                              launch("tel:+91${hatchery.mobileno}");
                            }),
                        MaterialButton(
                            child: Icon(
                              FontAwesomeIcons.whatsapp,
                              color: kblack,
                              size: 18,
                            ),
                            minWidth: 40,
                            color: Colors.white,
                            elevation: 6,
                            shape: CircleBorder(),
                            onPressed: () async {
                              // TODO: LOG EVENTS
                              // hatcheryLog(
                              //     hatchery.id, hatchery.ACTION_WHATSAPP);
                              launch(Uri.encodeFull(
                                  "https://wa.me/91${hatchery.mobileno}?text=${hatchery.getMessage()}"));
                              //getSellerWhatApp(saleitem.id);
                            }),
                        MaterialButton(
                            child: Icon(
                              FontAwesomeIcons.shareAlt,
                              color: kblack,
                              size: 18,
                            ),
                            minWidth: 40,
                            color: Colors.white,
                            elevation: 6,
                            shape: CircleBorder(),
                            onPressed: () {
                              // TODO: LOG EVENTS
                              // hatcheryLog(hatchery.id, hatchery.ACTION_SHARE);
                              Share.share(hatchery.getShareText());
                            }),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // Expanded(
            // child:
            Container(
              // color: Colors.amber,
              // alignment: Alignment.centerLeft,
              // height: 40,
              // padding: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 4),
              child: Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: BoldText(hatchery.hatcheryName ?? "", 18, kblack,
                          overflow: TextOverflow.ellipsis)),
                  // Spacer(),
                  Expanded(
                      flex: 1,
                      child: BoldText(hatchery.getSubTitle(), 14, kheader,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right))
                ],
              ),

              // )
            ),
            Container(
              padding: EdgeInsets.only(left: 16, top: 0, right: 16),
              // color: Colors.red,
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: hatchery.isFish()
                        ? BoldText('Availability', 12.0, kgreyDark)
                        : BoldText('Name / PL Size', 12, kgreyDark),
                  ),
                  if (hatchery.isFish())
                    Container(
                        width: 100,
                        margin: EdgeInsets.only(left: 3),
                        child: BoldText('Size', 12, kgreyDark,
                            textAlign: TextAlign.right)),
                  if (hatchery.isFish())
                    Container(
                        width: 100,
                        margin: EdgeInsets.only(left: 3),
                        child: BoldText('Line', 12, kgreyDark,
                            textAlign: TextAlign.right)),
                  if (hatchery.isShrimp())
                    Container(
                        width: 100,
                        margin: EdgeInsets.only(left: 3),
                        child: BoldText('Price', 12, kgreyDark,
                            textAlign: TextAlign.right)),
                  if (hatchery.isShrimp())
                    Container(
                        width: 100,
                        margin: EdgeInsets.only(left: 3),
                        child: BoldText('Bonus', 12, kgreyDark,
                            textAlign: TextAlign.right)),
                ],
              ),
            ),
            SizedBox(
              height: 55,
              child: Column(
                children: hatchery.seeds!
                    .map((t) => (Container(
                          padding: EdgeInsets.only(
                              left: 16, top: 6, bottom: 3, right: 16),
                          child: Row(
                            // mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: BoldText(t.seedName ?? "", 12, kheader,
                                      overflow: TextOverflow.ellipsis)),
                              if (hatchery.isFish())
                                Container(
                                    width: 100,
                                    margin: EdgeInsets.only(left: 3),
                                    child: BoldText(t.getSize(), 12, kheader,
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.ellipsis)),
                              if (hatchery.isFish())
                                Container(
                                    width: 100,
                                    margin: EdgeInsets.only(left: 3),
                                    child: BoldText(t.getWeight(), 12, kheader,
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.ellipsis)),
                              if (hatchery.isShrimp())
                                Container(
                                    width: 100,
                                    margin: EdgeInsets.only(left: 3),
                                    child: BoldText(t.getPrice(), 12, kheader,
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.ellipsis)),
                              if (hatchery.isShrimp())
                                Container(
                                    width: 100,
                                    margin: EdgeInsets.only(left: 3),
                                    child: BoldText(t.getBonus(), 12, kheader,
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.ellipsis)),
                            ],
                          ),
                        )))
                    .toList(),
              ),
            )
          ],
        )),
  );
}
