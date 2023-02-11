import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/interaction/controller/staff_interaction_inbox_related_controller.dart';
import 'package:m_skool_flutter/student/interaction/widget/chat_profile_tile.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';

class InboxTabStaff extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const InboxTabStaff({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  State<InboxTabStaff> createState() => _InboxTabStaffState();
}

class _InboxTabStaffState extends State<InboxTabStaff> {
  final StaffInteractionInboxController staffInteractionInboxController =
      Get.put(StaffInteractionInboxController());

  void getInboxData() async {
    staffInteractionInboxController.isinboxloading(true);
    await staffInteractionInboxController
        .getStaffInboxList(
          miId: widget.loginSuccessModel.mIID!,
          amstId: widget.loginSuccessModel.amsTId!,
          asmayId: widget.loginSuccessModel.asmaYId!,
          roleId: widget.loginSuccessModel.roleId!,
          role: widget.loginSuccessModel.roleforlogin!,
          userId: widget.loginSuccessModel.userId!,
          base: baseUrlFromInsCode(
            'portal',
            widget.mskoolController,
          ),
        )
        .then((value) => logger.d(value));
    staffInteractionInboxController.isinboxloading(false);
  }

  @override
  void initState() {
    logger.d(widget.loginSuccessModel.roleforlogin);
    getInboxData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => staffInteractionInboxController.isInbox.value
          ? const Center(
              child: AnimatedProgressWidget(
                title: "Loading Inbox",
                desc: "Please wait while we generate a view for you..",
                animationPath: "assets/json/interaction.json",
              ),
            )
          : staffInteractionInboxController.inboxList.isEmpty
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
                      ismintComposeById: staffInteractionInboxController
                          .inboxList[index].ismintComposedById!,
                      ismintDateTime: staffInteractionInboxController
                          .inboxList[index].ismintDateTime!,
                      ismintId: staffInteractionInboxController
                          .inboxList[index].ismintId!,
                      ismintSubject: staffInteractionInboxController
                          .inboxList[index].ismintSubject!,
                      istintId: staffInteractionInboxController
                          .inboxList[index].istintToId!,
                      istintToFlg: widget.loginSuccessModel.roleforlogin!
                                  .toLowerCase() ==
                              staffInteractionInboxController.inboxList
                                  .elementAt(index)
                                  .ismintComposedByFlg!
                                  .toLowerCase()
                          ? staffInteractionInboxController
                              .inboxList[index].istintToFlg!
                          : staffInteractionInboxController
                              .inboxList[index].ismintComposedByFlg!,
                      receiver: widget.loginSuccessModel.roleforlogin!
                                  .toLowerCase() ==
                              staffInteractionInboxController.inboxList
                                  .elementAt(index)
                                  .ismintComposedByFlg!
                                  .toLowerCase()
                          ? staffInteractionInboxController
                              .inboxList[index].receiver!
                          : staffInteractionInboxController.inboxList
                              .elementAt(index)
                              .sender!,
                      receiverFilePath: widget.loginSuccessModel.roleforlogin!
                                  .toLowerCase() ==
                              staffInteractionInboxController.inboxList
                                  .elementAt(index)
                                  .ismintComposedByFlg!
                                  .toLowerCase()
                          ? staffInteractionInboxController
                              .inboxList[index].receiverFilepath!
                          : staffInteractionInboxController
                              .inboxList[index].senderFilepath!,
                      role: staffInteractionInboxController
                          .inboxList[index].role!,

                      userHrmeId:
                          staffInteractionInboxController.userHrmeId.value,
                      sender: staffInteractionInboxController
                          .inboxList[index].sender!,
                      // isGroup: Random().nextBool(),
                      // isSeen:
                      //     staffInteractionInboxController.inboxList[index].istintReadFlg == 1
                      //         ? true
                      //         : false,
                      // color: Color.fromRGBO(Random().nextInt(255),
                      //     Random().nextInt(255), Random().nextInt(255), 1),
                    );
                  },
                  separatorBuilder: (_, index) => const Divider(),
                  itemCount: staffInteractionInboxController.inboxList.length),
    );
  }
}
