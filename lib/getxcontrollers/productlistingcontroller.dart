import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:manjha/model/productresponse.dart';

import '../model/getbrandresponse.dart';
import '../model/getcatogoriesresponse.dart';
import '../services/custom_api.dart';

class ProductListingController extends GetxController {
  WebService webService = WebService(dio: Dio(), connectivity: Connectivity());

  List<Categorys> listcategory = [];
  RxBool getcategoriesapi = false.obs;

  getcategories({required String categoryid}) async {
    EasyLoading.show();

    final response = await webService.getRequest(
        url: "${webService.baseUrl}/store_subcategory?test=1&id=$categoryid");
    response.fold(
      (l) {
        Getcategoriesresponse category =
            getcategoriesresponseFromJson(l.toString());
        print(category);
        listcategory.addAll(category.data ?? []);
        getcategoriesapi.value = true;
        EasyLoading.dismiss();
      },
      (r) {
        EasyLoading.dismiss();

        print(r.message);
      },
    );
  }

  List<Brands> listbrand = [];
  RxBool brandbool = false.obs;

  getbrand({required String categoryId}) async {
    // EasyLoading.show();

    final response = await webService.getRequest(
        url: "${webService.baseUrl}/store_brand/$categoryId");
    response.fold(
      (l) {
        EasyLoading.dismiss();
        Getbrandresponse brand = getbrandresponseFromJson(l.toString());
        print(brand);
        listbrand = brand.data ?? [];
        brandbool.value = true;
      },
      (r) {
        EasyLoading.dismiss();
        print(r.message);
      },
    );
  }

  RxBool productapicall = false.obs;
  List<Productdetails> productlist = [];
  RxInt currentindex = 0.obs;
  productApiCall(
      {String? categoryid, String? brandid, required int index}) async {
    productapicall.value = false;
    EasyLoading.show();
    Map<String, dynamic> para = {'test': '1'};
    if (brandid != null) {
      para.addAll({'brand_id': brandid});
    }
    if (categoryid != null) {
      para.addAll({'category_id': categoryid});
    }

    final response = await webService.postFormRequest(
        url: "${webService.baseUrl}/store_product", formData: jsonEncode(para));
    response.fold(
      (l) {
        Packagessummaryresponse product =
            packagessummaryresponseFromJson(l.toString());

        productlist = product.data ?? [];
        productapicall.value = true;
        currentindex.value = index;
        EasyLoading.dismiss();
      },
      (r) => print(r.message),
    );
  }
}
