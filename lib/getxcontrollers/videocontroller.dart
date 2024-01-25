import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:manjha/model/getcategoryresponses.dart';
import 'package:manjha/model/getvideoresponse.dart';
import 'package:manjha/model/newsdiscriptionresponse.dart';
import 'package:manjha/services/apiconst.dart';

class VideoController extends GetxController {

  String language = "en";


  RxBool show = false.obs;
  List<Datum>? video = [];
  videoApiCall({required String code}) async {
    show.value = false;
    EasyLoading.show();
    await videogate(code: code).then((value) {
      video = value.data;
      // Fluttertoast.showToast(msg: value.message ?? "");
      show.value = true;
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      print("error....$error");
    });
  }

  RxBool showcategory = false.obs;
  List<DatumCategory>? category = [];
  CategoryApiCall({required String code}) async {
    showcategory.value = false;
    EasyLoading.show();
    await categorygate(code: code).then((value) {
      category = value.data;
      // Fluttertoast.showToast(msg: value.message ?? "");
      showcategory.value = true;
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      print("error....$error");
    });
  }
  RxBool shownews = false.obs;
  List<NewsDiscription>? newsdiscription = [];
  newsApiCall({required String code,required String categoryid}) async {
    shownews.value = false;
    EasyLoading.show();
    await newsdiscriptiongate(code: code, category: categoryid).then((value) {
      newsdiscription = value.data;
      // Fluttertoast.showToast(msg: value.message ?? "");
      shownews.value = true;
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      print("error....$error");
    });
  }



}
