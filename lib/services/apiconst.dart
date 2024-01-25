import 'package:http/http.dart' as http;
import 'package:manjha/model/getcategoryresponses.dart';
import 'package:manjha/model/getfourmdetailsresponse.dart';
import 'package:manjha/model/getloginresponse.dart';
import 'package:manjha/model/getseeddetailsresponse.dart';
import 'package:manjha/model/getvideoresponse.dart';
import 'package:manjha/model/newsdiscriptionresponse.dart';
import 'package:manjha/shared_pref/shared_pref.dart';

 Map<String, String> headersdd = {};
 getCookie() {
  if (headersdd.containsKey("cookie")) return headersdd["cookie"];
  return "";
}

var commonHeaders = {
  // 'Content-Type': 'application/json; charset=UTF-8',
  "content-type": "application/x-www-form-urlencoded",
  'Cookie': getCookie().toString()};

String baseUrl = "https://manjha.in/public/api";
String image_brand_url = "https://manjha.in/public/api/brand";

Getloginresponse? saveUser() {
  Getloginresponse? saveuser = SharedPref.get(prefKey: PrefKey.loginDetails) !=
      null
      ? getloginresponseFromJson(SharedPref.get(prefKey: PrefKey.loginDetails)!)
      : null;
  return saveuser;
}

String? languagecode() {
  String? languagecode = SharedPref.get(prefKey: PrefKey.languagecode) ?? "en";
  return languagecode;
}
String? languagecountry() {
  String? languagecountry = SharedPref.get(prefKey: PrefKey.langcontry) ?? "US";
  return languagecountry;
}

//******************************* Post **************************//

Future<Getseeddetails>  getseeddetails({required String hatcheruid}) async {
  var url = Uri.parse("$baseUrl/hatchery_seed/$hatcheruid");
  var response = await http.get(url,headers: commonHeaders);
  print('Response Body: ${response.body}');
  return getseeddetailsFromJson(response.body);
}

Future<Getfourmdetails>  getfourmdetails({required String fourmid}) async {
  var url = Uri.parse("$baseUrl/forums/$fourmid");
  var response = await http.get(url,headers: commonHeaders);
  print('Response Body: ${response.body}');
  return getfourmdetailsFromJson(response.body);
}

Future<Getloginresponse> LoginMobile({required var parameter}) async {
  var url = Uri.parse("$baseUrl/loginmobilebypass");
  var response = await http.post(url,headers:commonHeaders,body: parameter );
  print('Response Body: ${response.body}');
  return getloginresponseFromJson(response.body);
}

Future<GetVideoResponse> videogate({required String code}) async {
  var url = Uri.parse("http://192.168.29.248:8003/api/videos?lang=$code");
  var response = await http.get(url);
  print('Response Body: ${response.body}');

  return getVideoResponseFromJson(response.body);
}

Future<GetcategoryResponse> categorygate({required String code}) async {
  var url = Uri.parse("http://192.168.29.248:8003/api/newscategories?lang=$code");
  var response = await http.get(url);
  print('Response Body: ${response.body}');
  return getcategoryResponseFromJson(response.body);
}

Future<Getnewsdiscriptionresponse> newsdiscriptiongate({required String code,required String category}) async {
  var url = Uri.parse("http://192.168.29.248:8003/api/news?category_id=$category&lang=$code");
  var response = await http.get(url);
  print('Response Body: ${response.body}');
  return getnewsdiscriptionresponseFromJson(response.body);
}

