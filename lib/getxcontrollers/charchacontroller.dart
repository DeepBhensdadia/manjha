import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:manjha/model/charcharesponse.dart';

import '../services/custom_api.dart';

class CharchaController extends GetxController {
  WebService webService = WebService(dio: Dio(), connectivity: Connectivity());
  RxBool charChaCall = false.obs;
  List<Forum> forumList = [];

  getcharchaApiCall() async {
    // charChaCall.value = false;
    // EasyLoading.show();
    Map<String, dynamic> para = {'charchacall': "0"};

    final response = await webService.postFormRequest(
        url: "${webService.baseUrl}/forums", formData: jsonEncode(para));
    response.fold(
      (l) {
        Charcharesponse forum = charcharesponseFromJson(l.toString());

        forumList = forum.data ?? [];
        charChaCall.value = true;
        update();
        EasyLoading.dismiss();
      },
      (r) => print(r.message),
    );
  }

  getlikedislike({required String questionsid}) async {
    EasyLoading.show();
    Map<String, dynamic> para = {'forum_question_id': questionsid};

    final response = await webService.postFormRequest(
        url: "${webService.baseUrl}/forumQuestionLike",
        formData: jsonEncode(para));
    response.fold(
      (l) {
        final Map<String, dynamic> resBody = jsonDecode(l.toString());

        // final parsed = resBody["data"].cast<Map<String, dynamic>>();
        print(resBody);
        EasyLoading.showToast(resBody["message"]);
        getcharchaApiCall();

        EasyLoading.dismiss();
      },
      (r) => print(r.message),
    );
  }

  getreportreason({
    required String questionsid,
    required String reason,
  }) async {
    EasyLoading.show(status: 'Reporting...');
    Map<String, dynamic> para = {
      'forum_question_id': questionsid,
      'report': reason,
    };

    final response = await webService.postFormRequest(
        url: "${webService.baseUrl}/forum_reportAdd",
        formData: jsonEncode(para));
    response.fold(
      (l) {
        final Map<String, dynamic> resBody = jsonDecode(l.toString());

        // final parsed = resBody["data"].cast<Map<String, dynamic>>();
        print(resBody);
        EasyLoading.showToast(resBody["message"]);
        // getcharchaApiCall();

        EasyLoading.dismiss();
      },
      (r) => print(r.message),
    );
  }

  getblock({required String customerid}) async {
    EasyLoading.show(status: 'Blocking...');
    Map<String, dynamic> para = {
      'blocked_id': customerid,
    };

    final response = await webService.postFormRequest(
        url: "${webService.baseUrl}/forum_blockedAdd",
        formData: jsonEncode(para));
    response.fold(
      (l) {
        final Map<String, dynamic> resBody = jsonDecode(l.toString());
        // final parsed = resBody["data"].cast<Map<String, dynamic>>();
        print(resBody);
        EasyLoading.showToast(resBody["message"]);
        getcharchaApiCall();

        EasyLoading.dismiss();
      },
      (r) => print(r.message),
    );
  }
}
