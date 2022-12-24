import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:m_skool_flutter/classwork/api/get_class_work.dart';
import 'package:m_skool_flutter/classwork/api/update_seen_classwork_api.dart';
import 'package:m_skool_flutter/classwork/model/class_work_model.dart';
import 'package:m_skool_flutter/classwork/widget/filtered_classwork_widget.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';

import 'package:m_skool_flutter/homework/screen/home_work.dart';
import 'package:m_skool_flutter/homework/screen/hwcw_detail_screen.dart';
import 'package:m_skool_flutter/information/controller/hwcwnb_controller.dart';
import 'package:m_skool_flutter/library/screen/library_home.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class ClassworkHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final HwCwNbController hwCwNbController;
  const ClassworkHome(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.hwCwNbController});

  @override
  State<ClassworkHome> createState() => _ClassworkHomeState();
}

class _ClassworkHomeState extends State<ClassworkHome> {
  int color = -1;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return widget.hwCwNbController.errorHappendWhileLoadingClsWrk.value
            ? const Center(
                child: ErrWidget(err: {
                  "errorTitle": "Unable to connect to server.",
                  "errorMsg":
                      "Sorry! but we are unable to connect to server right now. Try again later."
                }),
              )
            : Obx(() {
                return widget.hwCwNbController.filter.value > 0
                    ? FilteredClassWork(
                        loginSuccessModel: widget.loginSuccessModel,
                        mskoolController: widget.mskoolController,
                        hwCwNbController: widget.hwCwNbController)
                    : FutureBuilder<List<ClassWorkModelValues>>(
                        future: GetClassWorkApi.instance.getClassWorks(
                          miId: widget.loginSuccessModel.mIID!,
                          asmayId: widget.loginSuccessModel.asmaYId!,
                          amstId: widget.loginSuccessModel.amsTId!,
                          base: baseUrlFromInsCode(
                            "portal",
                            widget.mskoolController,
                          ),
                          roleId: widget.loginSuccessModel.roleId!,
                          userId: widget.loginSuccessModel.userId!,
                        ),
                        builder: (_, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.isEmpty) {
                              return const AnimatedProgressWidget(
                                title: "No Classwork Found",
                                desc:
                                    "Hurray! We couldn't find any classwork for this particular date, So enjoy",
                                animationPath: "assets/json/nodata.json",
                                animatorHeight: 250,
                              );
                            }

                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(16.0),
                              itemBuilder: (_, index) {
                                color += 1;
                                if (index % 6 == 0) {
                                  color = 0;
                                }
                                if (color > 6) {
                                  color = 0;
                                }
                                return InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return HwCwDetailScreen(
                                          loginSuccessModel:
                                              widget.loginSuccessModel,
                                          mskoolController:
                                              widget.mskoolController,
                                          ihcId: snapshot.data!
                                              .elementAt(index)
                                              .icWId!,
                                          subject: snapshot.data!
                                              .elementAt(index)
                                              .ismSSubjectName!,
                                          topic: snapshot.data!
                                              .elementAt(index)
                                              .icWTopic!,
                                          endDate: snapshot.data!
                                              .elementAt(index)
                                              .icWToDate,
                                          attachmentName: snapshot.data!
                                                          .elementAt(index)
                                                          .icWFilePath ==
                                                      null ||
                                                  snapshot.data!
                                                      .elementAt(index)
                                                      .icWFilePath!
                                                      .isEmpty
                                              ? null
                                              : snapshot.data!
                                                  .elementAt(index)
                                                  .icWFilePath,
                                          attachmentType: snapshot.data!
                                                      .elementAt(index)
                                                      .icWFilePath ==
                                                  null
                                              ? null
                                              : snapshot.data!
                                                      .elementAt(index)
                                                      .icWFilePath!
                                                      .endsWith(".pdf")
                                                  ? "PDF"
                                                  : "OTHERS",
                                          attachmentUrl: snapshot.data!
                                                          .elementAt(index)
                                                          .icWAssignment ==
                                                      null ||
                                                  snapshot.data!
                                                      .elementAt(index)
                                                      .icWAssignment!
                                                      .isEmpty
                                              ? null
                                              : snapshot.data!
                                                  .elementAt(index)
                                                  .icWAssignment,
                                          assignment: snapshot.data!
                                                          .elementAt(index)
                                                          .icWSubTopic ==
                                                      null ||
                                                  snapshot.data!
                                                      .elementAt(index)
                                                      .icWSubTopic!
                                                      .isEmpty
                                              ? "N/A"
                                              : snapshot.data!
                                                  .elementAt(index)
                                                  .icWSubTopic!,
                                          date: snapshot.data!
                                              .elementAt(index)
                                              .icWFromDate!,
                                          screenType: 'classwork',
                                        );
                                      })).then((value) {
                                        if (snapshot.data!
                                                .elementAt(index)
                                                .iCWUPLViewedFlg ==
                                            1) {
                                          return;
                                        }
                                        setState(() {});
                                      });
                                      if (snapshot.data!
                                              .elementAt(index)
                                              .iCWUPLViewedFlg ==
                                          1) {
                                        return;
                                      }
                                      UpdateClassworkSeenApi.instance
                                          .updateSeen(
                                              amstId: widget
                                                  .loginSuccessModel.amsTId!,
                                              miId: widget
                                                  .loginSuccessModel.mIID!,
                                              asmayId: widget
                                                  .loginSuccessModel.asmaYId!,
                                              userId: widget
                                                  .loginSuccessModel.userId!,
                                              roleId: widget
                                                  .loginSuccessModel.roleId!,
                                              icwId: snapshot.data!
                                                  .elementAt(index)
                                                  .icWId!,
                                              asmclId: widget
                                                  .loginSuccessModel.asmcLId!,
                                              asmsId: widget
                                                  .loginSuccessModel.asmSId!,
                                              base: baseUrlFromInsCode("portal",
                                                  widget.mskoolController));
                                    },
                                    child: HwCwItem(
                                      isRead: snapshot.data!
                                                  .elementAt(index)
                                                  .iCWUPLViewedFlg ==
                                              1
                                          ? true
                                          : false,
                                      sub: snapshot.data!
                                          .elementAt(index)
                                          .ismSSubjectName!,
                                      topic: snapshot.data!
                                          .elementAt(index)
                                          .icWContent!,
                                      color: noticeColor.elementAt(color),
                                    ));
                              },
                              itemCount: snapshot.data!.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 12.0,
                                );
                              },
                            );
                          }

                          if (snapshot.hasError) {
                            return ErrWidget(
                                err: snapshot.error as Map<String, dynamic>);
                          }
                          return Column(
                            children: [
                              SizedBox(
                                height: Get.height * 0.25,
                              ),
                              const AnimatedProgressWidget(
                                  title: "Getting Your Assignments",
                                  desc:
                                      "We are fetching your classwork form whiteboard, it will be shown here",
                                  animationPath: "assets/json/classwork.json"),
                            ],
                          );
                        },
                      );
              });
      },

      //  ListView.separated(
      //   padding: const EdgeInsets.all(16.0),
      //   itemBuilder: (_, index) {
      //     return InkWell(
      //         onTap: () {
      //           Navigator.push(context, MaterialPageRoute(builder: (_) {
      //             return HwCwDetailScreen();
      //           }));
      //         },
      //         child: HwCwItem());
      //   },
      //   itemCount: 5,
      //   separatorBuilder: (BuildContext context, int index) {
      //     return const SizedBox(
      //       height: 12.0,
      //     );
      //   },
      // ),
    );
  }
}
