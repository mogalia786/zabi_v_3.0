// ignore_for_file: deprecated_member_use

import 'package:zabi/controller/quran_settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zabi/controller/sura_detaile_controller.dart';
import 'package:zabi/controller/sura_list_controller.dart';
import 'package:zabi/helper/route_helper.dart';
import 'package:zabi/util/dimensions.dart';
import 'package:zabi/util/images.dart';
import 'package:zabi/util/styles.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../base/loading_indicator.dart';

class SuraListWidget extends StatelessWidget {
  const SuraListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<SuraListController>().fetchSuraListData();
    return GetBuilder<SuraListController>(
      builder: (suraListController) {
        return suraListController.isSuraListLoading.value ||
                suraListController.suraListApiData == null
            ? const Center(
                child: LoadingIndicator(),
              )
            : ListView.builder(
                primary: false,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_SMALL),
                itemCount: suraListController.suraListApiData!.data!.length,
                itemBuilder: (context, index) {
                  var apiData =
                      suraListController.suraListApiData!.data![index];
                  return GestureDetector(
                    onTap: () {
                      Get.find<SuraDetaileController>().suraNumber =
                          apiData.id.toString();
                      Get.find<SuraDetaileController>()
                          .fetchSuraDetaileData(suraId: apiData.id.toString());
                      Get.toNamed(RouteHelper.suraDetaile);
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      color: Theme.of(context).cardColor,
                      shadowColor: Get.isDarkMode
                          ? Colors.grey[800]!
                          : Colors.grey[200]!,
                      child: ListTile(
                        contentPadding: const EdgeInsetsDirectional.only(
                            start: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                            end: Dimensions.PADDING_SIZE_SMALL),
                        leading: Stack(
                          alignment: Alignment.center,
                          children: [
                            SvgPicture.asset(
                              Images.Icon_Star,
                              height: 50,
                              fit: BoxFit.fill,
                              color: Theme.of(context).primaryColor,
                            ),
                            Text(
                              apiData.serialNumber.toString(),
                              style: robotoMedium.copyWith(
                                fontSize: Dimensions.FONT_SIZE_SMALL,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color,
                              ),
                            ),
                          ],
                        ),
                        title: Obx(
                          () => Text(
                            apiData.translateName.toString(),
                            style: robotoMedium.copyWith(
                              fontSize: Get.find<QuranSettingsController>()
                                  .translateFontSize
                                  .value,
                            ),
                          ),
                        ),
                        subtitle: Obx(
                          () => Text(
                            "${apiData.versesTranslateName}: ${apiData.versesCount}",
                            style: robotoMedium.copyWith(
                              fontSize: Get.find<QuranSettingsController>()
                                      .translateFontSize
                                      .value -
                                  3,
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                          ),
                        ),
                        trailing: Obx(
                          () => Text(
                            apiData.arabicName.toString(),
                            style: GoogleFonts.getFont(
                              Get.find<QuranSettingsController>()
                                  .selectedFont
                                  .value,
                              fontSize: Get.find<QuranSettingsController>()
                                  .arabicFontSize
                                  .value,
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
