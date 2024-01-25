import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manjha/const.dart';
import 'package:manjha/getxcontrollers/videocontroller.dart';
import 'package:manjha/helper.dart';
import 'package:manjha/model/getvideoresponse.dart';
import 'package:manjha/widget/textstyle.dart';
import 'package:url_launcher/url_launcher.dart';

class videoblogScreens extends StatefulWidget {
  final List<Datum>? videos;
  const videoblogScreens({super.key,  this.videos});

  @override
  State<videoblogScreens> createState() => _videoblogScreensState();
}

class _videoblogScreensState extends State<videoblogScreens> {
  // VideoController videoController = Get.put(VideoController());
  @override
  void initState() {
    // videoController.videoApiCall(code: "bn");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Videos Blog",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          elevation: 0,
          backgroundColor: themecolor,
          actions: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
            //   child: PopupMenuButton<String>(
            //     child: Icon(
            //       Icons.change_circle_outlined,
            //       color: kblack,
            //     ),
            //     onSelected: (value) =>
            //         videoController.videoApiCall(code: value),
            //     itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            //       PopupMenuItem<String>(
            //         onTap: () {
            //           videoController.language = "en";
            //         },
            //         value: 'en',
            //         child: Text('English'),
            //       ),
            //       PopupMenuItem<String>(
            //         onTap: () {
            //           videoController.language = "bn";
            //         },
            //         value: 'bn',
            //         child: Text('Bangla'),
            //       ),
            //     ],
            //   ),
            // ),
          ],
          // leading: InkWell(
          //   onTap: () => Navigator.pop(context),
          //   child: Image.asset(
          //     "assets/images/back_icon.png",
          //     scale: 2.2,
          //   ),
          // ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(

                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child:ListView.builder(
                    itemCount: widget.videos?.length,
                    itemBuilder: (context, index) {
                      Datum? videos =widget.videos?[index];
                      return VideoWidget(data: videos);
                    },
                  ),),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}

class VideoWidget extends StatefulWidget {
  final Datum? data;
  const VideoWidget({super.key, this.data});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: InkWell(
        onTap: () => launchUrl(Uri.parse(widget.data?.videoUrl ?? ""),
            mode: LaunchMode.externalApplication),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: screenwidth(context, dividedby: 1),
                  child: CachedNetworkImage(
                    fadeInCurve: Curves.bounceIn,
                    imageUrl: widget.data?.videoImage ?? "",
                    placeholder: (context, url) =>
                        Image.asset('assets/no-photo.png'),
                    errorWidget: (context, url, error) =>
                        Image.asset('assets/no-photo.png'),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: screenwidth(context, dividedby: 1),
                        child: Text(widget.data?.videoTitleLang ?? "",
                            style: TextStyle(
                                fontFamily: "nunito",
                                fontWeight: FontWeight.w600,
                                color: kblack,
                                fontSize: 18)),
                      ),
                      // TextCustom(
                      //   DateTime.now().toString(),
                      //   kgreyDark,
                      //   14,
                      //   fonntweight: FontWeight.w400,
                      // )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
