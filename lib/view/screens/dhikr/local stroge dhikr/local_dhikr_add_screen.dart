// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabi/view/base/custom_app_bar.dart';
import 'package:zabi/view/base/my_text_field.dart';
import 'package:zabi/controller/local_dhikr_controller.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/styles.dart';
import '../../../base/custom_button.dart';

class LocalDhikrAddScreen extends StatelessWidget {
  final bool appBackButton;
  LocalDhikrAddScreen({super.key, required this.appBackButton});

  final addDhikrformKey = GlobalKey<FormState>();
  final TextEditingController englishNameController = TextEditingController();
  final TextEditingController arabicNameController = TextEditingController();
  final TextEditingController englishDescriptionController =
      TextEditingController();
  final TextEditingController arabicDescriptionController =
      TextEditingController();
  final LocalDhikrController localDhikrController =
      Get.put(LocalDhikrController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar start ===>
      appBar: CustomAppBar(
        title: "add_your_dhikr".tr,
        isBackButtonExist: appBackButton == true ? true : false,
      ),

      // body start ==>
      body: Form(
        key: addDhikrformKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          children: [
            const SizedBox(height: 20),

            // english tile text field ===>
            TextFormField(
              controller: englishNameController,
              style:
                  robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
              decoration: getTextInputDecoration(context).copyWith(
                filled: true,
                focusColor: Colors.white,
                hintText: "dhikr_name_english".tr,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'this_field_must_not_be_empty'.tr;
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 20),

            // arabic tile text field ===>
            TextFormField(
              controller: arabicNameController,
              style:
                  robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT),
              decoration: getTextInputDecoration(context).copyWith(
                filled: true,
                focusColor: Colors.white,
                hintText: "dhikr_name_arabic_optional".tr,
              ),
              validator: (value) {
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),

            // english discription text field ===>
            TextFormField(
              maxLines: 3,
              controller: englishDescriptionController,
              style:
                  robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT),
              decoration: getTextInputDecoration(context).copyWith(
                filled: true,
                focusColor: Colors.white,
                hintText: "dhikr_english".tr,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'this_field_must_not_be_empty'.tr;
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 20),
            // arabic discription text field ===>
            TextFormField(
              maxLines: 3,
              controller: arabicDescriptionController,
              style:
                  robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT),
              decoration: getTextInputDecoration(context).copyWith(
                filled: true,
                focusColor: Colors.white,
                hintText: "dhikr_arabic_optional".tr,
              ),
              validator: (value) {
                return null;
              },
            ),
            const SizedBox(
              height: 40,
            ),

            // submit buttion ==>
            CustomButton(
              buttonWidth: Get.width,
              buttonName: "add_dhikr".tr,
              onPressed: () async {
                if (addDhikrformKey.currentState!.validate()) {
                  localDhikrController.addDhikr(
                    englishNameController.text,
                    arabicNameController.text,
                    englishDescriptionController.text,
                    arabicDescriptionController.text,
                  );
                  addDhikrformKey.currentState!.reset();
                  Get.snackbar("message".tr, "dikir_add_successfully".tr,
                      colorText: Theme.of(context).indicatorColor);
                  Get.put(LocalDhikrController());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
