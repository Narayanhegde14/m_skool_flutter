import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/online_leave/screen/online_leave_home.dart';
import 'package:m_skool_flutter/staffs/salary_details/screen/salary_det_home.dart';
import 'package:m_skool_flutter/staffs/student_birthday/screens/bday_home.dart';
import 'package:m_skool_flutter/widget/custom_elevated_button.dart';
import 'package:m_skool_flutter/widget/logout_confirmation.dart';

import '../marksEntry/screen/marks_entry_home.dart';

class StaffHomeScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const StaffHomeScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<StaffHomeScreen> createState() => _StaffHomeScreen();
}

class _StaffHomeScreen extends State<StaffHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset('assets/svg/menu.svg'),
          onPressed: () {
            _scaffold.currentState!.openDrawer();
          },
        ),
      ),
      drawer: const Drawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget
                  .loginSuccessModel.staffmobileappprivileges!.values!.length,
              itemBuilder: (_, index) {
                return ListTile(
                  onTap: () {
                    logger.d(widget
                        .loginSuccessModel.staffmobileappprivileges!.values!
                        .elementAt(index)
                        .pagename);
                    if (widget
                            .loginSuccessModel.staffmobileappprivileges!.values!
                            .elementAt(index)
                            .pagename ==
                        "Attendance Entry") {
                      return;
                    } else if (widget
                            .loginSuccessModel.staffmobileappprivileges!.values!
                            .elementAt(index)
                            .pagename ==
                        "Mark Entry") {
                      Get.to(() => const MarksEntryHome());
                    }

                    if (widget
                            .loginSuccessModel.staffmobileappprivileges!.values!
                            .elementAt(index)
                            .pagename ==
                        "Salary Details") {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return SalaryDetails(
                          loginSuccessModel: widget.loginSuccessModel,
                          mskoolController: widget.mskoolController,
                        );
                      }));
                      return;
                    }
                    if (widget
                            .loginSuccessModel.staffmobileappprivileges!.values!
                            .elementAt(index)
                            .pagename ==
                        "Staff Birth Day Report") {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return StudentBdayHome(
                          loginSuccessModel: widget.loginSuccessModel,
                          mskoolController: widget.mskoolController,
                        );
                      }));
                      return;
                    }

                    if (widget
                            .loginSuccessModel.staffmobileappprivileges!.values!
                            .elementAt(index)
                            .pagename ==
                        "Online Leave Apply") {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return OnlineLeaveApply(
                          loginSuccessModel: widget.loginSuccessModel,
                          mskoolController: widget.mskoolController,
                          title: widget.loginSuccessModel
                              .staffmobileappprivileges!.values!
                              .elementAt(index)
                              .pagename!,
                        );
                      }));
                      return;
                    }
                  },
                  title: Text(widget
                      .loginSuccessModel.staffmobileappprivileges!.values!
                      .elementAt(index)
                      .pagename!),
                );
              },
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
                    child: Row(mainAxisSize: MainAxisSize.min, children: const [
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
