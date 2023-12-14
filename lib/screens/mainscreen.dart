import 'package:flutter/material.dart';
import 'package:manjha/const.dart';
import 'package:manjha/screens/homescreen.dart';
import 'package:manjha/screens/orders.dart';
import 'package:manjha/screens/profile.dart';
import 'package:manjha/screens/storescreen.dart';
import 'package:manjha/screens/whishlist.dart';



class MainScreens extends StatefulWidget {
  @override
  State<MainScreens> createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  int currentTab = 0;
  final List screens = [
    const HomeScreen(),
    const OrderScreen(),
    const StoreScreen(),
    const WhishlistScreen(),
    const ProfileScreen()
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomeScreen();

  @override
  Widget build(BuildContext context) {
    bool showfab = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      // backgroundColor: Colors.black,
      body: PageStorage(bucket: bucket, child: currentScreen),
      floatingActionButton: Visibility(
        visible: !showfab,
        child: FloatingActionButton(
            backgroundColor: greenthemecolor,
            onPressed: () {
              setState(() {
                currentScreen = StoreScreen();
                currentTab = 5;
              });
            },
            child: const Icon(Icons.storefront_sharp)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        // color: const Color(0xff909196).withOpacity(0.3),
        notchMargin: 6,
        // color: Color(0xff909196).withOpacity(0.3),
        child: SizedBox(
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const HomeScreen();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home_outlined,
                          color: currentTab == 0
                              ?  greenthemecolor
                              : Colors.grey,
                          size: 23,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 12,
                            color: currentTab == 0
                                ?  greenthemecolor
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const OrderScreen();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          color: currentTab == 1
                              ?  greenthemecolor
                              : Colors.grey,
                          size: 23,
                        ),
                        Text(
                          'Orders',
                          style: TextStyle(
                            fontSize: 12,
                            color: currentTab == 1
                                ? greenthemecolor
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const WhishlistScreen();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          color: currentTab == 3
                              ? greenthemecolor
                              : Colors.grey,
                          size: 23,
                        ),
                        Text(
                          'Whishlist',
                          style: TextStyle(
                            fontSize: 12,
                            color: currentTab == 3
                                ? greenthemecolor
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const ProfileScreen();
                        currentTab = 4;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_outline_outlined,
                          color: currentTab == 4
                              ? greenthemecolor
                              : Colors.grey,
                          size: 23,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 12,
                            color: currentTab == 4
                                ? greenthemecolor
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
