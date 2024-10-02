import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zabi/controller/dua_details_controller.dart';
import 'package:zabi/controller/dua_list_controller.dart';
import 'package:zabi/controller/quran_settings_controller.dart';
import 'package:zabi/helper/route_helper.dart';
import 'package:zabi/util/dimensions.dart';
import 'package:zabi/util/styles.dart';
import 'package:zabi/view/base/loading_indicator.dart';

class ApiDuaListWidgets extends StatelessWidget {
  const ApiDuaListWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DuaListController>(
      builder: (duaListController) {
        return duaListController.isDuaListLoading.value ||
                duaListController.duaApiData == null
            ? const Center(
                child: LoadingIndicator(),
              )
            : duaListController.duaApiData!.data!.isEmpty
                ? Center(
                    child: Text(
                      "no_data_found".tr,
                      style: robotoMedium.copyWith(
                          fontSize: Dimensions.FONT_SIZE_LARGE),
                    ),
                  )
                : SingleChildScrollView(
                    child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      itemCount: duaListController.duaApiData!.data!.length,
                      itemBuilder: (context, index) {
                        var apiData = duaListController.duaApiData!.data![index];
                        return GestureDetector(
                          onTap: () {
                            var duaDetailsController =
                                Get.find<DuaDetailsController>();
                            duaDetailsController.fetchDuaDetailsData(
                                duaId: apiData.id.toString());

                            Get.toNamed(RouteHelper.duaView);
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
                              title: Text(
                                apiData.enShortName.toString(),
                                style: robotoMedium.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_LARGE),
                              ),
                              subtitle: Text(
                                apiData.arShortName.toString(),
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
                        );
                      },
                    ),
                  );
      },
    );
  }
}
