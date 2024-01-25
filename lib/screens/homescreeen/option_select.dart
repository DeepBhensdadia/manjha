import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manjha/const.dart';
import 'package:manjha/getxcontrollers/productcontroller.dart';
import '../../helper.dart';

class selectaqua extends StatefulWidget {
  const selectaqua({Key? key}) : super(key: key);

  @override
  State<selectaqua> createState() => _selectaquaState();
}

class _selectaquaState extends State<selectaqua> {
  List<String> name = ["Helthcare","Testing Kit" , "Equipments"];
  ProductController _productController = Get.put(ProductController());


  @override
  void initState() {
    _productController.helthcareproductApiCall(
      categoryid: "2",
    );
    _productController.testingproductApiCall(
      categoryid: "3",
    );
    _productController.equipmentproductApiCall(
      categoryid: "4",
    );
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15,),
      // color: Colors.red,
      height: screenheight(context, dividedby: 15),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                // _productController.helthcareproductApiCall(
                //   categoryid: "2",
                // );
                setState(() {
                  _productController.currantindex.value = 0;
              });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: 0 ==  _productController.currantindex.value
                        ? themecolor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  // height: screenheight(context, dividedby: 8),
                  // width: screenwidth(context, dividedby: 1.3),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      name[0],
                      style: TextStyle(
                          fontSize: 15,
                          color:  _productController.currantindex.value == 0
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                // _productController.helthcareproductApiCall(
                //   categoryid: "3",
                // );
                setState(() {
                 _productController.currantindex.value = 1;
              });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: 1 ==  _productController.currantindex.value
                        ? themecolor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  // height: screenheight(context, dividedby: 8),
                  // width: screenwidth(context, dividedby: 1.3),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      name[1],
                      style: TextStyle(
                          fontSize: 15,
                          color:  _productController.currantindex.value == 1
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                // _productController.helthcareproductApiCall(
                //   categoryid: "4",
                // );
                setState(() {
                 _productController.currantindex.value = 2;
              });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: 2 ==  _productController.currantindex.value
                        ? themecolor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  // height: screenheight(context, dividedby: 8),
                  // width: screenwidth(context, dividedby: 1.3),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      name[2],
                      style: TextStyle(
                          fontSize: 16,
                          color:  _productController.currantindex.value == 2
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}





class SelectFeed extends StatefulWidget {
  const SelectFeed({super.key});

  @override
  State<SelectFeed> createState() => _SelectFeedState();
}

class _SelectFeedState extends State<SelectFeed> {
  List<String> name = ["Fish Feed","Shrimp Feed"];

  ProductController _productController = Get.put(ProductController());


  @override
  void initState() {
      _productController.fishproductApiCall(
        categoryid: "5",
      );
     _productController.shimpyproductApiCall(
        categoryid: "6",
      );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15,),
        // color: Colors.red,
        height: screenheight(context, dividedby: 15),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // _productController.helthcareproductApiCall(
                  //   categoryid: "2",
                  // );
                  setState(() {
                    _productController.currantfeedindex.value = 0;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: 0 ==  _productController.currantfeedindex.value
                          ? themecolor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    // height: screenheight(context, dividedby: 8),
                    // width: screenwidth(context, dividedby: 1.3),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        name[0],
                        style: TextStyle(
                            fontSize: 15,
                            color:  _productController.currantfeedindex.value == 0
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // _productController.helthcareproductApiCall(
                  //   categoryid: "3",
                  // );
                  setState(() {
                    _productController.currantfeedindex.value = 1;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: 1 ==  _productController.currantfeedindex.value
                          ? themecolor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    // height: screenheight(context, dividedby: 8),
                    // width: screenwidth(context, dividedby: 1.3),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        name[1],
                        style: TextStyle(
                            fontSize: 15,
                            color:  _productController.currantfeedindex.value == 1
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}
