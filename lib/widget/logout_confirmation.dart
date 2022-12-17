import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';

class LogoutConfirmationPopup extends StatefulWidget {
  const LogoutConfirmationPopup({
    Key? key,
  }) : super(key: key);

  @override
  State<LogoutConfirmationPopup> createState() =>
      _LogoutConfirmationPopupState();
}

class _LogoutConfirmationPopupState extends State<LogoutConfirmationPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  final MskoolController mskoolController = Get.find<MskoolController>();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 450), vsync: this);
    scaleAnimation = CurvedAnimation(
        parent: animationController, curve: Curves.elasticInOut);
    animationController.addListener(() {
      // setState(() {});
    });
    animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: AlertDialog(
        title:
            Text("Logout".tr, style: Theme.of(context).textTheme.labelMedium),
        content: Text("Are you sure, you want to logout?".tr,
            style: Theme.of(context).textTheme.labelMedium),
        actions: [
          TextButton(
            onPressed: () async {
              Get.back();
              // institutionalCode!.delete("institutionalCode");
              // logInBox!.put("isLoggedIn", false);
              // Get.offAll(
              //   () => InstitutionalLogin(
              //     mskoolController: mskoolController,
              //   ),
              // );
            },
            child: Text(
              "Yes".tr,
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              "No".tr,
            ),
          ),
        ],
      ),
    );
  }
}
