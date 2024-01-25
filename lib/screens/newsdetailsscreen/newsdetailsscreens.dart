import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manjha/getxcontrollers/videocontroller.dart';

class NewsDetailsScreen extends StatefulWidget {
  final int categoryid;
  final String languagecode;
  const NewsDetailsScreen(
      {super.key, required this.categoryid, required this.languagecode});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  VideoController videoController = Get.put(VideoController());

  @override
  void initState() {
    videoController.newsApiCall(
        code: widget.languagecode, categoryid: widget.categoryid.toString());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "News".tr,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        // leading: InkWell(
        //   onTap: () => Navigator.pop(context),
        //   child: Image.asset(
        //     "assets/images/back_icon.png",
        //     scale: 2.2,
        //   ),
        // ),
      ),
      body: Obx(
        () => videoController.shownews.isFalse
            ? SizedBox()
            : ListView.builder(
                itemCount: videoController.newsdiscription?.length,
                itemBuilder: (context, index) => ListTile(
                      title: Text(videoController
                              .newsdiscription?[index].newsTitleLang ??
                          ""),
                    )
                //     Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                //   child: Card(
                //     child: Container(
                //       padding: EdgeInsets.all(10),
                //       // height: 100,
                //       width: screenwidth(context, dividedby: 1),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(videoController
                //                   .newsdiscription?[index].newsTitleLang ??
                //               "",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                //           HtmlWidget(videoController
                //               .newsdiscription?[index].newsDescriptionLang ?? "")
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                ),
      ),
    );
  }
}
