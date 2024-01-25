import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:manjha/const.dart';
import 'package:manjha/model/productresponse.dart';
import 'package:manjha/screens/mainscreen.dart';
import 'package:manjha/services/apiconst.dart';
import 'package:manjha/services/custom_api.dart';
import 'package:manjha/shared_pref/shared_pref.dart';

class ProductController extends GetxController {
  WebService webService = WebService(dio: Dio(), connectivity: Connectivity());

  RxInt currantindex = 0.obs;
  RxInt currantfeedindex = 0.obs;

  RxBool testingproduct = false.obs;
  RxBool fishfeedproduct = false.obs;
  RxBool shrimpyfeedproduct = false.obs;
  RxBool equipmentproduct = false.obs;
  RxBool isloading = false.obs;


  RxBool productapicall = false.obs;
  List<Productdetails> productlist = [];
  helthcareproductApiCall({required String categoryid}) async {
    productapicall.value = false;
    // EasyLoading.show();
    Map<String, dynamic> para = {
      'test': '1',
      'category_id': categoryid
    };


    final response = await webService.postFormRequest(
        url: "${webService.baseUrl}/store_product?lang=${languagecode()}", formData: jsonEncode(para));
    response.fold(
      (l) {
        Packagessummaryresponse product =
            packagessummaryresponseFromJson(l.toString());

        productlist = product.data ?? [];
        productapicall.value = true;
        EasyLoading.dismiss();
      },
      (r) => print(r.message),
    );
  }


  RxBool testingproductapicall = false.obs;
  List<Productdetails> testingproductlist = [];
  testingproductApiCall({required String categoryid}) async {
    isloading.value = true;
    // EasyLoading.show();

    Map<String, dynamic> para = {'test': '1', 'category_id': categoryid};

    final response = await webService.postFormRequest(
        url: "${webService.baseUrl}/store_product", formData: jsonEncode(para));
    response.fold(
      (l) {
        Packagessummaryresponse product =
            packagessummaryresponseFromJson(l.toString());

        testingproductlist = product.data ?? [];
        testingproductapicall.value = true;
        isloading.value = false;
        EasyLoading.dismiss();

      },
      (r) => print(r.message),
    );
  }

  RxBool fishproductapicall = false.obs;
  List<Productdetails> fishproductlist = [];
  fishproductApiCall({required String categoryid}) async {
    // EasyLoading.show();
    isloading.value = true;
    Map<String, dynamic> para = {'test': '1', 'category_id': categoryid};

    final response = await webService.postFormRequest(
        url: "${webService.baseUrl}/store_product", formData: jsonEncode(para));
    response.fold(
      (l) {
        EasyLoading.dismiss();

        Packagessummaryresponse product =
            packagessummaryresponseFromJson(l.toString());

        fishproductlist = product.data ?? [];
        fishproductapicall.value = true;
        isloading.value = false;
      },
      (r) => print(r.message),
    );
  }

  RxBool shimpyproductapicall = false.obs;
  List<Productdetails> shimpyproductlist = [];
  shimpyproductApiCall({required String categoryid}) async {
    // EasyLoading.show()
    isloading.value = true;

    Map<String, dynamic> para = {'test': '1', 'category_id': categoryid};

    final response = await webService.postFormRequest(
        url: "${webService.baseUrl}/store_product", formData: jsonEncode(para));
    response.fold(
      (l) {
        Packagessummaryresponse product =
            packagessummaryresponseFromJson(l.toString());

        shimpyproductlist = product.data ?? [];
        shimpyproductapicall.value = true;
        isloading.value = false;

        EasyLoading.dismiss();

      },
      (r) => print(r.message),
    );
  }

  RxBool equipmentproductapicall = false.obs;
  List<Productdetails> equipmentproductlist = [];
  equipmentproductApiCall({required String categoryid}) async {

    Map<String, dynamic> para = {'test': '1', 'category_id': categoryid};
    // EasyLoading.show();
    isloading.value = true;
    final response = await webService.postFormRequest(
        url: "${webService.baseUrl}/store_product", formData: jsonEncode(para));
    response.fold(
      (l) {
        Packagessummaryresponse product =
            packagessummaryresponseFromJson(l.toString());

        equipmentproductlist = product.data ?? [];
        equipmentproductapicall.value = true;
        isloading.value = false;

        EasyLoading.dismiss();
      },
      (r) => print(r.message),
    );
  }
}
