// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zabi/controller/quran_settings_controller.dart';
import 'package:zabi/util/dimensions.dart';
import 'package:zabi/util/styles.dart';
import 'package:zabi/controller/local_dhikr_controller.dart';
import 'package:zabi/view/base/loading_indicator.dart';
import 'package:zabi/view/screens/dhikr/local%20stroge%20dhikr/local_dhikr_count_screen.dart';

class UserAddedDikirWidget extends StatelessWidget {
  UserAddedDikirWidget({super.key});

  final LocalDhikrController localDhikrController =
      Get.put(LocalDhikrController());

  @override
  Widget build(BuildContext context) {
    localDhikrController.loadDhikrList();
    return GetBuilder<LocalDhikrController>(
      builder: (localDhikrController) {
        return Obx(
          () => localDhikrController.dhikrList.isEmpty
              ? Center(
                  child: Text(
                    "no_dhikr_added_here".tr,
                    style: robotoMedium.copyWith(
                        fontSize: Dimensions.FONT_SIZE_LARGE),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  itemCount: localDhikrController.dhikrList.length,
                  itemBuilder: (context, index) {
                    final dhikr = localDhikrController.dhikrList[index];
                    return Dismissible(
                      key: ValueKey(dhikr.id.toString()),
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (direction) async {
                        var isDeleting = false.obs;
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Obx(
                              () => AlertDialog(
                                title: Text(
                                  isDeleting.value == true
                                      ? "deleting_data".tr
                                      : "are_you_sure".tr,
                                  style: robotoMedium.copyWith(
                                      fontSize:
                                          Dimensions.FONT_SIZE_OVER_LARGE),
                                ),
                                content: isDeleting.value == true
                                    ? const SizedBox(
                                        height: 40,
                                        child: Center(
                                          child: LoadingIndicator(),
                                        ),
                                      )
                                    : Text(
                                        "do_you_want_to_delete_this_dhikr".tr,
                                        style: robotoMedium.copyWith(),
                                      ),
                                actions: isDeleting.value == true
                                    ? null
                                    : [
                                        TextButton(
                                          onPressed: () {
                                            var ddd = isDeleting(true);

                                            ddd == true
                                                ? Future.delayed(
                                                    const Duration(seconds: 1),
                                                    () {
                                                    localDhikrController
                                                        .deleteDhikr(dhikr.id);
                                                    Get.back();

                                                    isDeleting.value == false;
                                                  })
                                                : null;
                                          },
                                          child: Text(
                                            "yes".tr,
                                            style: robotoMedium.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme.error),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text(
                                            "cancel".tr,
                                            style: robotoMedium.copyWith(),
                                          ),
                                        ),
                                      ],
                              ),
                            );
                          },
                        );
                      },
                      onDismissed: (direction) {},
                      background: Container(
                        color: Theme.of(context).colorScheme.error.withOpacity(0.4),
                        padding: const EdgeInsets.only(
                            right: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        alignment: Alignment.centerRight,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          localDhikrController.dhikrId = dhikr.id;
                          Get.to(() =>
                              const LocalDhikrCountScreen(appBackButton: true));
                        },
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          color: Theme.of(context).cardColor,
                          shadowColor: Get.isDarkMode
                              ? Colors.grey[800]!
                              : Colors.grey[200]!,
                          child: ListTile(
                            contentPadding:
                                const EdgeInsetsDirectional.symmetric(
                                    horizontal:
                                        Dimensions.PADDING_SIZE_DEFAULT),

                            // Dhikr Title English---->
                            title: Text(
                              dhikr.englishName,
                              style: robotoMedium.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_LARGE),
                            ),
                            trailing: Text(
                              dhikr.arabicName == "" ? "--" : dhikr.arabicName,
                              style: GoogleFonts.getFont(
                                Get.find<QuranSettingsController>()
                                    .selectedFont
                                    .value,
                                fontSize: Get.find<QuranSettingsController>()
                                    .arabicFontSize
                                    .value,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
