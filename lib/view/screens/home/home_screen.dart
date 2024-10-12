// ignore_for_file: deprecated_member_use

import 'package:flutter_svg/svg.dart';
import 'package:zabi/controller/mosque_settings_controller.dart';
import 'package:zabi/controller/package_prayer_time_controller.dart';
import 'package:zabi/controller/todays_prayer_time_controller.dart';
import 'package:zabi/controller/quran_settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabi/helper/route_helper.dart';
import 'package:zabi/helper/salat_waqt_service.dart';
import 'package:zabi/helper/translator_helper.dart';
import 'package:zabi/util/dimensions.dart';
import 'package:zabi/util/images.dart';
import 'package:zabi/util/styles.dart';
import 'package:zabi/view/base/loading_indicator.dart';
import 'package:zabi/view/screens/home/widget/bannder_widget.dart';
import 'package:zabi/view/screens/home/widget/feature_item_widget.dart';
import 'package:zabi/view/screens/home/widget/ramadan_schedule_widget.dart';
import 'package:zabi/view/screens/home/widget/today_prayer_list_item.dart';

import '../../../controller/theme_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Get.put(QuranSettingsController(apiClient: Get.find()));
    Get.find<TodaysPrayerTimeController>().fetchTodaysPrayerTimeData();
    Get.find<MosqueSettingsController>().fetchMosqueSettingsData();
    Get.put(PackagePrayerTimeController()).getLocation();
    SalatWaqtService.initializeSalatWaqt();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MosqueSettingsController>(
      builder: (mosqueSettingsController) {
        return GetBuilder<TodaysPrayerTimeController>(
          builder: (todaysPrayerTimeController) {
            return GetBuilder<PackagePrayerTimeController>(
              builder: (packagePrayerTimeController) {
                var mosqueSettingsLoading =
                    mosqueSettingsController.isMosqueSettingsLoading.value;
                var packagePrayerTimeLoading =
                    packagePrayerTimeController.isLoading.value;
                var todaysPrayerTimeLoading =
                    todaysPrayerTimeController.isprayerTimeLoading.value;

                var mosqueSettingsApiData =
                    mosqueSettingsController.mosqueSettingsApiData;

                return Scaffold(
                  // AppBar Start===>
                  appBar: mosqueSettingsLoading ||
                          packagePrayerTimeLoading ||
                          todaysPrayerTimeLoading ||
                          mosqueSettingsController.mosqueSettingsApiData ==
                              null ||
                          todaysPrayerTimeController.todaysPrayerApiData == null
                      ? null
                      : AppBar(
                          backgroundColor: Get.isDarkMode
                              ? Theme.of(context).cardColor
                              : Theme.of(context).primaryColor,
                          elevation: 0,
                          centerTitle: false,
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                mosqueSettingsController
                                    .mosqueSettingsApiData!.data!.mosqueName
                                    .toString(),
                                style: robotoRegular.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_OVER_LARGE + 2,
                                  color: Get.isDarkMode
                                      ? null
                                      : Theme.of(context).cardColor,
                                ),
                              ),
                              Row(
                                children: [
                                  // Icon_Location image
                                  SvgPicture.asset(
                                    Images.Icon_Location,
                                    height: 14,
                                    fit: BoxFit.fill,
                                    color: Theme.of(context).hintColor,
                                  ),

                                  const SizedBox(width: 3),

                                  // address
                                  Expanded(
                                    child: Text(
                                      mosqueSettingsController
                                                  .mosqueSettingsApiData!
                                                  .data!
                                                  .automaticPayerTime ==
                                              true
                                          ? packagePrayerTimeController
                                              .currentAddress
                                              .toString()
                                          : mosqueSettingsController
                                              .mosqueSettingsApiData!
                                              .data!
                                              .mosqueAddress
                                              .toString(),
                                      style: robotoRegular.copyWith(
                                        fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          actions: [
                            IconButton(
                                onPressed: () {
                                  Get.toNamed(RouteHelper.donationTypeList);
                                },
                                icon: Get.isDarkMode
                                    ? SvgPicture.asset(
                                        Images.Icon_Donated,
                                        height: 28,
                                        fit: BoxFit.fill,
                                        color: Theme.of(context).primaryColor,
                                      )
                                    : SvgPicture.asset(
                                        Images.Icon_Donated,
                                        height: 28,
                                        fit: BoxFit.fill,
                                        color: Theme.of(context).cardColor,
                                      )),
                            IconButton(
                                 onPressed: () {
                                  Get.toNamed(RouteHelper.youTube);
                                },
                                icon: Get.isDarkMode
                                    ? SvgPicture.asset(
                                        Images.Icon_YT,
                                        height: 28,
                                        fit: BoxFit.fill,
                                        color: Theme.of(context).primaryColor,
                                      )
                                    : SvgPicture.asset(
                                        Images.Icon_YT,
                                        height: 28,
                                        fit: BoxFit.fill,
                                        color: Theme.of(context).cardColor,
                                      )),
                            IconButton(
                                onPressed: () {
                                  Get.toNamed(RouteHelper.alansaar);
                                },
                                icon: Get.isDarkMode
                                    ? SvgPicture.asset(
                                  Images.Icon_Al,
                                  height: 28,
                                  fit: BoxFit.fill,
                                  color: Theme.of(context).primaryColor,
                                )
                                    : SvgPicture.asset(
                                  Images.Icon_Al,
                                  height: 28,
                                  fit: BoxFit.fill,
                                  color: Theme.of(context).cardColor,
                                )),
                            IconButton(
                              tooltip: "light_or_dark_mode".tr,
                              icon: Get.isDarkMode
                                  ? SvgPicture.asset(
                                      Images.Icon_dark_mode,
                                      height: 25,
                                      fit: BoxFit.fill,
                                      color: Get.isDarkMode
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context).cardColor,
                                    )
                                  : SvgPicture.asset(
                                      Images.Icon_dark_mode,
                                      height: 25,
                                      fit: BoxFit.fill,
                                      color: Theme.of(context).cardColor,
                                    ),
                              onPressed: () {
                                Get.find<ThemeController>().toggleTheme();
                              },
                            ),
                          ],
                        ),
                  // Body Start===>
                  body: SafeArea(
                    child: mosqueSettingsLoading ||
                            packagePrayerTimeLoading ||
                            todaysPrayerTimeLoading ||
                            mosqueSettingsController.mosqueSettingsApiData ==
                                null ||
                            todaysPrayerTimeController.todaysPrayerApiData ==
                                null
                        ? SizedBox(
                            height: Get.height,
                            child: const Center(
                              child: LoadingIndicator(),
                            ),
                          )
                        : SingleChildScrollView(
                            physics: const ClampingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Banner Prayer Time Section
                                const BannerWidget(),
                                const SizedBox(
                                    height:
                                        Dimensions.PADDING_SIZE_EXTRA_SMALL),

                                // Sheri and iftar section =====>
                                mosqueSettingsApiData!.data!.ramadanSchedule ==
                                        true
                                    ? const Column(
                                        children: [
                                          RamadanScheduleWidget(),
                                          SizedBox(
                                              height: Dimensions
                                                  .PADDING_SIZE_EXTRA_SMALL),
                                        ],
                                      )
                                    : const SizedBox(),

                                //Todays prayer time section start
                                GetBuilder<PackagePrayerTimeController>(
                                  builder: (packagePrayerTimeController) {
                                    var todaysPrayerTimeData =
                                        todaysPrayerTimeController
                                            .todaysPrayerApiData!.data!;
                                    var isAutometicPrayerTimeOn =
                                        mosqueSettingsApiData
                                                .data!.automaticPayerTime ==
                                            true;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              Dimensions.PADDING_SIZE_DEFAULT),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            isAutometicPrayerTimeOn
                                                ? "${"todays_Prayer_Time_in".tr} ${packagePrayerTimeController.currentAddress}"
                                                : "todays_Prayer_Time".tr,
                                            textAlign: TextAlign.left,
                                            style: robotoRegular.copyWith(
                                              fontSize:
                                                  Dimensions.FONT_SIZE_LARGE,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                          const SizedBox(
                                              height: Dimensions
                                                  .PADDING_SIZE_SMALL),
                                          Column(
                                            children: [
                                              // fajr & sunrise start
                                              Row(
                                                children: [
                                                  // fajr start
                                                  TodaysprayerWidget(
                                                    iconImage: Images.Icon_Fajr,
                                                    prayerName: 'fajr'.tr,
                                                    adhan: translateText(
                                                        isAutometicPrayerTimeOn
                                                            ? packagePrayerTimeController
                                                                .fajrStartTime
                                                                .value
                                                            : todaysPrayerTimeData
                                                                .fajrAzan
                                                                .toString()),
                                                    jamah: translateText(
                                                        isAutometicPrayerTimeOn
                                                            ? packagePrayerTimeController
                                                                .fajrEndTime
                                                                .value
                                                            : todaysPrayerTimeData
                                                                .fajrJamat
                                                                .toString()),
                                                    isPrayerpackage:
                                                        isAutometicPrayerTimeOn,
                                                  ),
                                                  const SizedBox(
                                                      width: Dimensions
                                                          .PADDING_SIZE_DEFAULT),

                                                  // sunrise start
                                                  TodaysprayerWidget(
                                                    isSunrise: true,
                                                    iconImage: Images.Sunrise,
                                                    prayerName: 'sunrise'.tr,
                                                    sunriseStart: translateText(
                                                        isAutometicPrayerTimeOn
                                                            ? packagePrayerTimeController
                                                                .sunriseTime
                                                                .value
                                                            : todaysPrayerTimeData
                                                                .sunrise
                                                                .toString()),
                                                    jamah: "",
                                                    adhan: "",
                                                  ),
                                                ],
                                              ),

                                              const SizedBox(
                                                  height: Dimensions
                                                      .PADDING_SIZE_DEFAULT),

                                              // dhuhr and Asr start
                                              Row(
                                                children: [
                                                  // dhure
                                                  TodaysprayerWidget(
                                                    iconImage:
                                                        Images.Icon_Dhuhr,
                                                    prayerName:
                                                        todaysPrayerTimeData
                                                                    .isJumma ==
                                                                true
                                                            ? "jumuah".tr
                                                            : 'dhuhr'.tr,
                                                    adhan: translateText(
                                                        isAutometicPrayerTimeOn
                                                            ? packagePrayerTimeController
                                                                .dhuhrStartTime
                                                                .value
                                                            : todaysPrayerTimeData
                                                                .zuhrAzan
                                                                .toString()),
                                                    jamah: translateText(
                                                        isAutometicPrayerTimeOn
                                                            ? packagePrayerTimeController
                                                                .dhuhrEndTime
                                                                .value
                                                            : todaysPrayerTimeData
                                                                .zuhrJamat
                                                                .toString()),
                                                    isPrayerpackage:
                                                        isAutometicPrayerTimeOn,
                                                  ),
                                                  const SizedBox(
                                                      width: Dimensions
                                                          .PADDING_SIZE_DEFAULT),

                                                  // asr
                                                  TodaysprayerWidget(
                                                    iconImage: Images.Icon_Asr,
                                                    prayerName: 'asr'.tr,
                                                    adhan: translateText(
                                                        isAutometicPrayerTimeOn
                                                            ? packagePrayerTimeController
                                                                .asrStartTime
                                                                .value
                                                            : todaysPrayerTimeData
                                                                .asrAzan
                                                                .toString()),
                                                    jamah: translateText(
                                                        isAutometicPrayerTimeOn
                                                            ? packagePrayerTimeController
                                                                .asrEndTime
                                                                .value
                                                            : todaysPrayerTimeData
                                                                .asrJamat
                                                                .toString()),
                                                    isPrayerpackage:
                                                        isAutometicPrayerTimeOn,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                  height: Dimensions
                                                      .PADDING_SIZE_DEFAULT),

                                              // Magrib & Isha start
                                              Row(
                                                children: [
                                                  // magrib
                                                  TodaysprayerWidget(
                                                    iconImage:
                                                        Images.Icon_Maghrib,
                                                    prayerName: 'magrib'.tr,
                                                    adhan: translateText(
                                                        isAutometicPrayerTimeOn
                                                            ? packagePrayerTimeController
                                                                .maghribStartTime
                                                                .value
                                                            : todaysPrayerTimeData
                                                                .maghribAzan
                                                                .toString()),
                                                    jamah: translateText(
                                                        isAutometicPrayerTimeOn
                                                            ? packagePrayerTimeController
                                                                .maghribEndTime
                                                                .value
                                                            : todaysPrayerTimeData
                                                                .maghribJamat
                                                                .toString()),
                                                    isPrayerpackage:
                                                        isAutometicPrayerTimeOn,
                                                  ),
                                                  const SizedBox(
                                                      width: Dimensions
                                                          .PADDING_SIZE_DEFAULT),

                                                  // Isha
                                                  TodaysprayerWidget(
                                                    iconImage: Images.Icon_Isha,
                                                    prayerName: 'isha'.tr,
                                                    adhan: translateText(
                                                        isAutometicPrayerTimeOn
                                                            ? packagePrayerTimeController
                                                                .ishaStartTime
                                                                .value
                                                            : todaysPrayerTimeData
                                                                .ishaAzan
                                                                .toString()),
                                                    jamah: translateText(
                                                        isAutometicPrayerTimeOn
                                                            ? packagePrayerTimeController
                                                                .ishaEndTime
                                                                .value
                                                            : todaysPrayerTimeData
                                                                .ishaJamat
                                                                .toString()),
                                                    isPrayerpackage:
                                                        isAutometicPrayerTimeOn,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                    height: Dimensions.PADDING_SIZE_DEFAULT),

                                // Feature item section
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.PADDING_SIZE_DEFAULT),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical:
                                            Dimensions.PADDING_SIZE_DEFAULT),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.RADIUS_DEFAULT),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Get.isDarkMode
                                                ? Colors.grey[850]!
                                                : Colors.grey[200]!,
                                            spreadRadius: 1,
                                            blurRadius: 5)
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: Dimensions
                                              .PADDING_SIZE_GRID_SMALL),
                                      child: GridView.count(
                                        shrinkWrap: true,
                                        primary: false,
                                        crossAxisCount: 4,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        addAutomaticKeepAlives: false,
                                        children: [
                                          // dikir section ===>
                                          FeatureItemWidget(
                                            itemName: "dikir".tr,
                                            itemIconPath: Images.Icon_Dikir,
                                            onPressed: () {
                                              Get.toNamed(RouteHelper.dhikr);
                                            },
                                          ),

                                          // dua section ===>
                                          FeatureItemWidget(
                                            itemName: "dua".tr,
                                            itemIconPath: Images.Icon_Dua,
                                            onPressed: () {
                                              Get.toNamed(RouteHelper.dua);
                                            },
                                          ),

                                          // hadith section ===>
                                          FeatureItemWidget(
                                            itemName: "hadith".tr,
                                            itemIconPath: Images.Icon_Hadith,
                                            onPressed: () {
                                              Get.toNamed(
                                                  RouteHelper.hadithBookName);
                                            },
                                          ),

                                          // Allah name  section ===>
                                          FeatureItemWidget(
                                            itemName: "allah_name".tr,
                                            itemIconPath:
                                                Images.Icon_Allah_99_name,
                                            onPressed: () {
                                              Get.toNamed(
                                                  RouteHelper.sifatName);
                                            },
                                          ),

                                          // haram food section ===>
                                          FeatureItemWidget(
                                            itemName: "haram_codes".tr,
                                            itemIconPath: Images.Icon_Haram,
                                            onPressed: () {
                                              Get.toNamed(RouteHelper
                                                  .haramIngredientsFood);
                                            },
                                          ),

                                          // Zakat section ===>
                                          FeatureItemWidget(
                                            itemName: "zakat".tr,
                                            itemIconPath: Images.Icon_Zakat,
                                            onPressed: () {
                                              Get.toNamed(
                                                  RouteHelper.zakatCalculator);
                                            },
                                          ),

                                          // quibla section ===>
                                          FeatureItemWidget(
                                            itemName: "compass".tr,
                                            itemIconPath: Images.Icon_Qibla,
                                            onPressed: () {
                                              Get.toNamed(RouteHelper.compass);
                                            },
                                          ),

                                          // near by mosque section ===>
                                          FeatureItemWidget(
                                            itemName: "nearby".tr,
                                            itemIconPath:
                                                Images.Icon_near_mosque,
                                            onPressed: () {
                                              Get.toNamed(
                                                  RouteHelper.nearByMosque);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                    height: Dimensions.PADDING_SIZE_DEFAULT),
                              ],
                            ),
                          ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
