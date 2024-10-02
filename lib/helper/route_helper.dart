import 'package:get/get.dart';
import 'package:zabi/view/base/bottom_navbar.dart';
import 'package:zabi/view/screens/compass/compass_screen.dart';
import 'package:zabi/view/screens/dhikr/local%20stroge%20dhikr/local_dhikr_add_screen.dart';
import 'package:zabi/view/screens/dhikr/api%20dhikr/dhikr_count_screen.dart';
import 'package:zabi/view/screens/dhikr/dhikr_screen.dart';
import 'package:zabi/view/screens/dua/dua_screen.dart';
import 'package:zabi/view/screens/dua/api%20dua/api_dua_view_screen.dart';
import 'package:zabi/view/screens/dua/local%20stroge%20dua/local_dhikr_add_screen.dart';
import 'package:zabi/view/screens/hadith/all_hadith_screen.dart';
import 'package:zabi/view/screens/hadith/hadis_book_name_screen.dart';
import 'package:zabi/view/screens/hadith/hadith_chapters_screen.dart';
import 'package:zabi/view/screens/hadith/hadith_details_screen.dart';
import 'package:zabi/view/screens/haram_ingredients_food/haram_food_detaile_info.dart';
import 'package:zabi/view/screens/haram_ingredients_food/haram_ingredients_food.dart';
import 'package:zabi/view/screens/home/home_screen.dart';
import 'package:zabi/view/screens/nearby_mosque/nearby_mosque_screen.dart';
import 'package:zabi/view/screens/payment/donation_type_screen.dart';
import 'package:zabi/view/screens/payment/payment_type_screen.dart';
import 'package:zabi/view/screens/quran/sura_detaile_screen.dart';
import 'package:zabi/view/screens/quran/sura_list_screen.dart';
import 'package:zabi/view/screens/settings/settings_screen.dart';
import 'package:zabi/view/screens/sifat_name/sifat_name_details_screen.dart';
import 'package:zabi/view/screens/sifat_name/sifat_name_screen.dart';
import 'package:zabi/view/screens/splash/splash_screen.dart';
import 'package:zabi/view/screens/zakat/zakat_calculator.dart';
import 'package:zabi/view/screens/zakat/zakat_detaile.dart';

import '../view/screens/payment/donated_list.dart';

class RouteHelper {
  static String initial = "/";
  static String home = "/home";
  static String bottomNavbar = "/bottomNavbar";
  static String dhikr = "/dhikr";
  static String dhikrCount = "/dhikrCount";
  static String addDhikr = "/addDhikr";
  static String compass = "/Compass";
  static String nearByMosque = "/nearByMosque";
  static String dua = "/dua";
  static String duaView = "/duaView";
  static String sifatName = "/sifatName";
  static String sifatNameDetaile = "/sifatNameDetaile";
  static String hadithChapters = "/hadithChapters";
  static String allHadith = "/allHadith";
  static String hadithDetails = "/hadithDetails";
  static String hadithBookName = "/hadithBookName";
  static String haramIngredientsFood = "/haramIngredientsFood";
  static String haramFoodDetaile = "/haramFoodDetaile";
  static String zakatCalculator = "/zakatCalculator";
  static String zakatDetaile = "/zakatDetaile";
  static String suraList = "/suraList";
  static String suraDetaile = "/suraDetaile";
  static String duaAdd = "/duaAdd";
  static String settings = "/settings";
  static String userDonatedList = "/userDonatedList";
  static String donationTypeList = "/donationTypeList";
  static String paymentType = "/paymentType";

  static String getInitialRoute() => initial;
  static String getHomeRoute() => home;
  static String getBottomNavbarRoute() => bottomNavbar;
  static String getDhikrRoute() => dhikr;
  static String getDhikrCountRoute() => dhikrCount;
  static String getAddDhikrRoute() => addDhikr;
  static String getCompassRoute() => compass;
  static String getNearByMosqueRoute() => compass;
  static String getDuaRoute() => dua;
  static String getDuaViewRoute() => duaView;
  static String getSifatNameRoute() => sifatName;
  static String getSifatNameDetaileRoute() => sifatNameDetaile;
  static String getHadithChaptersRoute() => hadithChapters;
  static String getAllHadithRoute() => allHadith;
  static String getHadithDetailsRoute() => hadithDetails;
  static String getHadithBookNameRoute() => hadithBookName;
  static String getHaramIngredientsFoodPageRoute() => haramIngredientsFood;
  static String getHaramFoodDetailepageRoute() => haramFoodDetaile;
  static String getZakatCalculatorPageRoute() => zakatCalculator;
  static String getZakatDetailePageRoute() => zakatDetaile;
  static String getSuraListPageRoute() => suraList;
  static String getSuraDetailePageRoute() => suraDetaile;
  static String getDuaAddPageRoute() => duaAdd;
  static String getSettingsPageRoute() => settings;
   static String getDonationListPageRoute(String value) => "$userDonatedList?value=$value";
  static String getDonationTypeListPageRoute() => donationTypeList;
  static String getPaymentTypeListPageRoute() => paymentType;

  static List<GetPage> routes = [
    GetPage(
        name: initial,
        page: () => const SplashScreen(),
        transition: Transition.cupertinoDialog),
    GetPage(
        name: home,
        page: () => const HomeScreen(),
        transition: Transition.cupertinoDialog),
    GetPage(
        name: bottomNavbar,
        page: () => const BottomNavbarScreen(),
        transition: Transition.cupertinoDialog),
    GetPage(
        name: dhikr,
        page: () => const DhikrScreen(
              appBackButton: true,
            ),
        transition: Transition.cupertinoDialog),
    GetPage(
        name: dhikrCount,
        page: () => const DhikrCountScreen(
              appBackButton: true,
            ),
        transition: Transition.cupertinoDialog),
    GetPage(
        name: addDhikr,
        page: () => LocalDhikrAddScreen(
              appBackButton: true,
            ),
        transition: Transition.cupertinoDialog),
    GetPage(
        name: compass,
        page: () => const CompassScreen(
              appBackButton: true,
            ),
        transition: Transition.cupertinoDialog),
    GetPage(
        name: nearByMosque,
        page: () => const NearbyMosque(
              appBackButton: true,
            ),
        transition: Transition.cupertinoDialog),
    GetPage(
        name: dua,
        page: () => const DuaScreen(
              appBackButton: true,
            ),
        transition: Transition.cupertinoDialog),
    GetPage(
        name: duaView,
        page: () => const DuasViewScreen(
              appBackButton: true,
            ),
        transition: Transition.cupertinoDialog),
    GetPage(
        name: sifatName,
        page: () => const SifatNameScreen(
              appBackButton: true,
            ),
        transition: Transition.cupertinoDialog),
    GetPage(
        name: sifatNameDetaile,
        page: () => const SifatNameDetailsScreen(
              appBackButton: true,
            ),
        transition: Transition.cupertinoDialog),
    GetPage(
        name: hadithChapters,
        page: () => const HadithChaptersScreen(
              appBackButton: true,
            ),
        transition: Transition.cupertinoDialog),
    GetPage(
        name: allHadith,
        page: () => const AllHadithScreen(
              appBackButton: true,
            ),
        transition: Transition.cupertinoDialog),
    GetPage(
        name: hadithDetails,
        page: () => HadithDetailsScreen(
              appBackButton: true,
            ),
        transition: Transition.cupertinoDialog),
    GetPage(
        name: hadithBookName,
        page: () => HadisBookNameScreen(
              appBackButton: true,
            ),
        transition: Transition.cupertinoDialog),
    GetPage(
        name: haramIngredientsFood,
        page: () => const HaramIngredientsFood(
              appBackButton: true,
            ),
        transition: Transition.cupertinoDialog),
    GetPage(
        name: haramFoodDetaile,
        page: () => const HaramFoodDetaileInfoScreen(
              appBackButton: true,
            ),
        transition: Transition.cupertinoDialog),
    GetPage(
        name: zakatCalculator,
        page: () => const ZakatCalculator(
              appBackButton: true,
            ),
        transition: Transition.cupertinoDialog),
    GetPage(
        name: zakatDetaile,
        page: () => const ZakatDetaile(
              appBackButton: true,
            ),
        transition: Transition.cupertinoDialog),
    GetPage(
        name: suraList,
        page: () => const SuraList(
              appBackButton: true,
            ),
        transition: Transition.cupertinoDialog),
    GetPage(
        name: suraDetaile,
        page: () => const SuraDetaileScreen(
              appBackButton: true,
            ),
        transition: Transition.cupertinoDialog),
    GetPage(
        name: duaAdd,
        page: () => LocalDuaAddScreen(
              appBackButton: true,
            ),
        transition: Transition.cupertinoDialog),
    GetPage(
        name: settings,
        page: () => const SettingsScreen(
              appBackButton: true,
            ),
        transition: Transition.cupertinoDialog),
    GetPage(
        name: userDonatedList,
        page: () => UserDonateScreen(
          appBackButton: true,
          value: Get.parameters['value'] ?? '1',
            ),

        transition: Transition.cupertinoDialog),
    GetPage(
        name: donationTypeList,
        page: () => const DonationTypeScreen(
              appBackButton: true,
            ),
        transition: Transition.cupertinoDialog),
    GetPage( 
        name: paymentType,
        page: () =>  PaymentTypeScreen(
              appBackButton: true,
            ),
        transition: Transition.cupertinoDialog),
  ];
}
