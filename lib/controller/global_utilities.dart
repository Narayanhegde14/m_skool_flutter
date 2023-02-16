import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/apis/version_control_api.dart';
import 'package:m_skool_flutter/constants/api_url_constants.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/categories_api_item.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/screens/notification.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

RxInt currentHomeTab = 0.obs;
RxList<int> previousHomeTab = [0].obs;
RxBool isPageLoading = false.obs;
RxString mobileNumber = "".obs;
RxString passWord = "".obs;
RxInt currentAuthTab = 0.obs;

Dio? dio;

Dio getGlobalDio() {
  dio ??= Dio();
  return dio!;
}

Future<bool> checkConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

Map<String, dynamic> getSession() {
  Map<String, dynamic> header = {
    "Cookie": cookieBox!.get("cookie"),
  };
  return header;
}

// Map<String,dynamic> getInsSession(){
//   Map<String, dynamic> header = {
//     "cookie": cookieBox!.get("session"),
//   };
//   return header;
// }

DateTime getDateTimeFromSeconds(
  int seconds,
) {
  return DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
}

// String getTimeFromSecond(int seconds, {bool withTime = false}) {
//   String time = "";
//   time =
//       "${(withTime) ? DateTime.fromMillisecondsSinceEpoch(seconds * 1000).hour : ""}${(withTime) ? ":" : ""}${(withTime) ? numberList.elementAt(DateTime.fromMillisecondsSinceEpoch(seconds * 1000).minute) : ""}${(withTime) ? "," : ""}${DateTime.fromMillisecondsSinceEpoch(seconds * 1000).day} ${months.elementAt(DateTime.fromMillisecondsSinceEpoch(seconds * 1000).month - 1)} ${DateTime.fromMillisecondsSinceEpoch(seconds * 1000).year}";
//   return time;
// }

toCapitalized(String value) {
  return value.capitalize;
}

String baseUrlFromInsCode(String pageName, MskoolController mskoolController) {
  for (int i = 0;
      i < mskoolController.universalInsCodeModel!.value.apiarray.values.length;
      i++) {
    final CategoriesApiItem api = mskoolController
        .universalInsCodeModel!.value.apiarray.values
        .elementAt(i);
    if (api.iivrscurLAPIName.toLowerCase() == pageName) {
      return api.iivrscurLAPIURL;
    }
  }
  return "";
}

String getDashBoardIconByName(String title) {
  String returnValue = "assets/images/";
  switch (title) {
    case "Attendance":
      returnValue += "Attendance.png";
      break;
    case "Fee Details":
      returnValue += "FeeReceipt.png";
      break;
    case "Fee Payment":
      returnValue += "OnlinePayment.png";
      break;
    case "Fee Analysis":
      returnValue += "FeeAnalysis.png";
      break;
    case "Classwork":
      returnValue += "Classwork.png";
      break;
    case "Homework":
      returnValue += "Homework.png";
      break;
    case "COE":
      returnValue += "Coe.png";
      break;
    case "Notice Board":
      returnValue += "Noticeboard.png";
      break;
    case "Library":
      returnValue += "Library.png";
      break;
    case "Syllabus":
      returnValue += "Attendance.png";
      break;
    case "Exam":
      returnValue += "exam.png";
      break;
    case "Interaction":
      returnValue += "Interaction.png";
      break;
    case "Certificate":
      returnValue += "Certificate.png";
      break;
    case "Time Table":
      returnValue += "Timetable.png";
      break;
    case "Fee Receipt":
      returnValue += "FeeReceipt.png";
      break;
    default:
      returnValue += "Timetable.png";
  }
  return returnValue;
}

String getStaffDashboardIcon(String pageName) {
  String icon = "assets/images/";

  if (pageName.toLowerCase().contains("entry") &&
      !pageName.toLowerCase().contains("mark")) {
    return icon += "staff_stu_attendance.png";
  }

  if (pageName.toLowerCase().contains("attendance")) {
    return icon += "staff_attendance.png";
  }

  if (pageName.toLowerCase().contains("time")) {
    return icon += "staff_tt.png";
  }

  if (pageName.toLowerCase().contains("mark")) {
    return icon += "staff_me.png";
  }

  if (pageName.toLowerCase().contains("punch")) {
    return icon += "staff_pr.png";
  }

  if (pageName.toLowerCase().contains("salary details")) {
    return icon += "staff_dt.png";
  }

  if (pageName.toLowerCase().contains("homework")) {
    return icon += "staff_hw.png";
  }
  if (pageName.toLowerCase().contains("classwork")) {
    return icon += "staff_classwork.png";
  }
  if (pageName.toLowerCase().contains("notice")) {
    return icon += "staff_nb.png";
  }

  if (pageName.toLowerCase().contains("birth")) {
    return icon += "staff_bday.png";
  }
  if (pageName.toLowerCase().contains("interaction")) {
    return icon += "staff_interaction.png";
  }
  if (pageName.toLowerCase().contains("leave")) {
    return icon += "staff_olp.png";
  }
  if (pageName.toLowerCase().contains("coe")) {
    return icon += "staff_coe.png";
  }

  if (pageName.toLowerCase().contains("slip")) {
    return icon += "FeeReceipt.png";
  }

  return icon += "Timetable.png";
}

String getManagerDashboardIconByName(String pageName) {
  String icon = "assets/images/";

  if (pageName.toLowerCase().contains("student")) {
    return icon += "student_details.png";
  }
  if (pageName.toLowerCase().contains("interaction")) {
    return icon += "staff_interaction.png";
  }
  if (pageName.toLowerCase().contains("leave")) {
    return icon += "staff_olp.png";
  }
  if (pageName.toLowerCase().contains("coe")) {
    return icon += "staff_coe.png";
  }

  if (pageName.toLowerCase().contains("slip")) {
    return icon += "FeeReceipt.png";
  }
  if (pageName.toLowerCase().contains("employee")) {
    return icon += "employee_details.png";
  }
  if (pageName.toLowerCase().contains("fee")) {
    return icon += "manager_fee.png";
  }
  if (pageName.toLowerCase().contains("notice")) {
    return icon += "staff_nb.png";
  }

  return icon += "Timetable.png";
}

Future<void> initializeFCMNotification() async {
  var messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else {
    print('User declined or has not accepted permission');
  }
}

pushNotificationNavigator({
  required LoginSuccessModel loginSuccessModel,
  required MskoolController mskoolController,
}) async {
  Get.to(() => NotificationScreen(
        loginSuccessModel: loginSuccessModel,
        mskoolController: mskoolController,
        openFor: loginSuccessModel.roleforlogin!,
      ));
}

notificationCallback(
  NotificationResponse details,
) async {
  Map<String, dynamic> subject = jsonDecode(details.payload!);
  logger.d(subject);
  MskoolController mskoolController = Get.find<MskoolController>();
  logger.d('notificationcall back');
  pushNotificationNavigator(
      loginSuccessModel: mskoolController.loginSuccessModel!.value,
      mskoolController: mskoolController);
}

void version(LoginSuccessModel loginSuccessModel,
    MskoolController mskoolController) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  // String appName = packageInfo.appName;
  // String packageName = packageInfo.packageName;
  String version = packageInfo.version;
  // String buildNumber = packageInfo.buildNumber;

  final bool ctrl = await VersionControlApi.instance.checkVersionAndShowUpgrade(
    miId: loginSuccessModel.mIID!,
    version: version,
    base: baseUrlFromInsCode(
      "portal",
      mskoolController,
    ),
  );

  if (ctrl) {
    Get.dialog(AlertDialog(
      title: const Text("Update App!"),
      content: const Text(
        "We have updated this app with new feature's and several bug fixes, we strongly recommend you to update the app before using",
        style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w400),
      ),
      actions: [
        TextButton(
            onPressed: () async {
              Get.close(1);
            },
            child: const Text("Later")),
        TextButton(
          onPressed: () async {
            Get.close(1);
            if (await canLaunchUrl(Uri.parse(URLS.playStoreLink))) {
              await launchUrl(Uri.parse(URLS.playStoreLink),
                  mode: LaunchMode.externalApplication);
            }
          },
          child: const Text("Update"),
        ),
      ],
    ));
  }

  // logger.d(version);
}
