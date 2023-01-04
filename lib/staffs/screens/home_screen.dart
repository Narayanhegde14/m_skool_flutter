import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/screen/daywise_attendance_entry_home.dart';
import 'package:m_skool_flutter/staffs/coe/screens/coe_home.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/screen/hw_cw_home.dart';
import 'package:m_skool_flutter/staffs/online_leave/screen/online_leave_home.dart';
import 'package:m_skool_flutter/staffs/punch_report/screens/punch_report_home.dart';
import 'package:m_skool_flutter/staffs/salary_details/screen/salary_det_home.dart';
import 'package:m_skool_flutter/staffs/staff_tt/screens/staff_tt_home.dart';
import 'package:m_skool_flutter/staffs/student_attendance_staff/screen/student_attendance_staff_home.dart';
import 'package:m_skool_flutter/staffs/student_birthday/screens/bday_home.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/screen/verify_hw_cw_home.dart';
import 'package:m_skool_flutter/staffs/view_notice/screens/view_notice_home_screen.dart';
import 'package:m_skool_flutter/staffs/widget/staff_carasouel.dart';
import 'package:m_skool_flutter/staffs/widget/staff_home_leave.dart';
import 'package:m_skool_flutter/staffs/widget/staff_home_lop.dart';
import 'package:m_skool_flutter/staffs/widget/staff_home_tt.dart';
import 'package:m_skool_flutter/staffs/widget/staff_punch_report.dart';
import 'package:m_skool_flutter/widget/custom_elevated_button.dart';
import 'package:m_skool_flutter/widget/logout_confirmation.dart';

import '../../controller/global_utilities.dart';
import '../marks_entry/screen/marks_entry_home.dart';

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

  int color = -1;
  int ttColor = -1;
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StaffCarasouel(),
            const SizedBox(
              height: 16.0,
            ),
            const StaffPunchCardAndLop(),
            const SizedBox(
              height: 16.0,
            ),
            const StaffHomeLeave(),
            const SizedBox(
              height: 16.0,
            ),
            const StaffHomeTT(),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              "Dashboard",
              style: Theme.of(context).textTheme.titleSmall!.merge(
                    const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: widget
                  .loginSuccessModel.staffmobileappprivileges!.values!.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0),
              itemBuilder: (_, index) {
                return InkWell(
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
                      Get.to(
                        // () => const MonthWiseAttendanceEntryHomeScreen(),
                        // () => const PeriodWiseAttendanceEntryHomeScreen(),
                        () => const DayWiseAttendanceEntryHome(),
                      );
                    }
                    if (widget
                            .loginSuccessModel.staffmobileappprivileges!.values!
                            .elementAt(index)
                            .pagename ==
                        "Student Attendance Staff") {
                      Get.to(() => const StudentAttendanceStaffHome());
                    }
                    if (widget
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

                    if (widget
                            .loginSuccessModel.staffmobileappprivileges!.values!
                            .elementAt(index)
                            .pagename! ==
                        "Notice Board") {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return ViewNoticeHome(
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
                    if (widget
                            .loginSuccessModel.staffmobileappprivileges!.values!
                            .elementAt(index)
                            .pagename! ==
                        "Punch Report") {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return PunchReport(
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

                    if (widget
                            .loginSuccessModel.staffmobileappprivileges!.values!
                            .elementAt(index)
                            .pagename! ==
                        "Verify Homework") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return VerifyHwCwHome(
                              loginSuccessModel: widget.loginSuccessModel,
                              mskoolController: widget.mskoolController,
                              title: widget.loginSuccessModel
                                  .staffmobileappprivileges!.values!
                                  .elementAt(index)
                                  .pagename!,
                              forHw: true,
                            );
                          },
                        ),
                      );
                      return;
                    }
                    if (widget
                            .loginSuccessModel.staffmobileappprivileges!.values!
                            .elementAt(index)
                            .pagename! ==
                        "Verify Classwork") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return VerifyHwCwHome(
                              loginSuccessModel: widget.loginSuccessModel,
                              mskoolController: widget.mskoolController,
                              title: widget.loginSuccessModel
                                  .staffmobileappprivileges!.values!
                                  .elementAt(index)
                                  .pagename!,
                              forHw: false,
                            );
                          },
                        ),
                      );
                      return;
                    }
                    if (widget
                            .loginSuccessModel.staffmobileappprivileges!.values!
                            .elementAt(index)
                            .pagename! ==
                        "Classwork") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return HwCwHome(
                              loginSuccessModel: widget.loginSuccessModel,
                              mskoolController: widget.mskoolController,
                              title: widget.loginSuccessModel
                                  .staffmobileappprivileges!.values!
                                  .elementAt(index)
                                  .pagename!,
                              forHw: false,
                            );
                          },
                        ),
                      );
                      return;
                    }
                    if (widget
                            .loginSuccessModel.staffmobileappprivileges!.values!
                            .elementAt(index)
                            .pagename! ==
                        "Homework") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return HwCwHome(
                              loginSuccessModel: widget.loginSuccessModel,
                              mskoolController: widget.mskoolController,
                              title: widget.loginSuccessModel
                                  .staffmobileappprivileges!.values!
                                  .elementAt(index)
                                  .pagename!,
                              forHw: true,
                            );
                          },
                        ),
                      );
                      return;
                    }
                    if (widget
                            .loginSuccessModel.staffmobileappprivileges!.values!
                            .elementAt(index)
                            .pagename! ==
                        "Interaction") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return StaffCoeHome(
                              loginSuccessModel: widget.loginSuccessModel,
                              mskoolController: widget.mskoolController,
                              title: widget.loginSuccessModel
                                  .staffmobileappprivileges!.values!
                                  .elementAt(index)
                                  .pagename!,
                              //forHw: true,
                            );
                          },
                        ),
                      );
                      return;
                    }
                    if (widget
                            .loginSuccessModel.staffmobileappprivileges!.values!
                            .elementAt(index)
                            .pagename! ==
                        "Time Table") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return StaffTTHome(
                              loginSuccessModel: widget.loginSuccessModel,
                              mskoolController: widget.mskoolController,
                              title: widget.loginSuccessModel
                                  .staffmobileappprivileges!.values!
                                  .elementAt(index)
                                  .pagename!,
                              //forHw: true,
                            );
                          },
                        ),
                      );
                      return;
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: SizedBox(
                      width: 80,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              getDashBoardIconByName(
                                  "${widget.loginSuccessModel.staffmobileappprivileges!.values![index].pagename}"),
                              height: 60,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${widget.loginSuccessModel.staffmobileappprivileges!.values![index].pagename}",
                              //maxLines: 1,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .merge(const TextStyle(fontSize: 13.0)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            // ListView.builder(
            //   shrinkWrap: true,
            //   physics: const NeverScrollableScrollPhysics(),
            //   itemCount: widget
            //       .loginSuccessModel.staffmobileappprivileges!.values!.length,
            //   itemBuilder: (_, index) {
            //     return ListTile(
            //       onTap: () {},
            //       title: Text(widget
            //           .loginSuccessModel.staffmobileappprivileges!.values!
            //           .elementAt(index)
            //           .pagename!),
            //     );
            //   },
            // ),
            const SizedBox(
              height: 24.0,
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

class StaffPunchCardAndLop extends StatelessWidget {
  const StaffPunchCardAndLop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: StaffHomeLop()),
        SizedBox(
          width: 12.0,
        ),
        Expanded(child: StaffPunchReport())
      ],
    );
  }
}
