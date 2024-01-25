import 'package:flutter/material.dart';
import 'package:manjha/const.dart';
import 'package:manjha/helper.dart';
import 'package:manjha/screens/homescreeen/homescreen.dart';
import 'package:manjha/screens/profile.dart';
import 'package:manjha/screens/sellfishscreen.dart';
import 'package:manjha/screens/storescreen.dart';

import 'charchascreens/charchascreen.dart';
import 'discover/discoverscreen.dart';

class MainScreens extends StatefulWidget {
  @override
  State<MainScreens> createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> with SingleTickerProviderStateMixin  {
  int currentTab = 2;
  final List screens = [
     HomeScreen(),
    const SellFishScreen(),
    const StoreScreen(),
     CharchaScreen(ForumType.Forum),
     DiscoverScreen(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const StoreScreen();

  @override
  Widget build(BuildContext context) {
    bool showfab = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      // backgroundColor: Colors.black,
      body: PageStorage(bucket: bucket, child: currentScreen),
      floatingActionButton: Visibility(
        visible: !showfab,
        child: FloatingActionButton(
            backgroundColor: themecolor,
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
                    minWidth: screenwidth(context, dividedby: 5),
                    onPressed: () {
                      setState(() {
                        currentScreen =  HomeScreen();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home_outlined,
                          color:
                              currentTab == 0 ? themecolor : Colors.grey,
                          size: 23,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 12,
                            color:
                                currentTab == 0 ? themecolor : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: screenwidth(context, dividedby: 5),
                    onPressed: () {
                      setState(() {
                        currentScreen = SellFishScreen();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          color:
                              currentTab == 1 ? themecolor : Colors.grey,
                          size: 23,
                        ),
                        Text(
                          'Sell',
                          style: TextStyle(
                            fontSize: 12,
                            color:
                                currentTab == 1 ? themecolor : Colors.grey,
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
                    minWidth: screenwidth(context, dividedby: 5),
                    onPressed: () {
                      setState(() {
                        currentScreen =  CharchaScreen(ForumType.Forum);
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_alt_outlined,
                          color:
                              currentTab == 3 ? themecolor : Colors.grey,
                          size: 23,
                        ),
                        Text(
                          'Charcha',
                          style: TextStyle(
                            fontSize: 12,
                            color:
                                currentTab == 3 ? themecolor : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: screenwidth(context, dividedby: 5),
                    onPressed: () {
                      setState(() {
                        currentScreen =  DiscoverScreen();
                        currentTab = 4;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.menu_book_outlined,
                          color:
                              currentTab == 4 ? themecolor : Colors.grey,
                          size: 23,
                        ),
                        Text(
                          'Discover',
                          style: TextStyle(
                            fontSize: 12,
                            color:
                                currentTab == 4 ? themecolor : Colors.grey,
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

  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
