import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:manjha/model/fishmasterresponse.dart';
import 'package:manjha/services/custom_api.dart';

class SaleFishController extends GetxController {
  WebService webService = WebService(dio: Dio(), connectivity: Connectivity());

  RxBool getfishbool = false.obs;

  List<Fishcategory> listfishcategories = [];
  List<Fishsize> listfishsizes = [];
  List<Fishtype> listfishtype = [];

  getfishmaster() async {
    final response =
        await webService.getRequest(url: "${webService.baseUrl}/fishmaster");
    response.fold(
      (l) {
        Fishmasterresponse banner = fishmasterresponseFromJson(l.toString());
        print(banner);
        listfishcategories = banner.data?.fishcategories ?? [];
        listfishsizes = banner.data?.fishsizes ?? [];
        listfishtype = banner.data?.fishtypes ?? [];
        getfishbool.value = true;
        EasyLoading.dismiss();
      },
      (r) {
        EasyLoading.dismiss();
        print(r.message);
      },
    );
  }

}
