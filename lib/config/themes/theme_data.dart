import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomThemeData {
  ThemeData? getThemeData(isLightMode) {
    return isLightMode
        ? ThemeData(
            colorScheme: const ColorScheme(
              brightness: Brightness.light,
              primary: Color(0xff08A74A),
              onPrimary: Colors.black,
              secondary: Color(0xFFDFEFFD),
              onSecondary: Colors.white,
              error: Colors.red,
              onError: Colors.white,
              background: Colors.white,
              onBackground: Colors.black,
              surface: Colors.white,
              onSurface: Color(0xff525252),
            ),
            primaryColor: const Color(0xff08A74A),
            textTheme: TextTheme(
              titleSmall: GoogleFonts.roboto(
                fontSize: 15,
                color: Colors.black54,
                textStyle: const TextStyle(
                  overflow: TextOverflow.visible,
                ),
              ),
              titleMedium: GoogleFonts.roboto(
                fontSize: 17,
                //color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              titleLarge: GoogleFonts.roboto(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
              labelSmall: GoogleFonts.roboto(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
              labelMedium: GoogleFonts.roboto(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
                textStyle: const TextStyle(
                  overflow: TextOverflow.visible,
                ),
              ),
              labelLarge: GoogleFonts.roboto(
                fontSize: 19,
                fontWeight: FontWeight.w400,
                textStyle: const TextStyle(
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
            scaffoldBackgroundColor: Colors.white, //const Color(0xff121212),
            appBarTheme: AppBarTheme(
              color: Colors.white,
              centerTitle: false,
              titleTextStyle: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
              elevation: 1,
            ),
            bottomAppBarTheme: const BottomAppBarTheme(
              color: Color(0xff121212),
              elevation: 5,
            ),
            cardTheme: const CardTheme(
              color: Colors.white,
              elevation: 4,
              shadowColor: Colors.white,
            ),
            shadowColor: const Color(0xffBDC8DF).withOpacity(0.7),
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(
                  const Color(
                    0xff4EA995,
                  ),
                ),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            radioTheme: RadioThemeData(
              fillColor:
                  MaterialStateProperty.all<Color>(const Color(0xff4EA995)),
            ),
          )
        : ThemeData(
            colorScheme: const ColorScheme(
              brightness: Brightness.light,
              primary: Colors.black,
              onPrimary: Colors.black,
              secondary: Colors.black,
              onSecondary: Colors.white,
              error: Colors.red,
              onError: Colors.white,
              background: Colors.white,
              onBackground: Colors.black,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            textTheme: TextTheme(
              titleSmall: TextStyle(
                fontSize: Get.height * 0.0193,
                color: Colors.green,
              ),
              titleMedium: TextStyle(
                fontSize: Get.height * 0.0201,
                fontWeight: FontWeight.w500,
              ),
              titleLarge: TextStyle(
                fontSize: Get.height * 0.0241,
                fontWeight: FontWeight.w500,
              ),
              labelSmall: TextStyle(
                fontSize: Get.height * 0.0101,
                fontWeight: FontWeight.w500,
                color: Colors.green,
              ),
            ),
            scaffoldBackgroundColor: Colors.black87,
            appBarTheme: const AppBarTheme(
              color: Colors.white,
              elevation: 0,
            ),
            bottomAppBarTheme: const BottomAppBarTheme(
              color: Color(
                0xfff4f4f4,
              ),
              elevation: 5,
            ),
            shadowColor: const Color(0xffBDC8DF).withOpacity(0.7),
            cardTheme: CardTheme(
              color: Colors.white,
              elevation: 4,
              shadowColor: const Color(0xffBDC8DF).withOpacity(0.7),
            ),
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(
                  const Color(
                    0xffFB8402,
                  ),
                ),
              ),
            ),
            radioTheme: RadioThemeData(
              fillColor: MaterialStateProperty.all<Color>(
                const Color(
                  0xffFB8402,
                ),
              ),
            ),
          );
  }

  static List<BoxShadow> getShadow() {
    return const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 4,
        offset: Offset(0, 1),
      ),
    ];
  }
}
