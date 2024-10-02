// ignore_for_file: deprecated_member_use

import 'package:zabi/controller/sura_detaile_controller.dart';
import 'package:zabi/util/images.dart';
import 'package:zabi/view/screens/quran/quran_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zabi/util/dimensions.dart';
import 'package:zabi/view/base/custom_app_bar.dart';
import 'package:zabi/view/base/tabbar_button.dart';
import 'package:zabi/view/screens/quran/widget/arabic_quran_widget.dart';
import 'package:zabi/view/screens/quran/widget/ayah_translation_widget.dart';

class SuraDetaileScreen extends StatelessWidget {
  final bool appBackButton;
  const SuraDetaileScreen({super.key, required this.appBackButton});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SuraDetaileController>(
      builder: (suraDetaileController) {
        return Scaffold(
          // Appbar start ===>
          appBar: suraDetaileController.isSuraDetaileLoading.value
              ? CustomAppBar(
                  title: "--",
                  isBackButtonExist: appBackButton == true ? true : false,
                )
              : CustomAppBar(
                  title:
                      "${suraDetaileController.suraDetaileApiData!.data!.chapter!.translatedName}\n${suraDetaileController.suraDetaileApiData!.data!.chapter!.versesTranslateName}: ${suraDetaileController.suraDetaileApiData!.data!.chapter!.versesCount}",
                  isBackButtonExist: appBackButton == true ? true : false,
                  actions: [
                    IconButton(
                      onPressed: () {
                        openBottomSheet(context);
                      },
                      icon: SvgPicture.asset(
                        Images.Icon_Quran_Setting,
                        color: Get.isDarkMode
                            ? Theme.of(context).indicatorColor
                            : Theme.of(context).cardColor,
                        height: 28,
                      ),
                    ),
                  ],
                ),

          // body start
          body: DefaultTabController(
            length: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // tabbar start
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
                  tabs: [
                    tabBarButton('ayah_and_translation'.tr, context),
                    tabBarButton('arabic'.tr, context),
                  ],
                ),
                // tabbar view
                const Expanded(
                  child: TabBarView(
                    children: [
                      Center(child: AyanTranslationWidget()),
                      Center(child: ArabicQuranWidget()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
