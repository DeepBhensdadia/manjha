import 'package:flutter/material.dart';
import 'package:manjha/model/cart_data.dart';
import 'package:manjha/widget/cart_item.dart';

class WhishlistScreen extends StatefulWidget {
  const WhishlistScreen({super.key});

  @override
  State<WhishlistScreen> createState() => _WhishlistScreenState();
}

class _WhishlistScreenState extends State<WhishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Whishlist",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          // leading: InkWell(
          //   onTap: () => Navigator.pop(context),
          //   child: Image.asset(
          //     "assets/images/back_icon.png",
          //     scale: 2.2,
          //   ),
          // ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: CartItemModel.cartItemList.length,
                  itemBuilder: (context, index) {
                    return CartItemWidget(
                      item: CartItemModel.cartItemList[index],
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    shape: StadiumBorder(),
                    backgroundColor: Color(0xff23AA49),
                  ),
                  child: Center(child: Text("Buy Now - ₹120",style: TextStyle(fontSize: 16),))),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
