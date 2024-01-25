import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:manjha/getxcontrollers/videocontroller.dart';
import 'package:manjha/localconst.dart';
import 'package:manjha/model/getcategoryresponses.dart';
import 'package:manjha/model/getvideoresponse.dart';

import 'package:manjha/widget/textstyle.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../const.dart';
import '../../shared_pref/shared_pref.dart';

import '../newsdetailsscreen/newsdetailsscreens.dart';
import 'videoblogscreens.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  VideoController videoController = Get.put(VideoController());

  String? languagecode = SharedPref.get(prefKey: PrefKey.languagecode) ?? "en";
  @override
  void initState() {
    videoController.videoApiCall(code: languagecode ?? "en");
    videoController.CategoryApiCall(code: languagecode ?? "en");

    // TODO: implement initState
    super.initState();
  }

  void changeLanguage(Locale newLocale) {
    Get.updateLocale(newLocale);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Discover".tr,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: PopupMenuButton<String>(
                  child: Icon(
                    Icons.change_circle_outlined,
                    color: kblack,
                  ),
                  onSelected: (value) {
                    videoController.videoApiCall(code: value);
                    videoController.CategoryApiCall(code: value);
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      onTap: () {
                        changeLanguage(const Locale("en", "US"));
                        SharedPref.save(
                            value: "en", prefKey: PrefKey.languagecode);
                        SharedPref.save(
                            value: "US", prefKey: PrefKey.langcontry);
                        videoController.language = "en";
                      },
                      value: 'en',
                      child: const Text('English'),
                    ),
                    PopupMenuItem<String>(
                      onTap: () {
                        changeLanguage(const Locale("bn", "IN"));
                        SharedPref.save(
                            value: "bn", prefKey: PrefKey.languagecode);
                        SharedPref.save(
                            value: "IN", prefKey: PrefKey.langcontry);
                        videoController.language = "bn";
                      },
                      value: 'bn',
                      child: const Text('Bangla'),
                    ),
                  ],
                ),
              ),
            ],
            // leading: InkWell(
            //   onTap: () => Navigator.pop(context),
            //   child: Image.asset(
            //     "assets/images/back_icon.png",
            //     scale: 2.2,
            //   ),
            // ),
          ),
          backgroundColor: kwhite,
          body: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  dense: true,
                  tileColor: kwhite,
                  visualDensity: VisualDensity.compact,
                  title: NormalText("Browse Latest Videos".tr, kdarkBlue, 22),
                  trailing: Text(
                    "View More".tr,
                    style: const TextStyle(color: Colors.lightBlue),
                  ),
                  onTap: () {
                    Get.to(videoblogScreens(videos: videoController.video));
                  },
                ),
                Obx(
                  () => videoController.show.isFalse
                      ? const SizedBox()
                      : Container(
                          color: kwhite,
                          // margin: EdgeInsets.only(bottom: 8),
                          // padding: EdgeInsets.only(bottom: 8),
                          height: 305.0,
                          child: ListView.builder(
                              itemCount: videoController.video?.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return populateItemVideo(
                                    videoController.video![index]);
                              }),
                        ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    alignment: Alignment.centerLeft,
                    child: NormalText(
                        "Read latest news and Articles".tr, kdarkBlue, 22)),
                Obx(
                  () => videoController.showcategory.isFalse
                      ? const SizedBox()
                      : GridView.builder(
                          shrinkWrap: true,
                          primary: true,
                          padding: const EdgeInsets.all(8),
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: videoController.category?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return populateItemNewsCategory(
                                videoController.category![index]);
                          }),
                )
              ],
            ),
          )),
    );
  }

  Widget populateItemNewsCategory(DatumCategory category) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          Get.to( NewsDetailsScreen(categoryid:category.id ?? 0, languagecode: videoController.language,));
        },
        child: Container(
            margin: const EdgeInsets.all(4),
            // padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: kwhite,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2)]),
            // elevation: 4,
            // color: kitembg,
            // margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Common.getHaxColor(category.colorCode),
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    child: ClipOval(
                      child: Image.network(
                        image_news_url + category.newsCategoryImage.toString(),
                        fit: BoxFit.cover,
                        height: 80.0,
                        width: 80.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  // color: Colors.amber,
                  alignment: Alignment.center,
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: NormalText("${category.categoryName}", kblack, 16,
                      textAlign: TextAlign.center),
                ),
              ],
            )),
      ),
    );
  }

  Widget populateItemVideo(Datum videoItem) {
    String dates = DateFormat(
            "MMM d, yyyy h:mm a", Localizations.localeOf(context).toString())
        .format(videoItem.createdAt ?? DateTime.now());
    return Container(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 4), //const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            print(videoItem.videoTitle);
            // Fluttertoast.showToast(msg: (videoItem.video_title));
            launch(videoItem.videoUrl!); //or any link you want
          },
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // height: 200,
                    // width:312,
                    child: CachedNetworkImage(
                      height: 190,
                      width: 324,
                      fadeInCurve: Curves.bounceIn,
                      imageUrl: videoItem.videoImage ?? "",
                      placeholder: (context, url) =>
                          Image.asset('assets/no-photo.png'),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/no-photo.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 312,
                          child: Text(videoItem.videoTitleLang ?? "",
                              maxLines: 2,
                              style: TextStyle(
                                  fontFamily: "nunito",
                                  fontWeight: FontWeight.w600,
                                  color: kblack,
                                  fontSize: 16)),
                        ),
                        TextCustom(
                          dates.toString(),
                          kgreyDark,
                          14,
                          fonntweight: FontWeight.w400,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
