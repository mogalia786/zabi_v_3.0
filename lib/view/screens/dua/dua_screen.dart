import 'package:zabi/controller/dua_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabi/helper/route_helper.dart';
import 'package:zabi/view/base/custom_app_bar.dart';
import 'package:zabi/view/base/tabbar_button.dart';
import 'package:zabi/view/screens/dua/api%20dua/api_dua_list_widget.dart';
import 'package:zabi/view/screens/dua/local%20stroge%20dua/user_added_dua_list_widget.dart';
import '../../../util/dimensions.dart';

class DuaScreen extends StatelessWidget {
  final bool appBackButton;
  const DuaScreen({super.key, required this.appBackButton});

  @override
  Widget build(BuildContext context) {
    Get.find<DuaListController>().fetchDuaListData();
    return Scaffold(
      // Appbar start ===>
      appBar: CustomAppBar(
        title: "all_duas".tr,
        isBackButtonExist: appBackButton == true ? true : false,
        actions: [
          IconButton(
            tooltip: "add_dua".tr,
            onPressed: () {
              Get.toNamed(RouteHelper.duaAdd);
            },
            icon: Icon(
              Icons.playlist_add,
              color: Get.isDarkMode
                  ? Theme.of(context).textTheme.bodyMedium!.color
                  : Theme.of(context).cardColor,
            ),
          ),
        ],
      ),

      // body start ===>
      body: GetBuilder<DuaListController>(
        builder: (duaListController) {
          return DefaultTabController(
            length: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // tabbar start
                TabBar(
                  dividerColor: Theme.of(context).scaffoldBackgroundColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                    vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                  ),
                  labelPadding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  isScrollable: false,
                  indicator: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius:
                        BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  ),
                  tabs: [
                    tabBarButton('dua'.tr, context),
                    tabBarButton('added_dua'.tr, context),
                  ],
                ),
                // tabbar view
                Expanded(
                  child: TabBarView(
                    children: [
                      // api dua list
                      const ApiDuaListWidgets(),

                      // local stroge dua list
                      UserAddedDuaWidget(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
