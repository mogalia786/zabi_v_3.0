// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zabi/controller/mosque_settings_controller.dart';
import 'package:zabi/util/dimensions.dart';
import 'package:zabi/util/images.dart';
import 'package:zabi/view/base/custom_app_bar.dart';
import 'package:zabi/view/screens/language/language_dw_widget.dart';
import 'package:zabi/view/screens/notification/notification_dw_widget.dart';
import 'package:zabi/view/screens/settings/widgets/item_widgets.dart';

class SettingsScreen extends StatefulWidget {
  final bool appBackButton;
  const SettingsScreen({super.key, required this.appBackButton});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar start ===>
      appBar: CustomAppBar(
        title: 'settings'.tr,
        isBackButtonExist: widget.appBackButton == true ? true : false,
      ),

      body: GetBuilder<MosqueSettingsController>(
        builder: (mosqueSettingsController) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
              ),
              child: Column(
                children: [
                  const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  // Notification section
                  const NofificationDWWidget(),

                  // select language section
                  const LanguageDWWidget(),

                  // share and rate app section  for android.
                  Platform.isAndroid
                      ? Column(
                          children: [
                            if (mosqueSettingsController
                                        .mosqueSettingsApiData !=
                                    null &&
                                mosqueSettingsController
                                        .mosqueSettingsApiData!.data !=
                                    null &&
                                mosqueSettingsController.mosqueSettingsApiData!
                                        .data!.playStoreUrl !=
                                    null)
                              SettingsItem(
                                leadingIcon: Icons.share,
                                imagePath: Images.Icon_share_app,
                                title: 'share'.tr,
                                onTap: () async {
                                  final playStoreUrl = mosqueSettingsController
                                      .mosqueSettingsApiData!.data!.playStoreUrl
                                      .toString();
                                  if (Uri.tryParse(playStoreUrl) != null) {
                                    await Share.share(playStoreUrl);
                                  } else {
                                    Get.snackbar("message".tr, "invalid_URL".tr,
                                        colorText: Colors.white,
                                        snackPosition: SnackPosition.TOP);
                                  }
                                },
                              ),
                            if (mosqueSettingsController
                                        .mosqueSettingsApiData !=
                                    null &&
                                mosqueSettingsController
                                        .mosqueSettingsApiData!.data !=
                                    null &&
                                mosqueSettingsController.mosqueSettingsApiData!
                                        .data!.playStoreUrl !=
                                    null)
                              SettingsItem(
                                imagePath: Images.Icon_rate_app,
                                leadingIcon: Icons.rate_review,
                                title: 'rate_us'.tr,
                                onTap: () async {
                                  final playStoreUrl = mosqueSettingsController
                                      .mosqueSettingsApiData!.data!.playStoreUrl
                                      .toString();
                                  if (Uri.tryParse(playStoreUrl) != null) {
                                    final url = Uri.parse(playStoreUrl);
                                    launchUrl(
                                      url,
                                      mode: LaunchMode.externalApplication,
                                    );
                                  } else {
                                    Get.snackbar("message".tr, "invalid_URL".tr,
                                        colorText: Colors.white,
                                        snackPosition: SnackPosition.TOP);
                                  }
                                },
                              ),
                          ],
                        )
                      : const SizedBox(),

                  // share and rate app section  for ios
                  Platform.isIOS
                      ? Column(
                          children: [
                            if (mosqueSettingsController
                                        .mosqueSettingsApiData !=
                                    null &&
                                mosqueSettingsController
                                        .mosqueSettingsApiData!.data !=
                                    null &&
                                mosqueSettingsController.mosqueSettingsApiData!
                                        .data!.appStoreUrl !=
                                    null)
                              SettingsItem(
                                imagePath: Images.Icon_share_app,
                                leadingIcon: Icons.share,
                                title: 'share'.tr,
                                onTap: () async {
                                  final appStoreUrl = mosqueSettingsController
                                      .mosqueSettingsApiData!.data!.appStoreUrl
                                      .toString();
                                  if (Uri.tryParse(appStoreUrl) != null) {
                                    await Share.share(appStoreUrl);
                                  } else {
                                    Get.snackbar("message".tr, "invalid_URL".tr,
                                        colorText: Colors.white,
                                        snackPosition: SnackPosition.TOP);
                                  }
                                },
                              ),
                            if (mosqueSettingsController
                                        .mosqueSettingsApiData !=
                                    null &&
                                mosqueSettingsController
                                        .mosqueSettingsApiData!.data !=
                                    null &&
                                mosqueSettingsController.mosqueSettingsApiData!
                                        .data!.appStoreUrl !=
                                    null)
                              SettingsItem(
                                imagePath: Images.Icon_rate_app,
                                leadingIcon: Icons.rate_review,
                                title: 'rate_us'.tr,
                                onTap: () async {
                                  final appStoreUrl = mosqueSettingsController
                                      .mosqueSettingsApiData!.data!.appStoreUrl
                                      .toString();
                                  if (Uri.tryParse(appStoreUrl) != null) {
                                    final url = Uri.parse(appStoreUrl);
                                    launchUrl(
                                      url,
                                      mode: LaunchMode.externalApplication,
                                    );
                                  } else {
                                    Get.snackbar("message".tr, "invalid_URL".tr,
                                        colorText: Colors.white,
                                        snackPosition: SnackPosition.TOP);
                                  }
                                },
                              ),
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
