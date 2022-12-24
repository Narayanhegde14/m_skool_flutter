import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:m_skool_flutter/screens/splash_screen.dart';
import 'package:path_provider/path_provider.dart';

import 'config/localization/localization_services.dart';
import 'config/themes/theme_data.dart';
import 'controller/theme_controller.dart';

class MyFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}

ThemeController themeData = Get.put(ThemeController());
Box? themeBox;
Box? localeServiceBox;
Box? logInBox;
Box? cookieBox;
Box? profileBox;
Box? institutionalCode;
Box? institutionalCookie;
Box? importantIds;

Logger logger =
    Logger(printer: PrettyPrinter(methodCount: 0), filter: MyFilter());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // debugPaintSizeEnabled = true;
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  themeBox = await Hive.openBox("themeData");
  localeServiceBox = await Hive.openBox("language");
  logInBox = await Hive.openBox("login");
  Hive.openBox("cookie").then((value) => cookieBox = value);
  Hive.openBox("institutionalCode").then((value) => institutionalCode = value);
  Hive.openBox("insCookie").then((value) => institutionalCookie = value);
  importantIds = await Hive.openBox("commonCodes");

  profileBox = await Hive.openBox("profileData");
  if (themeBox!.get("isLightMode") != null) {
    themeData.isLightMode.value = themeBox!.get("isLightMode");
  } else {
    await themeBox!.put(
      "isLightMode",
      themeData.isLightMode.value,
    );
  }
  // LocationController().requestLocationPermission();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            darkTheme:
                CustomThemeData().getThemeData(themeData.isLightMode.value),
            theme: CustomThemeData().getThemeData(themeData.isLightMode.value),
            translations: LocalizationService(),
            locale: LocalizationService().getCurrentLocale(),
            fallbackLocale: const Locale(
              'en',
              'US',
            ),
            home: const SplashScreen(),
            // home: (logInBox!.get("isLoggedIn") == null ||
            //         !logInBox!.get("isLoggedIn"))
            //     ? const Home() //const Authentication()
            //     : const Home(),
            builder: (context, child) {
              return MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaleFactor: 1.0,
                  ),
                  child: child!);
            },
          ),
        );
      },
    );
  }
}
