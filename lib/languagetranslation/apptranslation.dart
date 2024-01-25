import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:manjha/services/apiconst.dart';




class AppTranslations extends Translations {

  @override
  Map<String, Map<String, String>> get keys => {
        // english Language
        'en_US': {
          "Read latest news and Articles": "Read latest news and Articles",
          "Browse Latest Videos": "Browse Latest Videos",
          "View More": "View More",
          "Videos or News Blog": "Videos or News Blog",
          "Discover": "Discover",
          "For any assistance: +91 70712 70718":
              "For any assistance: +91 70712 70718",
          "Package Details": "Package Details",
          "Description": "Description",
          "Benefits": "Benefits",
          "Direction For Use": "Direction For Use",
          "Aqua Helthcare": "Aqua Helthcare",
          "View More": "View More",
          "Add": "Add",
          "Manjha": "Manjha",
          "Brand": "Brand",
          "Size": "Brand",
        "Availability" : "Availability","Code":"Code","off":"off","In Stock":"In Stock","Out of Stock":"Out of Stock"
        },

        // bangla Language
        'bn_IN': {
          "Read latest news and Articles": "সর্বশেষ খবর এবং নিবন্ধ পড়ুন",
          "Browse Latest Videos": "সর্বশেষ ভিডিও ব্রাউজ করুন",
          "View More": "আরো দেখুন",
          "Videos or News Blog": "ভিডিও বা নিউজ ব্লগ",
          "Discover": "আবিষ্কার করুন",
          "For any assistance: +91 70712 70718":
              "যেকোনো সহায়তার জন্য: +91 70712 70718",
          "Package Details": "প্যাকেজ বিবরণ",
          "Description": "বর্ণনা",
          "Benefits": "সুবিধা",
          "Direction For Use": "ব্যবহারবিধি",
          "Aqua Helthcare": "অ্যাকোয়া হেলথ কেয়ার",
          "View More": "আরো দেখুন",
          "Add": "করুন",
          "Manjha": "মাঞ্জা",
          "Brand": "ব্র্যান্ড",
          "Size": "আকার",
          "Availability" : "উপস্থিতি","Code":"কোড","off":"বন্ধ","In Stock":"স্টকে","Out of Stock":"স্টক আউট"
        },
      };
}

String translate(String key) {
  return AppTranslations().keys["${languagecode()}_${languagecountry()}"]?[key] ?? '';
}

String numbertranslate(int key) {
  return NumberFormat("#,##0", languagecode()).format(key);
}