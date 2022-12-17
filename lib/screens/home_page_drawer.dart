import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/attendance/screens/home_page.dart';
import 'package:m_skool_flutter/certificates/screens/cert_home.dart';
import 'package:m_skool_flutter/classwork/screen/classwork_home_screen.dart';
import 'package:m_skool_flutter/coe/screen/coe_home.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/exam/screen/exam_home.dart';
import 'package:m_skool_flutter/fees/screens/fee_analysis_screen.dart';
import 'package:m_skool_flutter/fees/screens/fee_receipt_home.dart';
import 'package:m_skool_flutter/fees/screens/online_payment_screen.dart';
import 'package:m_skool_flutter/forgotpassword/screens/forgot_password_screen.dart';
import 'package:m_skool_flutter/forgotpassword/screens/reset_password.dart';
import 'package:m_skool_flutter/homework/screen/home_work_screen.dart';
import 'package:m_skool_flutter/information/controller/hwcwnb_controller.dart';
import 'package:m_skool_flutter/interaction/screen/interaction_home.dart';
import 'package:m_skool_flutter/library/screen/library_home.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/notice/screen/notice_home.dart';
import 'package:m_skool_flutter/timetable/screens/time_table_home.dart';
import 'package:m_skool_flutter/widget/custom_elevated_button.dart';
import 'package:m_skool_flutter/widget/logout_confirmation.dart';

class HomePageDrawer extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final HwCwNbController hwCwNbController;
  const HomePageDrawer(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.hwCwNbController});

  @override
  State<HomePageDrawer> createState() => _HomePageDrawerState();
}

class _HomePageDrawerState extends State<HomePageDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Column(
        children: [
          DrawerHeader(
            loginSuccessModel: widget.loginSuccessModel,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...List.generate(
                      widget.loginSuccessModel.staffmobileappprivileges!.values!
                          .length, (index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: ListTile(
                        title: Text(
                            "${widget.loginSuccessModel.staffmobileappprivileges!.values![index].pagename}"),
                        leading: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 18,
                            backgroundImage: AssetImage(
                              getDashBoardIconByName(
                                  "${widget.loginSuccessModel.staffmobileappprivileges!.values![index].pagename}"),
                            ),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          switch (widget
                              .loginSuccessModel
                              .staffmobileappprivileges!
                              .values![index]
                              .pagename) {
                            case "Student Attendance":
                              Get.to(() => AttendanceHomeScreen(
                                  loginSuccessModel: widget.loginSuccessModel,
                                  mskoolController: widget.mskoolController));
                              break;
                            case "Fee Details":
                              // Get.to(() => FeeHomeScreen(
                              //     loginSuccessModel:
                              //         widget.loginSuccessModel,
                              //     mskoolController:
                              //         widget.mskoolController));
                              break;
                            case "Online Fee Payment":
                              Get.to(
                                () => OnlinePaymentScreen(
                                  loginSuccessModel: widget.loginSuccessModel,
                                  mskoolController: widget.mskoolController,
                                  title:
                                      "${widget.loginSuccessModel.staffmobileappprivileges!.values![index].pagename}",
                                ),
                              );
                              break;
                            case "Fee Analysis":
                              Get.to(() => FeeAnalysisScreen(
                                    loginSuccessModel: widget.loginSuccessModel,
                                    mskoolController: widget.mskoolController,
                                    title:
                                        "${widget.loginSuccessModel.staffmobileappprivileges!.values![index].pagename}",
                                  ));
                              break;
                            case "Classwork":
                              Get.to(() => ClassWorkHomeScreen(
                                  loginSuccessModel: widget.loginSuccessModel,
                                  mskoolController: widget.mskoolController,
                                  //hwCwNbController: widget.hwCwNbController,
                                  title:
                                      "${widget.loginSuccessModel.staffmobileappprivileges!.values![index].pagename}"));
                              break;
                            case "Homework":
                              Get.to(
                                () => HomeWorkScreen(
                                  loginSuccessModel: widget.loginSuccessModel,
                                  mskoolController: widget.mskoolController,
                                  //hwCwNbController: widget.hwCwNbController,
                                  title:
                                      "${widget.loginSuccessModel.staffmobileappprivileges!.values![index].pagename}",
                                ),
                              );
                              break;
                            case "COE":
                              Get.to(() => CoeHome(
                                    loginSuccessModel: widget.loginSuccessModel,
                                    mskoolController: widget.mskoolController,
                                  ));
                              break;
                            case "Student Notice Board":
                              Get.to(
                                () => NoticeHome(
                                  loginSuccessModel: widget.loginSuccessModel,
                                  mskoolController: widget.mskoolController,
                                  hwCwNbController: widget.hwCwNbController,
                                  appBarTitle:
                                      "${widget.loginSuccessModel.staffmobileappprivileges!.values![index].pagename}",
                                ),
                              );
                              break;
                            case "Library":
                              String base = baseUrlFromInsCode(
                                  "portal", widget.mskoolController);
                              Get.to(
                                () => LibraryHome(
                                  miId: widget.loginSuccessModel.mIID!,
                                  asmayId: widget.loginSuccessModel.asmaYId!,
                                  asmtId: widget.loginSuccessModel.amsTId!,
                                  base: base,
                                  title:
                                      "${widget.loginSuccessModel.staffmobileappprivileges!.values![index].pagename}",
                                ),
                              );
                              break;
                            case "Syllabus":
                              break;
                            case "Exam":
                              Get.to(() => ExamHome(
                                    loginSuccessModel: widget.loginSuccessModel,
                                    mskoolController: widget.mskoolController,
                                  ));
                              break;
                            case "Interaction":
                              Get.to(() => InteractionHomeScreen(
                                    loginSuccessModel: widget.loginSuccessModel,
                                    mskoolController: widget.mskoolController,
                                  ));
                              break;
                            case "Apply Certificate":
                              Get.to(() => CertificateHomeScreen(
                                    loginSuccessModel: widget.loginSuccessModel,
                                    mskoolController: widget.mskoolController,
                                  ));
                              break;
                            case "Time Table":
                              Get.to(() => TimeTableHome(
                                    loginSuccessModel: widget.loginSuccessModel,
                                    mskoolController: widget.mskoolController,
                                  ));
                              break;
                            case "Fee Receipt":
                              Get.to(
                                () => FeeReceiptHome(
                                  loginSuccessModel: widget.loginSuccessModel,
                                  mskoolController: widget.mskoolController,
                                  title:
                                      "${widget.loginSuccessModel.staffmobileappprivileges!.values![index].pagename}",
                                ),
                              );
                              break;
                            default:
                          }
                        },
                      ),
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: ListTile(
                      title: const Text("Change Password"),
                      leading: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: const CircleAvatar(
                          radius: 18,
                          backgroundImage: AssetImage(
                            "assets/images/ChangePassword.png",
                          ),
                          backgroundColor: Colors.white,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Get.to(() => ResetPassword(
                              mskoolController: widget.mskoolController,
                              loginSuccessModel: widget.loginSuccessModel,
                            ));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: ListTile(
                      title: const Text("Forgot Password"),
                      leading: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: const CircleAvatar(
                          radius: 18,
                          backgroundImage: AssetImage(
                            "assets/images/ForgotPassword.png",
                          ),
                          backgroundColor: Colors.white,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Get.to(() => ForgotPasswordScreen(
                            mskoolController: widget.mskoolController));
                      },
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: SizedBox(
                        width: 180,
                        height: 40,
                        child: CustomElevatedButton(
                            isGradient: false,
                            boxShadow: const BoxShadow(),
                            color: const Color(0xFFFFDFD6),
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    Icons.logout,
                                    color: Color(0xffF24E1E),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Log Out",
                                    style: TextStyle(
                                        color: Color(0xffF24E1E),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                ]),
                            onPressed: () {
                              Get.dialog(const LogoutConfirmationPopup());
                            }),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Created DrawerHeader Widget to show profile image, name, phone number and edit btn.

class DrawerHeader extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  const DrawerHeader({super.key, required this.loginSuccessModel});

  @override
  State<DrawerHeader> createState() => _DrawerHeaderState();
}

class _DrawerHeaderState extends State<DrawerHeader> {
  //Finding the already initialized Controller.
  // final UserProfileController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          16.0, (MediaQuery.of(context).padding.top + 32.0), 16.0, 30.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(40)),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor
          ],
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Obx(() {
          //   return
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30.0,
            backgroundImage: (widget.loginSuccessModel.userImagePath == null ||
                    widget.loginSuccessModel.userImagePath!.isEmpty)
                ? null
                : NetworkImage(widget.loginSuccessModel.userImagePath!),
            child: (widget.loginSuccessModel.userImagePath == null ||
                    widget.loginSuccessModel.userImagePath!.isEmpty)
                ?
                // ?
                const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 36.0,
                    ),
                  )
                : null,
            // : Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Image.network(
            //       widget.loginSuccessModel.userImagePath!,
            //       fit: BoxFit.fill,
            //     ),
            //   ),
          ),
          // }),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Obx(() {
                // return
                Text(
                  widget.loginSuccessModel.studname ?? "N/A",
                  style: Theme.of(context).textTheme.labelLarge!.merge(
                        const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                ),
                // }),
                const SizedBox(
                  height: 6.0,
                ),
                // EmailWidget(userProfileController: controller),
                const SizedBox(
                  height: 6.0,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 6.0,
                    ),
                    Expanded(
                      child:
                          // Obx(() {
                          //   return
                          Text(
                        // controller.profileData.elementAt(0).mobileNo ??
                        "N/A",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall!.merge(
                              const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                      ),
                      // }),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//This widget is used for showing the email on the Navigation Drawer
// Part of DrawerHeader Widget

class EmailWidget extends StatelessWidget {
  // final UserProfileController userProfileController;
  const EmailWidget({
    super.key,
    // required this.userProfileController
  });

  @override
  Widget build(BuildContext context) {
    // return Obx(() {
    return
        //  userProfileController.profileData.elementAt(0).email!.isEmpty
        // ?
        const SizedBox();
    // : Row(
    //     children: [
    //       const Icon(
    //         Icons.mail_outline_outlined,
    //         color: Colors.white,
    //       ),
    //       const SizedBox(
    //         width: 6.0,
    //       ),
    //       Expanded(
    //         child: Text(
    //           userProfileController.profileData.elementAt(0).email ??
    //               "N/A",
    //           maxLines: 1,
    //           overflow: TextOverflow.ellipsis,
    //           style: Theme.of(context).textTheme.labelSmall!.merge(
    //                 const TextStyle(
    //                   color: Colors.white,
    //                 ),
    //               ),
    //         ),
    //       ),
    //     ],
    //   );
    // });
  }
}
