// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/interaction/controller/inbox_tab_controller.dart';
import 'package:m_skool_flutter/student/interaction/widget/chat_profile_tile.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';

class InboxTabScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const InboxTabScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<InboxTabScreen> createState() => _InboxTabScreenState();
}

class _InboxTabScreenState extends State<InboxTabScreen> {
  final InboxController inboxController = Get.put(InboxController());
  Future<void> getInboxListData() async {
    inboxController.isInboxloading(true);
    await inboxController.getInboxList(
      miId: widget.loginSuccessModel.mIID!,
      amstId: widget.loginSuccessModel.amsTId!,
      asmayId: widget.loginSuccessModel.asmaYId!,
      role: widget.loginSuccessModel.roleforlogin!,
      roleId: widget.loginSuccessModel.roleId!,
      userId: widget.loginSuccessModel.userId!,
      base: baseUrlFromInsCode(
        'portal',
        widget.mskoolController,
      ),
    );
    inboxController.isInboxloading(false);
  }

  @override
  void initState() {
    getInboxListData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => inboxController.isInboxLoading.value
          ? const Center(
              child: AnimatedProgressWidget(
                title: "Loading Inbox",
                desc: "Please wait while we generate a view for you..",
                animationPath: "assets/json/interaction.json",
              ),
            )
          : inboxController.inboxList.isEmpty
              ? const Center(
                  child: AnimatedProgressWidget(
                    title: "Empty Inbox",
                    desc: "",
                    animationPath: "assets/json/interaction.json",
                  ),
                )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    return ChatProfileTile(
                      loginSuccessModel: widget.loginSuccessModel,
                      mskoolController: widget.mskoolController,
                      ismintComposeById:
                          inboxController.inboxList[index].ismintComposedById!,
                      ismintDateTime:
                          inboxController.inboxList[index].ismintDateTime!,
                      ismintId: inboxController.inboxList[index].ismintId!,
                      ismintSubject:
                          inboxController.inboxList[index].ismintSubject!,
                      istintId: inboxController.inboxList[index].istintId!,
                      designation: inboxController.userHrmeId ==
                              inboxController
                                  .inboxList[index].ismintComposedById
                          ? inboxController.inboxList[index].istintToFlg!
                          : inboxController
                              .inboxList[index].ismintComposedByFlg!,
                      title: inboxController.userHrmeId ==
                              inboxController
                                  .inboxList[index].ismintComposedById
                          ? inboxController.inboxList[index].receiver!
                          : inboxController.inboxList[index].sender!,
                      profileimage: inboxController.userHrmeId ==
                              inboxController
                                  .inboxList[index].ismintComposedById
                          ? inboxController.inboxList[index].receiverFilepath!
                          : inboxController
                              .inboxList[index].senderSenderFilepath!,
                      role: inboxController.inboxList[index].role!,
                      userHrmeId: inboxController.userHrmeId.value,
                      sender: inboxController.inboxList[index].sender!,
                      receiver: inboxController.inboxList[index].receiver!,
                      // isGroup: Random().nextBool(),
                      isSeen: inboxController
                                  .messageFlagList[index].istintReadFlg ==
                              1
                          ? true
                          : false,
                      // color: Color.fromRGBO(Random().nextInt(255),
                      //     Random().nextInt(255), Random().nextInt(255), 1),
                    );
                  },
                  separatorBuilder: (_, index) => const Divider(),
                  itemCount: inboxController.inboxList.length),
    );
  }
}
