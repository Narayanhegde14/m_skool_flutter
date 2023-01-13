import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/api/hw_cw_get_class.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/api/hw_cw_get_section.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/api/hw_cw_get_subject.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/api/hw_cw_get_year.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/controller/hw_cw_controller.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/tabs/assign_work.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/tabs/view_work.dart';
import 'package:m_skool_flutter/student/interaction/widget/custom_tab_bar.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class HwCwHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final String title;
  final bool forHw;
  const HwCwHome({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
    required this.title,
    required this.forHw,
  });

  @override
  State<HwCwHome> createState() => _HwCwHomeState();
}

class _HwCwHomeState extends State<HwCwHome>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  final HwCwController hwCwController =
      Get.put<HwCwController>(HwCwController());
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    if (widget.forHw) {
      loadHw();
    } else {
      loadCw();
    }
    super.initState();
  }

  Future<void> loadHw() async {
    await HwCwGetAcademicYear.instance.getAcademicYear(
      miId: widget.loginSuccessModel.mIID!,
      userId: widget.loginSuccessModel.userId!,
      loginId: widget.loginSuccessModel.userId!,
      ivrmrtId: widget.loginSuccessModel.roleId!,
      asmayId: widget.loginSuccessModel.asmaYId!,
      hrmeId: widget.loginSuccessModel.empcode!,
      base: baseUrlFromInsCode(
        "portal",
        widget.mskoolController,
      ),
      hwCwController: hwCwController,
    );
    if (hwCwController.isErrorOccuredLoadingAcademicYear.value ||
        hwCwController.session.isEmpty) {
      return;
    }

    await HwCwGetClassApi.instance.getHwCwClasses(
      miId: widget.loginSuccessModel.mIID!,
      loginId: widget.loginSuccessModel.userId!,
      asmayId: hwCwController.selectedSession.value.asmaYId!,
      ivrmrtId: widget.loginSuccessModel.roleId!,
      hrmeId: widget.loginSuccessModel.empcode!,
      base: baseUrlFromInsCode(
        "portal",
        widget.mskoolController,
      ),
      hwCwController: hwCwController,
    );

    if (hwCwController.isErrorOccuredLoadingClass.value ||
        hwCwController.classes.isEmpty) {
      return;
    }

    await HwCwGetSection.instance.getSections(
        miId: widget.loginSuccessModel.mIID!,
        ivrmrtId: widget.loginSuccessModel.roleId!,
        asmayId: hwCwController.selectedSession.value.asmaYId!,
        userId: widget.loginSuccessModel.userId!,
        hrmeId: widget.loginSuccessModel.empcode!,
        loginId: widget.loginSuccessModel.userId!,
        asmclId: hwCwController.selectedClass.value.asmcLId!,
        base: baseUrlFromInsCode("portal", widget.mskoolController),
        hwCwController: hwCwController);
    if (hwCwController.isErrorOccuredLoadingSection.value ||
        hwCwController.sections.isEmpty) {
      return;
    }

    await HwCwGetSubjectsApi.instance.getSubjects(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: hwCwController.selectedSession.value.asmaYId!,
      asmclId: hwCwController.selectedClass.value.asmcLId!,
      hrmeId: widget.loginSuccessModel.empcode!,
      sections: [
        {"ASMS_Id": hwCwController.selectedSection.value.asmSId!}
      ],
      ivrmrtId: widget.loginSuccessModel.roleId!,
      loginId: widget.loginSuccessModel.userId!,
      base: baseUrlFromInsCode("portal", widget.mskoolController),
      hwCwController: hwCwController,
    );
  }

  Future<void> loadCw() async {}

  @override
  void dispose() {
    Get.delete<HwCwController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: widget.title,
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 55),
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: CustomTabBar(tabController: tabController!, tabs: const [
                CustomTab(
                    name: "AssignWork", asset: "assets/svg/file-text.svg"),
                CustomTab(name: "ViewWork", asset: "assets/svg/eye_svg.svg"),
              ]),
            ),
          )).getAppBar(),
      body: TabBarView(
        controller: tabController,
        children: [
          HwCwAssignWork(
            forHw: widget.forHw,
            hwCwController: hwCwController,
            loginSuccessModel: widget.loginSuccessModel,
            mskoolController: widget.mskoolController,
          ),
          const HwCwViewWork(),
        ],
      ),
    );
  }
}
