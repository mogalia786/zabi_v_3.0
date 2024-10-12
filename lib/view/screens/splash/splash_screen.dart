import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabi/controller/splash_controller.dart';
import 'package:zabi/util/app_constants.dart';
import 'package:zabi/util/dimensions.dart';
import 'package:zabi/util/images.dart';
import 'package:zabi/util/styles.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<SplashController>().navigator();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // logo image
            Image.asset(
              Get.isDarkMode ? Images.Dark_APP_LOGO : Images.Light_APP_LOGO,
              height: 80,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

            // app name
            Text(
              AppConstants.APP_NAME,
              textAlign: TextAlign.center,
              style: robotoMedium.copyWith(
                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
