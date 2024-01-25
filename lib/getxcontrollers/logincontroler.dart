import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:manjha/const.dart';
import 'package:manjha/screens/mainscreen.dart';
import 'package:manjha/services/apiconst.dart';
import 'package:manjha/shared_pref/shared_pref.dart';

class LoginController extends GetxController {
  LoginApiCall({required String mobilenumber}) async {
    EasyLoading.show();
    Map<String,dynamic> para = {"mobileno": mobilenumber};

    await LoginMobile(parameter: para).then((value) {
      Fluttertoast.showToast(msg: value.message ?? "");
      SharedPref.save(
          value: jsonEncode(value.toJson()), prefKey: PrefKey.loginDetails);
      Get.to(MainScreens());
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      print("error....$error");
    });
  }
}
