import 'package:flutter/material.dart';
import 'package:manjha/const.dart';
import 'package:manjha/model/cart_data.dart';


class CartItemWidget extends StatefulWidget {
  final CartItemModel item;
  const CartItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  int itemCount = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Container(
                 padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),

              decoration: BoxDecoration(color: cartbackgroundcolor,borderRadius: BorderRadius.circular(6)),
                child: Image.asset(
            widget.item.imagePath,
            width: 60,
            height: 60,
          ),
              )),
          SizedBox(width: 10,),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(widget.item.price,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    SizedBox(width: 5,),
                    Icon(Icons.star,size: 20,color: Colors.orange,),
                    Text(
                        " 5.0 (329 Reviews)",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                        "₹80",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                    SizedBox(width: 10,),
                    Icon(Icons.favorite_border,size: 20,color: Colors.grey,),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (itemCount > 0) itemCount--;
                    });
                  },
                  child: Image.asset(
                    "assets/images/remove_icon.png",
                    width: 24,
                    height: 24,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "$itemCount",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: (() {
                    setState(() {
                      itemCount++;
                    });
                  }),
                  child: Image.asset(
                    "assets/images/add_icon.png",
                    width: 24,
                    height: 24,
                  ),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}
