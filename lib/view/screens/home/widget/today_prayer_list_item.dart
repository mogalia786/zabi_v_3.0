// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:zabi/util/dimensions.dart';
import 'package:zabi/util/styles.dart';

class TodaysprayerWidget extends StatelessWidget {
  final String iconImage;
  final String prayerName;
  final String adhan;
  final String jamah;
  final bool? isSunrise;
  final String? sunriseStart;
  final bool? isPrayerpackage;

  const TodaysprayerWidget({
    super.key,
    required this.iconImage,
    required this.prayerName,
    required this.adhan,
    required this.jamah,
    this.isSunrise,
    this.sunriseStart,
    this.isPrayerpackage,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: Dimensions.PADDING_SIZE_DEFAULT),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
          boxShadow: [
            BoxShadow(
                color: Get.isDarkMode ? Colors.grey[850]! : Colors.grey[200]!,
                spreadRadius: 1,
                blurRadius: 5)
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // item icon
                SvgPicture.asset(
                  iconImage,
                  height: 28,
                  fit: BoxFit.fill,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                // prayer name
                Text(
                  prayerName,
                  textAlign: TextAlign.center,
                  style: robotoRegular.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Divider(color: Theme.of(context).hintColor.withOpacity(0.5)),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
              child: isSunrise == true
                  ? Column(
                      children: [
                        Text(
                          "start".tr,
                          style: robotoMedium.copyWith(
                              color: Theme.of(context).hintColor),
                        ),
                        Text(
                          isSunrise == true ? sunriseStart! : "",
                          style: robotoMedium.copyWith(
                              color: Theme.of(context).hintColor),
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              isPrayerpackage == true ? "start".tr : "adhan".tr,
                              style: robotoMedium.copyWith(
                                  color: Theme.of(context).hintColor),
                            ),
                            Text(
                              adhan,
                              style: robotoMedium.copyWith(
                                  color: Theme.of(context).hintColor),
                            )
                          ],
                        ),
                        Text(
                          "|",
                          style: robotoMedium.copyWith(
                              color: Theme.of(context).hintColor),
                        ),
                        Column(
                          children: [
                            Text(
                              isPrayerpackage == true ? "end".tr : "jamaat".tr,
                              style: robotoMedium.copyWith(
                                  color: Theme.of(context).hintColor),
                            ),
                            Text(
                              jamah,
                              style: robotoMedium.copyWith(
                                  color: Theme.of(context).hintColor),
                            )
                          ],
                        )
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
