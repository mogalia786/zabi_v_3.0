// ignore_for_file: deprecated_member_use

import 'package:zabi/controller/quran_settings_controller.dart';
import 'package:zabi/controller/sura_detaile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zabi/util/dimensions.dart';
import 'package:zabi/util/images.dart';
import 'package:zabi/util/styles.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../base/loading_indicator.dart';

class ArabicQuranWidget extends StatelessWidget {
  const ArabicQuranWidget({super.key});

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
                    Column(
                      children: [
                        // list view start ==>
                        ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: suraDetaileController
                              .suraDetaileApiData!.data!.chapterInfo!.length,
                          itemBuilder: (context, index) {
                            var apiData = suraDetaileController
                                .suraDetaileApiData!.data!.chapterInfo![index];
                            return Column(
                              children: [
                                // ayah content and frame ==>
                                Container(
                                  padding: Get.find<QuranSettingsController>()
                                              .arabicFontSize
                                              .value <=
                                          25
                                      ? const EdgeInsets.all(
                                          Dimensions.PADDING_SIZE_SMALL + 5)
                                      : const EdgeInsets.all(
                                          Dimensions.PADDING_SIZE_SMALL + 20),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    image: const DecorationImage(
                                      image: AssetImage(Images.Quran_Frame),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: Obx(
                                    () => Align(
                                      alignment: Alignment.centerRight,
                                      child: Column(
                                        children: [
                                          // arabic ayah text ==>
                                          SelectableText(
                                            apiData.pageArabicAyah.toString(),
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.center,
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
                                          const SizedBox(
                                              height: Dimensions
                                                  .PADDING_SIZE_DEFAULT),

                                          // page number
                                          SelectableText(
                                            apiData.pageNumber.toString(),
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.center,
                                            style: robotoMedium.copyWith(
                                              color: Get.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Divider(),
                                const SizedBox(height: 5),
                              ],
                            );
                          },
                        ),
                      ],
                    )
                  ],
                );
        },
      ),
    );
  }
}
