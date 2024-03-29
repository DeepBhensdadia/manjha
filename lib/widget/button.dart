import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manjha/widget/textstyle.dart';
import '../const.dart';

class WideButton extends StatelessWidget {
  final String text;
  bool isBold = false;
  final GestureTapCallback onPressed;
  WideButton(this.text, this.onPressed);
  WideButton.bold(this.text, this.onPressed, this.isBold);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        minWidth: 300.0,
        height: 45.0,
        child: MaterialButton(
          color: kheader,
          shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4)),
          child: isBold
              ? BoldText(text, 18, kwhite)
              : NormalText(text, kwhite, 18),
          onPressed: onPressed,
        ));
  }
}

class SquaredIcon extends StatelessWidget {
  final IconData icon;
  final String text;

  SquaredIcon(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => null,
      child: Container(
        width: 100,
        height: 80,
        decoration: new BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              blurRadius: 5.0,
              spreadRadius: -2.0,
              offset: Offset(
                3.0,
                4.0,
              ),
            )
          ],
        ),
        child: Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  size: 50,
                  color: kgreyDark,
                ),
                SizedBox(
                  height: 5,
                ),
                NormalText(text, kblack, 16.0)
              ],
            )),
      ),
    );
  }
}
