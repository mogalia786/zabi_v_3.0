// ignore_for_file: deprecated_member_use

import 'package:zabi/controller/quran_settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zabi/controller/sifat_name_details_controller.dart';
import 'package:zabi/view/base/custom_app_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zabi/view/base/loading_indicator.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/styles.dart';

class SifatNameDetailsScreen extends StatelessWidget {
  final bool appBackButton;
  const SifatNameDetailsScreen({Key? key, required this.appBackButton})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SifatNameDetailsController>(
      builder: (sifatNameDetailsController) {
        var apiData = sifatNameDetailsController.sifatnameDetailsApidata;
        return Scaffold(
          // Appbar start ===>
          appBar: CustomAppBar(
            title: sifatNameDetailsController.isSifatNameDetailsLoading.value ||
                    sifatNameDetailsController.sifatnameDetailsApidata == null
                ? "--"
                : apiData!.data!.enName.toString(),
            isBackButtonExist: appBackButton == true ? true : false,
          ),

          // body start===>
          body: sifatNameDetailsController.isSifatNameDetailsLoading.value ||
                  sifatNameDetailsController.sifatnameDetailsApidata == null
              ? const Center(
                  child: LoadingIndicator(),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                        vertical: Dimensions.PADDING_SIZE_DEFAULT),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // bismillah image
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: SvgPicture.asset(
                            Images.Bismillah,
                            height: 50,
                            fit: BoxFit.fitHeight,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(),

                        // english name ==>
                        Center(
                          child: Text(
                            apiData!.data!.enName.toString(),
                            style: robotoMedium.copyWith(
                                fontSize: Dimensions.FONT_SIZE_DEFAULT),
                          ),
                        ),
                        const Divider(),
                        const SizedBox(height: 30),

                        // arabic name ==>
                        Center(
                          child: Text(
                            apiData.data!.arName.toString(),
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
                        const SizedBox(height: 30),
                        const Divider(),

                        // name title ===>
                        Center(
                          child: Text(
                            apiData.data!.translatedName.toString(),
                            textAlign: TextAlign.center,
                            style: robotoMedium.copyWith(
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                              color:
                                  Theme.of(context).textTheme.bodyMedium!.color,
                            ),
                          ),
                        ),
                        const Divider(),

                        // meaning ===>
                        Text(
                          "meaning".tr,
                          textAlign: TextAlign.start,
                          style: robotoMedium.copyWith(
                              fontSize: Dimensions.FONT_SIZE_OVER_LARGE),
                        ),
                        const SizedBox(height: 10),

                        // name meaning ===>
                        Text(
                          apiData.data!.meaning.toString(),
                          textAlign: TextAlign.justify,
                          style: robotoMedium.copyWith(
                            fontSize: Dimensions.FONT_SIZE_DEFAULT,
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                        ),

                        const Divider(),

                        // meaning ===>
                        Text(
                          "benefits".tr,
                          textAlign: TextAlign.start,
                          style: robotoMedium.copyWith(
                              fontSize: Dimensions.FONT_SIZE_OVER_LARGE),
                        ),
                        const SizedBox(height: 10),

                        // name meaning ===>
                        Text(
                          apiData.data!.nameBenefits.toString(),
                          textAlign: TextAlign.justify,
                          style: robotoMedium.copyWith(
                            fontSize: Dimensions.FONT_SIZE_DEFAULT,
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
