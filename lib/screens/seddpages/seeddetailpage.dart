import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:manjha/model/gethitcheryresponse.dart';
import 'package:manjha/model/getseeddetailsresponse.dart';
import 'package:manjha/services/apiconst.dart';
import 'package:manjha/widget/textstyle.dart';
import 'package:video_player/video_player.dart';

import '../../const.dart';

class SeedDetailsPage extends StatefulWidget {
  final Fish hatchery;
  const SeedDetailsPage({super.key, required  this.hatchery});

  @override
  State<SeedDetailsPage> createState() => _SeedDetailsPageState();
}

class _SeedDetailsPageState extends State<SeedDetailsPage> {

 List<String>  imgList = [];

  Getseeddetails? list;
  bool show = false;
  getseeddetailApiCall({required String code}) async {
    // showcategory.value = false;
    // EasyLoading.show();
    await getseeddetails(hatcheruid: code).then((value) {
      setState(() {
        show = true;
        list = value;
      });
      imgList.add(widget.hatchery.getImageUrl());
      imgList.addAll(widget
          .hatchery
          .images!
          .map((e) => widget.hatchery.getMediaUrl(e)));
      // Fluttertoast.showToast(msg: value.message ?? "");
      // showcategory.value = true;
      // EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      // EasyLoading.dismiss();
      print("error....$error");
    });
  }

  @override
  void initState() {
    getseeddetailApiCall(code: widget.hatchery.id.toString());
    // TODO: implement initState
    super.initState();
  }
int _current = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: kblack, //change your color here
            ),
            backgroundColor: kwhite,
            title: NormalText('Seed Listing', kblack, 20),
            elevation: 1.0,
            // leading: Container(),
            actions: <Widget>[
              new Container(),
            ],
          ),
          body: show == true ? SingleChildScrollView(
            child: Column(
        children: [
          Stack(
            children: [
              CarouselSlider(
                items: imgList.map((item) {
                  // var index = imgList.indexOf(item);
                  return GestureDetector(
                      onTap: () {
                        // Common.pushPage(
                        //     context,
                        //     HeroPhotoViewRouteWrapper(
                        //         imageProvider: NetworkImage(item),
                        //         tag: 'product_' +
                        //             detail['product_id'].toString()));
                      },
                      child:
                      // Hero(
                      //   tag: item,
                      //   child:
                      Card(
                        margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
                        elevation: 2,
                        color: kitembg,
                        clipBehavior: Clip.antiAlias,
                        // child:
                        // Positioned(
                        //   top: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          constraints: BoxConstraints(
                              minHeight: 100,
                              minWidth: double.infinity,
                              maxHeight: 400),
                          child: (new Image.network(
                            item,
                            fit: BoxFit.cover,
                            // height: 200.0,
                            // width: 100.0,
                          )),
                        ),
                        //     Card(
                        //   margin: EdgeInsets.symmetric(
                        //       horizontal: 15, vertical: 10),
                        //   color: Colors.white,
                        //   semanticContainer: true,
                        //   clipBehavior: Clip.antiAliasWithSaveLayer,
                        //   child: new FadeInImage.assetNetwork(
                        //     placeholder: 'assets/no-photo.png',
                        //     placeholderScale: 1,
                        //     image: item,
                        //     // fit: BoxFit.fitWidth,
                        //     height: 200.0,
                        //   ),
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(10.0),
                        //   ),
                        // ),
                        // ),
                      ));
                }).toList(),
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: false,
                    aspectRatio: 1,
                    height: 300,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                        // print(_current);
                      });
                    }),
              ),
              Positioned(
                  child: new Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    alignment: FractionalOffset.topRight,
                    // height: 20,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imgList.map((url) {
                        int index = imgList.indexOf(url);
                        return Container(
                          width: 6.0,
                          height: 6.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == index
                                ? Color.fromRGBO(0, 0, 0, 0.9)
                                : Color.fromRGBO(0, 0, 0, 0.4),
                          ),
                        );
                      }).toList(),
                    ),
                  )),
            ],
          ),

            // Container(
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.vertical(
            //       bottom: Radius.elliptical(
            //           MediaQuery.of(context).size.width, 140.0),
            //     ),
            //   ),
            //   child: Column(children: [
            //     FractionallySizedBox(
            //       alignment: Alignment.center,
            //       widthFactor: 0.6,
            //       child: Container(child: imagecall(widget.hatchery.imageUrl)),
            //     ),
            //   ]),
            // ),
            Container(
              // elevation: 1,
              // color: kitembg,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width:300,
                            child: BoldText(widget.hatchery.hatcheryName ?? "", 22,
                                kblack),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              NormalText("Sold By: ",
                                  kgreyDark, 16.0),
                              BoldText.veryBold(
                                  widget.hatchery.ownerName ?? "",
                                  16.0,
                                  kCallNow,
                                  true),
                            ],
                          ),
                          BoldText(widget.hatchery.getLocation() ?? "", 16.0,
                              kWhatsApp),
                        ],
                      ),
                      // Spacer(),
                      if (widget.hatchery.hasVideo())
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                // color: kwhite,
                                shape: BoxShape.rectangle,

                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey, blurRadius: 2)
                                ],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                              ),
                              height: 100,
                              width: 60,
                              child: FadeInImage.assetNetwork(
                                fadeInCurve: Curves.easeInOut,
                                fadeInDuration:
                                Duration(milliseconds: 100),
                                imageErrorBuilder: (context, error,
                                    stackTrace) =>
                                    Image.asset("assets/no-photo.png"),
                                placeholder: 'assets/no-photo.png',
                                image: widget.hatchery.getImageUrl(),
                                fit: BoxFit.cover,
                              ),
                            ),
                            MaterialButton(
                                child: Icon(
                                  FontAwesomeIcons.play,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                // color: kWhatsApp,
                                minWidth: 45,
                                height: 35,
                                color: kheader.withAlpha(150),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(5),
                                    side: BorderSide(
                                        color: Colors.transparent)),
                                onPressed: () {
                                  // TODO: LOG EVENTS
                                  showVideo(
                                      widget.hatchery.getVideoUrl());
                                })
                          ],
                        ),
                      // if (widget._hatchery.hasVideo())
                      //   MaterialButton(
                      //       child: Icon(
                      //         FontAwesomeIcons.video,
                      //         color: Colors.white,
                      //         size: 22,
                      //       ),
                      //       // color: kWhatsApp,
                      //       minWidth: 50,
                      //       height: 50,
                      //       color: kheader,
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius:
                      //               BorderRadius.circular(100),
                      //           side: BorderSide(
                      //               color: Colors.transparent)),
                      //       onPressed: () {
                      //         // TODO: LOG EVENTS
                      //         showVideo();
                      //       })
                    ],
                  ),
                ],
              ),
            ),
            list!.data!.length == 0
                ? getNoRecordBox()
                : ListView.separated(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                primary: true,
                padding: EdgeInsets.only(top: 12),
                // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 2, childAspectRatio: 0.75),
                // itemExtent: 150,
                itemCount: list!.data!.length,
                separatorBuilder: (context, index) {
                  return Container(
                      height: 1,
                      color: kgreyFill,
                      margin: EdgeInsets.all(8));
                },
                itemBuilder: (context, index) {
                  return ListTile(
                      leading: list!.data![index].hasVideo()
                          ? Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              // color: kwhite,
                              shape: BoxShape.rectangle,

                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2)
                              ],
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                            child: FadeInImage.assetNetwork(
                              fadeInCurve: Curves.easeInOut,
                              fadeInDuration:
                              Duration(milliseconds: 100),
                              imageErrorBuilder: (context,
                                  error, stackTrace) =>
                                  Image.asset(
                                      "assets/no-photo.png"),
                              placeholder:
                              'assets/no-photo.png',
                              image:
                              list!.data![index].getImageUrl(),
                              height: 100.0,
                              width: 100.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          MaterialButton(
                              child: Icon(
                                FontAwesomeIcons.play,
                                color: Colors.white,
                                size: 15,
                              ),
                              // color: kWhatsApp,
                              minWidth: 45,
                              height: 35,
                              color: kheader.withAlpha(150),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(
                                      5),
                                  side: BorderSide(
                                      color: Colors
                                          .transparent)),
                              onPressed: () {
                                // TODO: LOG EVENTS
                                showVideo(list!.data![index]
                                    .getVideoUrl());
                              })
                        ],
                      )
                          : FadeInImage.assetNetwork(
                        fadeInCurve: Curves.easeInOut,
                        fadeInDuration:
                        Duration(milliseconds: 100),
                        imageErrorBuilder:
                            (context, error, stackTrace) =>
                            Image.asset(
                                "assets/no-photo.png"),
                        placeholder: 'assets/no-photo.png',
                        image: list!.data![index].getImageUrl(),
                        height: 100.0,
                        width: 100.0,
                        fit: BoxFit.cover,
                      ),
                      title: BoldText(
                          list!.data![index].seedName ?? "", 16.0, kblack),
                      subtitle: widget.hatchery.isFish()
                          ? Row(
                        children: [
                          Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  BoldText("Size:", 12.0,
                                      kgreyDark),
                                  BoldText(
                                      list!.data![index].getSize(),
                                      12.0,
                                      kheader),
                                ],
                              )),
                          SizedBox(width: 16),
                          Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  BoldText("Line: ", 12,
                                      kgreyDark),
                                  BoldText(
                                      list!.data![index].getWeight(),
                                      12,
                                      kheader),
                                ],
                              )),
                          SizedBox(width: 16),
                          Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  BoldText("Price: ", 12,
                                      kgreyDark),
                                  BoldText(
                                      list!.data![index].getPrice(),
                                      12,
                                      kheader),
                                ],
                              )),
                        ],
                      )
                          : Row(
                        children: [
                          Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  BoldText("Price: ", 12,
                                      kgreyDark),
                                  BoldText(
                                      list!.data![index].getPrice(),
                                      12,
                                      kheader),
                                ],
                              )),
                          SizedBox(width: 16),
                          Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  BoldText("Bonus: ", 12,
                                      kgreyDark),
                                  BoldText(
                                      list!.data![index].getBonus(),
                                      12,
                                      kheader),
                                ],
                              )),
                          SizedBox(width: 16),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: SizedBox(),
                          ),
                        ],
                      )
                    // trailing: Text(list[index].getPrice()),
                  );
                }),
        ],
      ),
          ) : Center(child: CircularProgressIndicator())),
    );
  }
  VideoPlayerController? _vcontroller;

  showVideo(String videoUrl) async {
    EasyLoading.show(status: 'Streaming Video...');
    _vcontroller = VideoPlayerController.network(videoUrl);
    await _vcontroller!.initialize();
    EasyLoading.dismiss();

    if (_vcontroller!.value.isInitialized) _vcontroller!.play();
    showGeneralDialog(
      context: context,
      barrierLabel: "SearchByFish",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (BuildContext context, anim1, anim2) {
        // return object of type Dialog
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0.0),
            title: BoldText(widget.hatchery.hatcheryName ?? '', 20.0, kheader),
            titlePadding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            content: Container(
              child: _vcontroller!.value.isInitialized
                  ? AspectRatio(
                aspectRatio: _vcontroller!.value.aspectRatio,
                child: VideoPlayer(_vcontroller!),
              )
                  : Container(child: Text('Video not loaded..')),
            ),
            actionsPadding: EdgeInsets.all(0.0),
            actions: <Widget>[
              new MaterialButton(
                child: BoldText("Close", 16.0, kheader),
                padding: EdgeInsets.only(right: 16, left: 16.0),
                onPressed: () {
                  _vcontroller!.pause();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
          Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );
  }

  Widget getNoRecordBox() {
    // return [
    return Card(
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: NormalText("No data found", kblack, 16.0),
          ),
        ));
    // ];
  }
}
