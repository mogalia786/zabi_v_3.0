// ignore_for_file: deprecated_member_use

import 'package:zabi/controller/quran_settings_controller.dart';
import 'package:zabi/util/images.dart';
import 'package:zabi/view/screens/quran/quran_settings_screen.dart';
import 'package:zabi/view/screens/quran/widget/bookmark_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zabi/controller/sura_list_controller.dart';
import 'package:zabi/util/dimensions.dart';
import 'package:zabi/view/base/custom_app_bar.dart';
import 'package:zabi/view/base/tabbar_button.dart';
import 'package:zabi/view/screens/quran/widget/juz_list_widget.dart';
import 'package:zabi/view/screens/quran/widget/sura_list_widget.dart';

class SuraList extends StatelessWidget {
  final bool appBackButton;
  const SuraList({super.key, required this.appBackButton});

  @override
  Widget build(BuildContext context) {
    Get.put(QuranSettingsController(apiClient: Get.find()));
    return Scaffold(
      // Appbar start ===>
      appBar: CustomAppBar(
        title: "holy_quran".tr,
        isBackButtonExist: appBackButton == true ? true : false,
        actions: [
          IconButton(
            onPressed: () {
              openBottomSheet(context);
            },
            icon: SvgPicture.asset(
              Images.Icon_Quran_Setting,
              color: Get.isDarkMode
                  ? Theme.of(context).textTheme.bodyMedium!.color
                  : Theme.of(context).cardColor,
              height: 28,
            ),
          ),
        ],
      ),

      // body start==>
      body: GetBuilder<SuraListController>(
        builder: (suraListController) {
          return DefaultTabController(
            length: 3,
            child: Column(
              children: [
                // tab bar start
                TabBar(
                  dividerColor: Theme.of(context).scaffoldBackgroundColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                    vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                  ),
                  labelPadding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  isScrollable: false,
                  indicator: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius:
                        BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  ),
                  // all tabs name
                  tabs: [
                    tabBarButton('surah_list'.tr, context),
                    tabBarButton('juz_list'.tr, context),
                    tabBarButton('bookmark'.tr, context),
                  ],
                ),
                // tabbar view==>
                Expanded(
                  child: TabBarView(
                    children: [
                      const Center(child: SuraListWidget()),
                      const Center(child: JuzListWidget()),
                      BookmarkTab()
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
