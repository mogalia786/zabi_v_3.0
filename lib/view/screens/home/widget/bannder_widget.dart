// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:zabi/controller/mosque_settings_controller.dart';
import 'package:zabi/controller/package_prayer_time_controller.dart';
import 'package:zabi/controller/todays_prayer_time_controller.dart';
import 'package:zabi/helper/translator_helper.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final PackagePrayerTimeController packagePrayerTimeController =
        Get.put(PackagePrayerTimeController());
    return GetBuilder<TodaysPrayerTimeController>(
      builder: (prayerTimeController) {
        return GetBuilder<MosqueSettingsController>(
          builder: (mosqueSettingsController) {
            var isAutometicPrayerTimeOn = mosqueSettingsController
                    .mosqueSettingsApiData!.data!.automaticPayerTime ==
                true;
            return Obx(() {
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Get.isDarkMode
                      ? Theme.of(context).cardColor
                      : Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft:
                        Radius.circular(Dimensions.PADDING_SIZE_DEFAULT),
                    bottomRight:
                        Radius.circular(Dimensions.PADDING_SIZE_DEFAULT),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: Dimensions.PADDING_SIZE_DEFAULT,
                    right: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  child: Column(
                    children: [
                      // Next jama'ah section
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  isAutometicPrayerTimeOn
                                      ? "next_prayer".tr
                                      : "next_jamaat".tr,
                                  style: robotoRegular.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                const SizedBox(
                                    height:
                                        Dimensions.PADDING_SIZE_EXTRA_SMALL),

                                // wakt time and name
                                Row(
                                  children: [
                                    Text(
                                      isAutometicPrayerTimeOn
                                          ? "${packagePrayerTimeController.waqtName.value} "
                                          : "${prayerTimeController.currentWaqtName} ",
                                      style: robotoRegular.copyWith(
                                        fontSize:
                                            Dimensions.FONT_SIZE_OVER_LARGE + 2,
                                        fontWeight: FontWeight.bold,
                                        color: Get.isDarkMode
                                            ? null
                                            : Theme.of(context).cardColor,
                                      ),
                                    ),
                                    Container(
                                        height: 20,
                                        width: 0.5,
                                        color: Theme.of(context).hintColor),
                                    Text(
                                      isAutometicPrayerTimeOn
                                          ? translateText(
                                              " ${packagePrayerTimeController.waqtTime.value}")
                                          : translateText(
                                              " ${prayerTimeController.currentJamahTime}"),
                                      style: robotoRegular.copyWith(
                                        fontSize:
                                            Dimensions.FONT_SIZE_OVER_LARGE + 2,
                                        fontWeight: FontWeight.bold,
                                        color: Get.isDarkMode
                                            ? null
                                            : Theme.of(context).cardColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                    height:
                                        Dimensions.PADDING_SIZE_EXTRA_LARGE),

                                // today's date

                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: Dimensions.FONT_SIZE_DEFAULT),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // calender image
                                      SvgPicture.asset(
                                        Images.Icon_Calender,
                                        color: Theme.of(context).hintColor,
                                        height: 20,
                                        fit: BoxFit.fill,
                                      ),
                                      const SizedBox(
                                          width: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // english date
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                    color: Theme.of(context)
                                                        .hintColor
                                                        .withOpacity(0.8),
                                                    width: .6),
                                              ),
                                            ),
                                            child: Text(
                                              translateText(DateFormat.yMMMEd()
                                                  .format(DateTime.now())),
                                              style: robotoRegular.copyWith(
                                                fontSize: Dimensions
                                                    .FONT_SIZE_DEFAULT,
                                                color:
                                                    Theme.of(context).hintColor,
                                              ),
                                            ),
                                          ),
                                          // arabic date
                                          Text(
                                            translateText(
                                                "${HijriCalendar.fromDate(DateTime.now()).toFormat('dd MMMM yyyy')} "),
                                            style: robotoRegular.copyWith(
                                              fontSize:
                                                  Dimensions.FONT_SIZE_DEFAULT,
                                              color:
                                                  Theme.of(context).hintColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FadeInImage(
                            placeholderFilterQuality: FilterQuality.none,
                            image: NetworkImage(mosqueSettingsController
                                .mosqueSettingsApiData!.data!.appLogo
                                .toString()),
                            placeholder: Get.isDarkMode
                                ? const AssetImage(
                                    Images.Dark_primary,
                                  )
                                : const AssetImage(Images.Light_primary),
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                Images.Banner_Image,
                                fit: BoxFit.fill,
                                height: 130,
                                width: 170,
                              );
                            },
                            fit: BoxFit.fill,
                            height: 130,
                            width: 170,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });
          },
        );
      },
    );
  }
}
