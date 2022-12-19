import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/homework/api/home_work_api.dart';
import 'package:m_skool_flutter/homework/api/update_hw_seen.dart';
import 'package:m_skool_flutter/homework/screen/home_work.dart';
import 'package:m_skool_flutter/homework/screen/hwcw_detail_screen.dart';
import 'package:m_skool_flutter/information/controller/hwcwnb_controller.dart';
import 'package:m_skool_flutter/library/screen/library_home.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';

class FiltredHw extends StatefulWidget {
  final HwCwNbController hwCwNbController;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const FiltredHw(
      {super.key,
      required this.hwCwNbController,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<FiltredHw> createState() => _FiltredHwState();
}

class _FiltredHwState extends State<FiltredHw> {
  @override
  void initState() {
    getHw();
    super.initState();
  }

  Future<void> getHw() async {
    await GetHomeWorkApi.instance.getHomeAssignment(
        miId: widget.loginSuccessModel.mIID!,
        asmayId: widget.loginSuccessModel.asmaYId!,
        amstId: widget.loginSuccessModel.amsTId!,
        startDate: widget.hwCwNbController.dtList.first.toLocal().toString(),
        endDate: widget.hwCwNbController.dtList.last.toLocal().toString(),
        baseUrl: baseUrlFromInsCode("portal", widget.mskoolController),
        hwCwNbController: widget.hwCwNbController);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return widget.hwCwNbController.isHomeWorkLoading.value
          ? const CustomPgrWidget(
              title: "Loading Filtred Homework",
              desc: "Please wait! We are loading your homework...")
          : widget.hwCwNbController.homeWorkList.isEmpty
              ? Column(
                  children: [
                    // SizedBox(
                    //   height: Get.height * 0.2,
                    // ),
                    Image.asset(
                      'assets/images/hw_cw_not.jpg',
                      height: Get.height * 0.3,
                    ),
                    Text(
                      "No homework found",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .merge(const TextStyle(fontSize: 20.0)),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                        "Hurray! We couldn't find any homework for this particular date. So Enjoy",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelMedium!),
                  ],
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${getFormatedDate(widget.hwCwNbController.dtList.first.toLocal())} - ${getFormatedDate(widget.hwCwNbController.dtList.last.toLocal())}",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return HwCwDetailScreen(
                                    topic: widget.hwCwNbController.homeWorkList
                                        .elementAt(index)
                                        .ihWTopic!,
                                    ihcId: widget.hwCwNbController.homeWorkList
                                        .elementAt(index)
                                        .ihWId!,
                                    assignment: widget
                                        .hwCwNbController.homeWorkList
                                        .elementAt(index)
                                        .ihWAssignment!,
                                    date: widget.hwCwNbController.homeWorkList
                                        .elementAt(index)
                                        .ihWDate!,
                                    subject: widget
                                        .hwCwNbController.homeWorkList
                                        .elementAt(index)
                                        .ismSSubjectName!,
                                    attachmentUrl: widget
                                        .hwCwNbController.homeWorkList
                                        .elementAt(index)
                                        .ihWAttachment,
                                    attachmentType: widget
                                                .hwCwNbController.homeWorkList
                                                .elementAt(index)
                                                .ihWFilePath ==
                                            null
                                        ? null
                                        : widget.hwCwNbController.homeWorkList
                                                .elementAt(index)
                                                .ihWFilePath!
                                                .endsWith(".pdf")
                                            ? "PDF"
                                            : "OTHERS",
                                    attachmentName: widget
                                        .hwCwNbController.homeWorkList
                                        .elementAt(index)
                                        .ihWFilePath,
                                    loginSuccessModel: widget.loginSuccessModel,
                                    mskoolController: widget.mskoolController,
                                    screenType: 'homework',
                                  );
                                })).then((value) {
                                  if (value == null) {}
                                  if (widget.hwCwNbController.homeWorkList
                                          .elementAt(index)
                                          .iHWUPLViewedFlg ==
                                      1) {
                                    return;
                                  }
                                  getHw();
                                });

                                if (widget.hwCwNbController.homeWorkList
                                        .elementAt(index)
                                        .iHWUPLViewedFlg ==
                                    1) {
                                  return;
                                }

                                UpdateHwSeenApi.instance.markAsSeen(
                                    amstId: widget.loginSuccessModel.amsTId!,
                                    miId: widget.loginSuccessModel.mIID!,
                                    asmayId: widget.loginSuccessModel.asmaYId!,
                                    userId: widget.loginSuccessModel.userId!,
                                    roleId: widget.loginSuccessModel.roleId!,
                                    flag: "Homework",
                                    ihwId: widget.hwCwNbController.homeWorkList
                                        .elementAt(index)
                                        .ihWId!,
                                    asmclId: widget
                                        .hwCwNbController.homeWorkList
                                        .elementAt(index)
                                        .asmcLId!,
                                    asmsId: widget.hwCwNbController.homeWorkList
                                        .elementAt(index)
                                        .asmSId!,
                                    base: baseUrlFromInsCode(
                                        "portal", widget.mskoolController));
                              },
                              child: HwCwItem(
                                isRead: widget.hwCwNbController.homeWorkList
                                            .elementAt(index)
                                            .iHWUPLViewedFlg ==
                                        1
                                    ? true
                                    : false,
                                sub: widget.hwCwNbController.homeWorkList
                                    .elementAt(index)
                                    .ismSSubjectName!,
                                topic: widget.hwCwNbController.homeWorkList
                                    .elementAt(index)
                                    .ihWAssignment!,
                              ),
                            );
                          },
                          separatorBuilder: (_, index) {
                            return const SizedBox(
                              height: 16.0,
                            );
                          },
                          itemCount:
                              widget.hwCwNbController.homeWorkList.length),
                    ],
                  ),
                );
      ;
    });
  }
}
