import 'package:zabi/controller/dikir_list_controller.dart';
import 'package:zabi/util/dimensions.dart';
import 'package:zabi/view/base/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabi/view/base/tabbar_button.dart';
import 'package:zabi/view/screens/dhikr/api%20dhikr/api_dikir_widget.dart';
import 'package:zabi/view/screens/dhikr/local%20stroge%20dhikr/user_added_dikir_list_widget.dart';
import '../../../helper/route_helper.dart';

class DhikrScreen extends StatefulWidget {
  final bool appBackButton;
  const DhikrScreen({Key? key, required this.appBackButton}) : super(key: key);

  @override
  State<DhikrScreen> createState() => _DhikrScreenState();
}

class _DhikrScreenState extends State<DhikrScreen> {
  @override
  void initState() {
    Get.find<DikirListController>().fetchDikirListData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DikirListController>(
      builder: (dikirListController) {
        return Scaffold(
          // Appbar start ===>
          appBar: CustomAppBar(
            title: "all_dhikr".tr,
            isBackButtonExist: widget.appBackButton == true ? true : false,
            actions: [
              IconButton(
                tooltip: "add_dikir".tr,
                onPressed: () {
                  Get.toNamed(RouteHelper.addDhikr);
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

          // body statr ==>
          body: DefaultTabController(
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
                    tabBarButton('dhikr'.tr, context),
                    tabBarButton('added_dhikr'.tr, context),
                  ],
                ),
                // tabbar view
                Expanded(
                  child: TabBarView(
                    children: [
                      // api dhikr list
                      const ApiDikirWidget(),

                      // local stroge dhikr list
                      UserAddedDikirWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
