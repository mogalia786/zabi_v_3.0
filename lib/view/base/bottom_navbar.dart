// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zabi/util/images.dart';
import 'package:zabi/view/screens/category/category_screen.dart';
import 'package:zabi/view/screens/compass/compass_screen.dart';
import 'package:zabi/view/screens/home/home_screen.dart';
import 'package:zabi/view/screens/nearby_mosque/nearby_mosque_screen.dart';
import 'package:zabi/view/screens/quran/sura_list_screen.dart';

class BottomNavbarScreen extends StatefulWidget {
  const BottomNavbarScreen({super.key});

  @override
  State<BottomNavbarScreen> createState() => _BottomNavbarScreenState();
}

class _BottomNavbarScreenState extends State<BottomNavbarScreen> {
  late List<Widget> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      const HomeScreen(),
      const CompassScreen(appBackButton: false),
      const SuraList(appBackButton: false),
      const NearbyMosque(appBackButton: false),
      CategoryScreen(appBackButton: false),
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        elevation: 0,
        height: Platform.isIOS ? 90 : 80,
        shape: const CircularNotchedRectangle(),
        notchMargin: 0.01,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          useLegacyColorScheme: false,
          onTap: _selectPage,
          unselectedItemColor: Theme.of(context).hintColor,
          selectedItemColor: Get.isDarkMode
              ? Theme.of(context).primaryColor
              : Theme.of(context).cardColor,
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Get.isDarkMode
                  ? Theme.of(context).cardColor
                  : Theme.of(context).primaryColor,
              icon: SvgPicture.asset(
                Images.Icon_Home,
                height: 28,
                color: Get.isDarkMode
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).cardColor,
              ),
              label: "home".tr,
            ),
            BottomNavigationBarItem(
              backgroundColor: Get.isDarkMode
                  ? Theme.of(context).cardColor
                  : Theme.of(context).primaryColor,
              icon: SvgPicture.asset(
                Images.Icon_Qibla,
                height: 28,
                color: Get.isDarkMode
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).cardColor,
              ),
              label: "compass".tr,
            ),
            BottomNavigationBarItem(
              backgroundColor: Get.isDarkMode
                  ? Theme.of(context).cardColor
                  : Theme.of(context).primaryColor,
              activeIcon: null,
              icon: const Icon(null),
              label: "quran".tr,
            ),
            BottomNavigationBarItem(
              backgroundColor: Get.isDarkMode
                  ? Theme.of(context).cardColor
                  : Theme.of(context).primaryColor,
              icon: SvgPicture.asset(
                Images.Icon_near_mosque,
                height: 28,
                color: Get.isDarkMode
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).cardColor,
              ),
              label: "nearby".tr,
            ),
            BottomNavigationBarItem(
              backgroundColor: Get.isDarkMode
                  ? Theme.of(context).cardColor
                  : Theme.of(context).primaryColor,
              icon: SvgPicture.asset(
                Images.Icon_Category,
                height: 25,
                color: Get.isDarkMode
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).cardColor,
              ),
              label: "category".tr,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: Get.isDarkMode
              ? Theme.of(context).cardColor.withOpacity(0.8)
              : Theme.of(context).primaryColor,
          hoverElevation: 10,
          // splashColor: Colors.black,
          tooltip: 'quran'.tr,
          elevation: 4,
          child: Image.asset(
            Images.Nav_quran,
            height: 30,
          ),
          onPressed: () => setState(() {
            _selectedPageIndex = 2;
          }),
        ),
      ),
    );
  }
}
