// ignore_for_file: deprecated_member_use

import 'package:share/share.dart';
import 'package:zabi/controller/bookmark_controller.dart';
import 'package:zabi/controller/quran_settings_controller.dart';
import 'package:zabi/controller/sura_detaile_controller.dart';
import 'package:zabi/data/model/response/bookmark_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zabi/util/app_constants.dart';
import 'package:zabi/util/dimensions.dart';
import 'package:zabi/util/images.dart';
import 'package:zabi/util/styles.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../base/loading_indicator.dart';

class AyanTranslationWidget extends StatelessWidget {
  const AyanTranslationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<SuraDetaileController>(
        builder: (suraDetaileController) {
          return suraDetaileController.isSuraDetaileLoading.value ||
                  suraDetaileController.suraDetaileApiData == null
              ? const Center(
                  child: LoadingIndicator(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    suraDetaileController
                                    .suraDetaileApiData!.data!.chapter!.id !=
                                1 &&
                            suraDetaileController
                                    .suraDetaileApiData!.data!.chapter!.id !=
                                9
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal:
                                    Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: SizedBox(
                              width: double.infinity,
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                color: Theme.of(context).cardColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                    Images.Bismillah,
                                    height: 50,
                                    fit: BoxFit.fitHeight,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),

                    // list view section ==>
                    ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      shrinkWrap: true,
                      primary: false,
                      itemCount: suraDetaileController
                          .suraDetaileApiData!.data!.chapterInfo!.length,
                      itemBuilder: (context, index) {
                        var apiData = suraDetaileController
                            .suraDetaileApiData!.data!.chapterInfo![index];
                        return Column(
                          children: [
                            for (int i = 0; i < apiData.pageVerses!.length; i++)
                              SizedBox(
                                width: double.infinity,
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  color: Theme.of(context).cardColor,
                                  shadowColor: Get.isDarkMode
                                      ? Colors.grey[800]!
                                      : Colors.grey[200]!,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        // arabic ayah ==>
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Obx(
                                            () => SelectableText(
                                              apiData.pageVerses![i].arabicName
                                                  .toString(),
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.right,
                                              style: GoogleFonts.getFont(
                                                Get.find<
                                                        QuranSettingsController>()
                                                    .selectedFont
                                                    .value,
                                                fontSize: Get.find<
                                                        QuranSettingsController>()
                                                    .arabicFontSize
                                                    .value,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .color,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                            height:
                                                Dimensions.PADDING_SIZE_SMALL),

                                        // translation aysh ===>
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Obx(
                                            () => SelectableText(
                                              apiData
                                                  .pageVerses![i].translatedName
                                                  .toString(),
                                              textAlign: TextAlign.justify,
                                              style: robotoMedium.copyWith(
                                                fontSize: Get.find<
                                                        QuranSettingsController>()
                                                    .translateFontSize
                                                    .value,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                            height:
                                                Dimensions.PADDING_SIZE_SMALL),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // end ayah image
                                            Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  Images.Icon_End_Ayah,
                                                  height: 45,
                                                  fit: BoxFit.fill,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                Text(
                                                  apiData.pageVerses![i]
                                                      .versesNumber
                                                      .toString(),
                                                  style: robotoMedium.copyWith(
                                                    fontSize: Dimensions
                                                        .FONT_SIZE_SMALL,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .color,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            // bookmark & Share button
                                            Row(
                                              children: [
                                                // bookmark button

                                                GetBuilder<BookMarkController>(
                                                  init: BookMarkController(),
                                                  builder:
                                                      (bookMarkController) {
                                                    bool isIdExists = false;
                                                    var apiAyahId = int.parse(
                                                        "${suraDetaileController.suraDetaileApiData!.data!.chapter!.id}00${apiData.pageVerses![i].id}");

                                                    for (var book = 0;
                                                        book <
                                                            bookMarkController
                                                                .bookMarks
                                                                .length;
                                                        book++) {
                                                      if (apiAyahId ==
                                                          bookMarkController
                                                              .bookMarks[book]
                                                              .id) {
                                                        isIdExists = true;
                                                        break;
                                                      } else {
                                                        isIdExists = false;
                                                      }
                                                    }

                                                    return isIdExists == true
                                                        ? IconButton(
                                                            onPressed: () {
                                                              Get.snackbar(
                                                                "message".tr,
                                                                "already_added_in_your_bookmark"
                                                                    .tr,
                                                                colorText:
                                                                    Colors
                                                                        .white,
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            1),
                                                              );
                                                            },
                                                            icon: Icon(
                                                              Icons
                                                                  .check_circle_outline,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                            ))
                                                        : IconButton(
                                                            iconSize: 35,
                                                            onPressed: () {
                                                              var suraInfo =
                                                                  suraDetaileController
                                                                      .suraDetaileApiData!
                                                                      .data!;

                                                              final bookMark =
                                                                  BookMark(
                                                                id: int.parse(
                                                                    "${suraInfo.chapter!.id}00${apiData.pageVerses![i].id}"),
                                                                suraName: suraInfo
                                                                    .chapter!
                                                                    .translatedName
                                                                    .toString(),
                                                                serialNumber:
                                                                    suraInfo
                                                                        .chapter!
                                                                        .id
                                                                        .toString(),
                                                                versesNumber: apiData
                                                                    .pageVerses![
                                                                        i]
                                                                    .versesNumber
                                                                    .toString(),
                                                                arabicName: apiData
                                                                    .pageVerses![
                                                                        i]
                                                                    .arabicName
                                                                    .toString(),
                                                                translatedName: apiData
                                                                    .pageVerses![
                                                                        i]
                                                                    .translatedName
                                                                    .toString(),
                                                                pageNumber: suraInfo
                                                                    .chapterInfo![
                                                                        index]
                                                                    .pageNumber
                                                                    .toString(),
                                                              );
                                                              bookMarkController
                                                                  .insertBookMark(
                                                                      bookMark);
                                                            },
                                                            icon: SvgPicture
                                                                .asset(
                                                              Images
                                                                  .Icon_Bookmark,
                                                              height: 28,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                            ),
                                                          );
                                                  },
                                                ),

                                                // Share Ayah
                                                IconButton(
                                                  onPressed: () {
                                                    Share.share(
                                                        'Arabic Ayah: ${apiData.pageVerses![i].arabicName}\n\nTranslation: ${apiData.pageVerses![i].translatedName}\n\n\nSura Name: ${suraDetaileController.suraDetaileApiData!.data!.chapter!.translatedName}\nAyah Number: ${apiData.pageVerses![i].versesNumber}\nPowered By: ${AppConstants.APP_NAME}');
                                                  },
                                                  icon: SvgPicture.asset(
                                                    Images.Icon_Share,
                                                    height: 28,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(
                                height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                            // page number ==>
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                apiData.pageNumber.toString(),
                                textAlign: TextAlign.justify,
                                style: robotoMedium.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_LARGE,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color,
                                ),
                              ),
                            ),
                            const SizedBox(
                                height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          ],
                        );
                      },
                    )
                  ],
                );
        },
      ),
    );
  }
}
