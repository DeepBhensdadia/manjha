import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manjha/const.dart';
import 'package:manjha/helper.dart';
import 'package:manjha/model/fishmasterresponse.dart';
import 'package:manjha/widget/textfieldscreen.dart';
import 'package:manjha/widget/textstyle.dart';

import '../getxcontrollers/salefishcontroller.dart';
import '../localconst.dart';
import '../widget/button.dart';

class SellFishScreen extends StatefulWidget {
  const SellFishScreen({super.key});

  @override
  State<SellFishScreen> createState() => _SellFishScreenState();
}

class _SellFishScreenState extends State<SellFishScreen> {
  SaleFishController saleFishController = Get.put(SaleFishController());

  TextEditingController sellerNameController = TextEditingController();
  TextEditingController fishTypeController = TextEditingController();
  TextEditingController weightPerPcsController = TextEditingController();

  @override
  void initState() {
    saleFishController.getfishmaster();
    // TODO: implement initState
    super.initState();
  }

  void showOtherFishType(bool visibility) {
    setState(() {
      _isVisibleFishTypeOther = visibility;
    });
  }

  List<File> fileList = [];
  bool _isVisibleFishTypeOther = false;
  bool _isVisibleWeight = true;
  int isSelected = 1;
  Fishtype? selectedFishType;
  Fishsize? selectedFishSize;
  String fishtypename = "";
  String fishsizename = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kwhite,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: themecolor,
            title: const Text("Sell your fish seeds"),
            centerTitle: true),
        body: Obx(
          () => saleFishController.getfishbool.isFalse
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                          // width: 300.0,
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    bottom: BorderSide(
                                        color: kgreyDivider, width: 3),
                                    top: BorderSide(
                                        color: kgreyDivider, width: 3)),
                              ),
                              // elevation: 2,
                              child: ListTile(
                                title: const Text("My Listing"),
                                // leading: Icon(FontAwesomeIcons.list,
                                //     size: 18, color: kblack),
                                // leading: SizedBox(),
                                trailing: const Icon(
                                    FontAwesomeIcons.arrowRight,
                                    size: 18,
                                    color: kblack),
                                onTap: () {},
                              ))),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BoldText("Name", 16, kheader),
                            const SizedBox(
                              height: 5,
                            ),
                            NormalForm(
                              FontAwesomeIcons.user,
                              "",
                              controller: sellerNameController,
                              readOnly: true,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            BoldText("Mobile No.", 16, kheader),
                            const SizedBox(
                              height: 5,
                            ),
                            NormalForm(
                              FontAwesomeIcons.mobileAlt,
                              "",
                              controller: sellerNameController,
                              textInputType: TextInputType.phone,
                              readOnly: true,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            BoldText("Address", 16, kheader),
                            const SizedBox(
                              height: 5,
                            ),
                            NormalForm(
                              FontAwesomeIcons.mapMarkerAlt,
                              "",
                              controller: sellerNameController,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            BoldText("City Name", 16, kheader),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: screenwidth(context, dividedby: 1),
                              child: MaterialButton(
                                color: Colors.white,
                                textColor: Colors.black87,
                                splashColor: Colors.white,
                                onPressed: () {
                                  // print('City Name');
                                  // _showMapboxSearch(context, false);
                                },
                                padding: const EdgeInsets.only(top: 12, bottom: 12),
                                // shape: Border(
                                //     bottom: BorderSide(
                                //         color: Colors.grey.shade300)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                        color: Colors.grey.shade400)),

                                child: Row(children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16,
                                        height: 1.6,
                                        fontFamily: "nunito",
                                        color: kgreyDark),
                                  ),
                                  const Flexible(
                                      fit: FlexFit.tight, child: SizedBox()),
                                  Icon(Icons.location_on_outlined,
                                      color: Colors.grey.shade700),
                                  const SizedBox(
                                    width: 10,
                                  )
                                ]),
                              ),
                              // NormalForm(Icons.location_city, "City Name",
                              //     controller: citynameController)
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            BoldText("Address of fish farm*", 16, kheader),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: screenwidth(context, dividedby: 1),
                              child: MaterialButton(
                                color: Colors.white,
                                textColor: Colors.black87,
                                splashColor: Colors.white,
                                onPressed: () {
                                  // print('City Name');
                                  // _showMapboxSearch(context, false);
                                },
                                padding: const EdgeInsets.only(top: 12, bottom: 12),
                                // shape: Border(
                                //     bottom: BorderSide(
                                //         color: Colors.grey.shade300)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                        color: Colors.grey.shade400)),

                                child: Row(children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16,
                                        height: 1.6,
                                        fontFamily: "nunito",
                                        color: kgreyDark),
                                  ),
                                  const Flexible(
                                      fit: FlexFit.tight, child: SizedBox()),
                                  Icon(Icons.location_on_outlined,
                                      color: Colors.grey.shade700),
                                  const SizedBox(
                                    width: 10,
                                  )
                                ]),
                              ),
                              // NormalForm(Icons.location_city, "City Name",
                              //     controller: citynameController)
                            ),
                            SizedBox(
                                width: screenwidth(context, dividedby: 1),
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton.icon(
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty
                                                .resolveWith(
                                          (states) => RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0)),
                                        )),
                                        onPressed: () async {},
                                        icon: const Icon(
                                          FontAwesomeIcons.locationArrow,
                                          size: 14,
                                           color: kheader,
                                        ),
                                        // color: kitembg,
                                        label: const FittedBox(
                                            child: Text(
                                              "Get Current Location",
                                          style: TextStyle(
                                              height: 1.5,
                                              fontSize: 13,
                                              color: kheader),
                                        ))))),
                            const SizedBox(
                              height: 5,
                            ),
                            BoldText("Type of fish*", 16, kheader),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: screenwidth(context, dividedby: 1),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border:
                                      Border.all(color: Colors.grey.shade400)),
                              child: DropdownButton<Fishtype>(
                                value: selectedFishType,
                                isExpanded: true,
                                underline: const SizedBox(),
                                // isDense: false,
                                // icon: Icon(Icons.arrow_downward),
                                // iconSize: 24,
                                // elevation: 16,
                                // style: TextStyle(color: Colors.deepPurple),
                                // underline: Container(
                                //   height: 2,
                                //   width: double.infinity,
                                //   color: Colors.deepPurpleAccent,
                                // ),
                                onChanged: (Fishtype? newValue) {
                                  setState(() {
                                    fishtypename = newValue!.fishTypeName ?? "";
                                    selectedFishType = newValue;
                                    fishTypeController.text =
                                        selectedFishType?.fishTypeName ?? "";
                                    showOtherFishType(selectedFishType!
                                        .fishTypeName!
                                        .toLowerCase()
                                        .contains("other"));
                                    if (selectedFishType!.fishTypeName!
                                        .toLowerCase()
                                        .contains("other")) {
                                      fishTypeController.text = '';
                                    }
                                  });
                                },
                                items: saleFishController.listfishtype
                                    .map<DropdownMenuItem<Fishtype>>(
                                        (Fishtype fishTypeItem) {
                                  return DropdownMenuItem<Fishtype>(
                                    value: fishTypeItem,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 14),
                                      child: Text(
                                        fishTypeItem.fishTypeName ?? '',
                                        style: TextStyle(
                                            fontFamily: "nunito",
                                            fontWeight: FontWeight.w500,
                                            color: kgreyDark,
                                            fontSize: 15.5),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            Visibility(
                                visible: _isVisibleFishTypeOther,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    Container(
                                        width:
                                            screenwidth(context, dividedby: 1),
                                        padding: const EdgeInsets.only(left: 16),
                                        child: BoldText(
                                            "Other Fish Type", 16, kheader)),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                        width:
                                            screenwidth(context, dividedby: 1),
                                        child: NormalForm.plain(
                                          "Other Fish Type",
                                          controller: fishTypeController,
                                        )),
                                  ],
                                )),
                            const SizedBox(
                              height: 5,
                            ),
                            BoldText("Size of fish*", 16, kheader),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: screenwidth(context, dividedby: 1),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border:
                                      Border.all(color: Colors.grey.shade400)),
                              child: DropdownButton<Fishsize>(
                                value: selectedFishSize,
                                isExpanded: true,
                                underline: const SizedBox(),
                                // isDense: false,
                                // icon: Icon(Icons.arrow_downward),
                                // iconSize: 24,
                                // elevation: 16,
                                // style: TextStyle(color: Colors.deepPurple),
                                // underline: Container(
                                //   height: 2,
                                //   width: double.infinity,
                                //   color: Colors.deepPurpleAccent,
                                // ),
                                onChanged: (Fishsize? newValue) {
                                  setState(() {
                                    selectedFishSize = newValue!;
                                    if (selectedFishSize!.fishSizeTypeName!
                                            .toLowerCase()
                                            .contains("spawn") ||
                                        selectedFishSize!.fishSizeTypeName!
                                            .toLowerCase()
                                            .contains("zero")) {
                                      _isVisibleWeight = false;
                                      weightPerPcsController.text = "0";
                                      isSelected = 1;
                                    } else {
                                      _isVisibleWeight = true;
                                      if (weightPerPcsController.text == "0")
                                        weightPerPcsController.text = "";
                                    }
                                  });
                                },
                                items: saleFishController.listfishsizes
                                    .map<DropdownMenuItem<Fishsize>>(
                                        (Fishsize fishTypeItem) {
                                  return DropdownMenuItem<Fishsize>(
                                    value: fishTypeItem,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 14),
                                      child: Text(
                                        fishTypeItem.fishSizeTypeName ?? '',
                                        style: TextStyle(
                                            fontFamily: "nunito",
                                            fontWeight: FontWeight.w500,
                                            color: kgreyDark,
                                            fontSize: 15.5),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Visibility(
                              visible: _isVisibleWeight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BoldText("Weight Per Pcs*", 16, kheader),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  NormalForm(
                                    FontAwesomeIcons.fish,
                                    "",
                                    controller: weightPerPcsController,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            BoldText("Price*", 16, kheader),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: NormalForm(
                                  Icons.currency_rupee,
                                  "",
                                  controller: sellerNameController,
                                  textInputType: TextInputType.number,
                                )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Visibility(
                                    visible: _isVisibleWeight,
                                    child: ToggleButtons(
                                      borderColor: Colors.grey.shade400,
                                      selectedColor: kwhite,
                                      focusColor: kwhite,
                                      fillColor: kheader,
                                      selectedBorderColor: Colors.grey.shade400,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0)),
                                      isSelected: [
                                        isSelected == 1,
                                        isSelected == 0
                                      ],
                                      onPressed: (int index) {
                                        setState(() {
                                          isSelected = index == 0 ? 1 : 0;
                                        });
                                      },
                                      children: const  [
                                        Text("Pcs"),
                                        Text("Kg"),
                                      ],
                                    )),
                              ],
                            ),
                            Visibility(
                                visible: !_isVisibleWeight,
                                child: NormalText(
                                    "(Price / lakh pcs)", Colors.black, 16)),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                                width: screenwidth(context, dividedby: 1),
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: ElevatedButton.icon(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => kitembg),
                                            shape: MaterialStateProperty
                                                .resolveWith((states) =>
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    4.0)))),
                                        onPressed: () {
                                          showPicker(context);
                                        },
                                        icon: const Icon(
                                          FontAwesomeIcons.camera,
                                          color: kheader,
                                        ),
                                        label: const FittedBox(
                                            child: Text(
                                              "Select Photos",
                                          style: TextStyle(
                                              height: 1, color: kheader),
                                        ))))),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                                width: screenwidth(context, dividedby: 1),
                                child:
                                    WideButton.bold(("Submit"), () {}, true)),
                            const SizedBox(
                              height: 25,
                            ),
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

  checkFileCount() {
    if (fileList.length >= 3) {
      EasyLoading.showError("You can upload maximum 3 photos.");
      return false;
    }
    return true;
  }

  Future showPicker(context) async {
    if (!checkFileCount()) return false;

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Photo Library'),
                      onTap: () {
                        pickFile();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  ImagePicker _picker = ImagePicker();
  _imgFromCamera() async {
    XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 50);

    setState(() {
      // List<Widget> thumbs = new List<Widget>();
      // fileListThumb.forEach((element) {
      //   thumbs.add(element);
      // });

      // var element = image;
      // thumbs.add(Padding(
      //     padding: EdgeInsets.all(1),
      //     child: Stack(
      //       children: <Widget>[
      //         Container(
      //             decoration: new BoxDecoration(color: Colors.white),
      //             alignment: Alignment.center,
      //             height: 240,
      //             child: new Image.file(File(element.path))),
      //         Align(
      //           alignment: Alignment.bottomRight,
      //           child: IconButton(
      //               icon: Icon(
      //                 // FontAwesomeIcons.heart,
      //                 Icons.highlight_off,
      //                 color: korange,
      //               ),
      //               onPressed: () {
      //                 setState(() {
      //                   Fluttertoast.showToast(msg: "delete");
      //                   // files.remove(element);
      //                   thumbs.remove(element);
      //                 });
      //               }),
      //         )
      //       ],
      //     )));
      if (image?.path != null) fileList.add(File(image!.path));
      // fileListThumb = thumbs;
    });
  }

  Future pickFile() async {
    // List<Widget> thumbs = new List<Widget>();
    // fileListThumb.forEach((element) {
    //   thumbs.add(element);
    // });

    await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'bmp', 'png'], //, 'pdf', 'doc', 'docx'
    ).then((files) {
      if (files != null) {
        setState(() {
          fileList.add(files as File);
        });
      }
    });
  }

  List<Map> toBase64(List<File> fileList) {
    List<Map> s = [];
    if (fileList.isNotEmpty) {
      for (var element in fileList) {
        Map a = {
          'fileName': element.path,
          'encoded': base64Encode(element.readAsBytesSync())
        };
        s.add(a);
      }
    }

    return s;
  }
}
