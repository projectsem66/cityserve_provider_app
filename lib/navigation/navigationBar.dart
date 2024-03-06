
import 'package:flutter/material.dart';


import '../btm_controller.dart';
import '../provider_bookings_page.dart';
import '../provider_home_page.dart';
import '../provider_paymant_page.dart';
import '../provider_profile_page.dart';
import '../utils/colors.dart';
import 'package:get/get.dart';

class NavigationBarr extends StatefulWidget {
  const NavigationBarr({super.key});

  @override
  State<NavigationBarr> createState() => _NavigationBarrState();
}

class _NavigationBarrState extends State<NavigationBarr> {
  BtmController _ = Get.put(BtmController());
  GlobalKey<ScaffoldState> ScaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  List<Widget> pages = const [
    Text("CS"),
    Text("CS"),
    Text("CS"),
    Text("CS"),
  ];
  final btmNaviScr = [
    provider_home_page(),
    provider_bookings_page(),
    provider_paymant_page(),
    provider_profile_page(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ScaffoldKey,
      body: GetBuilder<BtmController>(builder: (_) {
        return btmNaviScr[_.currentIndex];
      }),
      bottomNavigationBar: GetBuilder<BtmController>(
        builder: (_) {
          return BottomNavigationBar(
            currentIndex: _.currentIndex,
            showSelectedLabels: true,
            selectedIconTheme:
                IconThemeData(color: AppColors.themColor, shadows: []),
            unselectedIconTheme:
                IconThemeData(color: AppColors.themColor.withOpacity(0.7)),
            selectedItemColor: AppColors.themColor,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.event_note,
                ),
                label: "Bookings",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.payment_rounded,
                ),
                label: "Paymant",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle_outlined,
                ),
                label: "Profile",
              ),

            ],
            onTap: (index) {
              setState(
                () {
                  print("navigation page:" + _.currentIndex.toString());
                  _.currentIndex = index;
                },
              );
            },
          );
        },
      ),
    );
  }
}
