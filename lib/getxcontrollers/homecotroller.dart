import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:manjha/model/gethitcheryresponse.dart';
import 'package:manjha/model/searchfishresponse.dart';

import '../services/custom_api.dart';

class HomePageController extends GetxController{
  WebService webService = WebService(dio: Dio(), connectivity: Connectivity());

  RxBool seedloading = false.obs;
  List<Fish> fishseed = [];
  List<Fish> shrimpyseed = [];

  gethitcheryCall() async {

    // charChaCall.value = false;
    // EasyLoading.show();

    final response = await webService.getRequest(
        url: "${webService.baseUrl}/hatchery_premium?state=bharthana", );
    response.fold(
          (l) {
            Gethitcheryresponse hitchery = gethitcheryresponseFromJson(l.toString());

            fishseed = hitchery.fish ?? [];
            shrimpyseed = hitchery.shrimp ?? [];
            seedloading.value = true;
        update();
        EasyLoading.dismiss();
      },
          (r) => print(r.message),
    );
  }

  List<Fishes> fishlist = [];
  RxBool fidhloading = false.obs;

  getsalefishCall() async {
    // EasyLoading.show();
    Map<String, dynamic> para = {
      "fishtypes": "",
      "lat": "21.1430717",
      "lng": "72.7896089",
      "cityname": "", //cityname
      "limit": "50",
      "current_page": "",
      "page": "0",
      "customer_id": "",
      "updateLocation": "",
      "last_cityname": 'surat',
      "last_statename": 'gujarat'
    };


    final response = await webService.postFormRequest(
        url: "${webService.baseUrl}/searchfish", formData: jsonEncode(para));
    response.fold(
          (l) {
            Searchfishresponse fish =
            searchfishresponseFromJson(l.toString());

        fishlist = fish.data?.data ?? [];
        // productapicall.value = true;
            fidhloading.value = true;
            update();
        EasyLoading.dismiss();
      },
          (r) => print(r.message),
    );
  }

}