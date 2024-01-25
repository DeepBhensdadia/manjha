import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manjha/screens/Product/productdetailsscreen.dart';
import 'package:manjha/const.dart';

class VegetableCardWidget extends StatelessWidget {
  final String imagePath;
  final String name;
  final String price;
  final VoidCallback onTapCallback;
  const VegetableCardWidget(
      {Key? key,
      required this.imagePath,
      required this.name,
      required this.price,
      required this.onTapCallback})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () =>  Get.to(ProductDetailScreen()),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 1),
          color: backgroundcolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          elevation: 3,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
                child: Column(
                  children: [
                    Image.asset(
                      imagePath,
                      width: 80,
                      height: 80,
                    ),
                    SizedBox(height: 5,),
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "₹80",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star,color: Colors.orange,size: 15,),
                            Text(
                              " 5.0",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.favorite_border,color: Colors.grey,size: 23,),
              ),
            ],
          )),
    );
  }
}
