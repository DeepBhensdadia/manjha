import 'package:flutter/material.dart';
import '../../helper.dart';

class FirstListviewbuilder extends StatefulWidget {
  const FirstListviewbuilder({Key? key}) : super(key: key);

  @override
  State<FirstListviewbuilder> createState() => _FirstListviewbuilderState();
}

class _FirstListviewbuilderState extends State<FirstListviewbuilder> {
  final controller = PageController(viewportFraction: 0.9, keepPage: true);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: screenheight(context, dividedby: 6.3),
          child: PageView.builder(
            controller: controller,
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                // color: Color(0xff909196).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/download.jpg')),
                    color: Color(0xff909196).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  // height: screenheight(context, dividedby: 8),
                  width: screenwidth(context, dividedby: 1.5),
                  // child: Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 18, vertical: 10),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         '25% Discount',
                  //         style: TextStyle(
                  //             fontSize: 18,
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.bold),
                  //       ),
                  //       Text(
                  //         'For Google Pixel',
                  //         style: TextStyle(
                  //             fontSize: 12,
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.w600),
                  //       ),
                  //       SizedBox(
                  //         height: 10,
                  //       ),
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           color: Color(0xff0C8A7B),
                  //           borderRadius: BorderRadius.circular(50.0),
                  //         ),
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Text(
                  //             'Learn more',
                  //             style: TextStyle(color: Colors.white),
                  //           ),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
