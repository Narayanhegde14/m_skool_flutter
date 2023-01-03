import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/interaction/apis/messaging_api.dart';
import 'package:m_skool_flutter/student/interaction/controller/interaction_controller.dart';
import 'package:m_skool_flutter/student/interaction/widget/chat_box.dart';
import 'package:m_skool_flutter/student/interaction/widget/custom_text_file.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';
import '../model/inbox_model.dart';

class MessagingScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final GetinboxmsgValue data;
  const MessagingScreen(
      {super.key,
      required this.data,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  final InteractionController interactionController =
      Get.put(InteractionController());

  final TextEditingController textMessage = TextEditingController();

  Future<void> getMessageData() async {
    interactionController.isMessageloading(true);
    await interactionController.getMessage(
      ismintId: widget.data.ismintId!,
      miId: widget.loginSuccessModel.mIID!,
      asmayId: widget.loginSuccessModel.asmaYId!,
      userId: widget.loginSuccessModel.userId!,
      base: baseUrlFromInsCode('portal', widget.mskoolController),
    );
    interactionController.isMessageloading(false);
  }

  @override
  void initState() {
    getMessageData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 30,
        toolbarHeight: 65,
        title: Text("Message",
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Colors.white.withOpacity(0.8))),
        leading: const CustomGoBackButton(),
        // actions: [
        //   GestureDetector(
        //     onTap: () {},
        //     child: Container(
        //       width: 43,
        //       height: 48,
        //       margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        //       decoration: BoxDecoration(
        //           color: const Color(0xffD9EDFF),
        //           borderRadius: BorderRadius.circular(10)),
        //       child: Center(
        //         child: SvgPicture.asset("assets/svg/download.svg"),
        //       ),
        //     ),
        //   )
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => interactionController.isMessage.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: interactionController.messageList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              // ChatBox(
                              //     name: widget.loginSuccessModel.studname ==
                              //             widget.data.receiver
                              //         ? widget.data.receiver!
                              //         : widget.data.sender!,
                              //     isFromMe: widget.data.ismintComposedByFlg ==
                              //             'Staff'
                              //         ? false
                              //         : true,
                              //     messages: widget.data.ismintInteraction!,
                              //     istintDateTime: widget.data.ismintDateTime!,
                              //     attactment: ''),
                              ChatBox(
                                name: widget.loginSuccessModel.studname ==
                                        interactionController.messageList
                                            .elementAt(index)
                                            .receiver
                                    ? interactionController.messageList
                                        .elementAt(index)
                                        .receiver!
                                    : interactionController.messageList
                                        .elementAt(index)
                                        .sender!,
                                isFromMe: interactionController.messageList
                                            .elementAt(index)
                                            .istintComposedByFlg ==
                                        'Student'
                                    ? true
                                    : false,
                                messages: interactionController.messageList
                                    .elementAt(index)
                                    .istintInteraction!,
                                istintDateTime: interactionController
                                    .messageList
                                    .elementAt(index)
                                    .istintDateTime!,
                                attactment: interactionController.messageList
                                    .elementAt(index)
                                    .istintAttachment!,
                              ),
                            ],
                          );
                        },
                      ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: CustomTextField(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 17),
                        controller: textMessage,
                        hintText: " Text Message",
                        radius: 25,
                        suffix: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                                onTap: () {
                                  interactionController
                                      .getFromGallery(
                                          miId: widget.loginSuccessModel.mIID!)
                                      .then((value) async {
                                    if (value) {
                                      interactionController
                                          .isMessageSending(true);
                                      await sendMessage(
                                        miId: widget.loginSuccessModel.mIID!,
                                        amstId:
                                            widget.loginSuccessModel.amsTId!,
                                        asmayId:
                                            widget.loginSuccessModel.asmaYId!,
                                        message: textMessage.text,
                                        istintComposedByFlg:
                                            widget.data.istintId!,
                                        ismintId: widget.data.ismintId!,
                                        userId:
                                            widget.loginSuccessModel.userId!,
                                        image: interactionController.image,
                                        base: baseUrlFromInsCode(
                                            'portal', widget.mskoolController),
                                      ).then(
                                        (value) async {
                                          if (value) {
                                            await interactionController
                                                .getMessage(
                                              ismintId: widget.data.ismintId!,
                                              miId: widget
                                                  .loginSuccessModel.mIID!,
                                              asmayId: widget
                                                  .loginSuccessModel.asmaYId!,
                                              userId: widget
                                                  .loginSuccessModel.userId!,
                                              base: baseUrlFromInsCode('portal',
                                                  widget.mskoolController),
                                            );
                                            textMessage.text = '';
                                          }
                                        },
                                      );
                                      interactionController.image.clear();
                                      interactionController
                                          .isMessageSending(false);
                                    }
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 5.0),
                                  child: SvgPicture.asset(
                                    "assets/svg/clip.svg",
                                    width: 21,
                                    height: 21,
                                  ),
                                )),
                            const SizedBox(width: 17),
                            InkWell(
                                onTap: () {
                                  interactionController
                                      .getFromCamera(
                                          miId: widget.loginSuccessModel.mIID!)
                                      .then((value) async {
                                    if (value) {
                                      interactionController
                                          .isMessageSending(true);
                                      await sendMessage(
                                        miId: widget.loginSuccessModel.mIID!,
                                        amstId:
                                            widget.loginSuccessModel.amsTId!,
                                        asmayId:
                                            widget.loginSuccessModel.asmaYId!,
                                        message: textMessage.text,
                                        istintComposedByFlg:
                                            widget.data.istintId!,
                                        ismintId: widget.data.ismintId!,
                                        userId:
                                            widget.loginSuccessModel.userId!,
                                        image: interactionController.image,
                                        base: baseUrlFromInsCode(
                                            'portal', widget.mskoolController),
                                      ).then(
                                        (value) async {
                                          if (value) {
                                            await interactionController
                                                .getMessage(
                                              ismintId: widget.data.ismintId!,
                                              miId: widget
                                                  .loginSuccessModel.mIID!,
                                              asmayId: widget
                                                  .loginSuccessModel.asmaYId!,
                                              userId: widget
                                                  .loginSuccessModel.userId!,
                                              base: baseUrlFromInsCode('portal',
                                                  widget.mskoolController),
                                            );
                                            textMessage.text = '';
                                          }
                                        },
                                      );
                                      interactionController.image.clear();
                                      interactionController
                                          .isMessageSending(false);
                                    }
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      right: 17.0, left: 5.0, bottom: 13),
                                  child: SvgPicture.asset(
                                    "assets/svg/camera.svg",
                                    width: 21,
                                    height: 21,
                                  ),
                                )),
                          ],
                        ))),
                const SizedBox(width: 12),
                Obx(
                  () => FloatingActionButton(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: interactionController.isSending.value
                        ? const CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          )
                        : SvgPicture.asset("assets/svg/send_arrow.svg"),
                    onPressed: () async {
                      if (textMessage.text.isEmpty &&
                          interactionController.image.isEmpty) {
                        return;
                      } else {
                        logger.d(widget.data.istintId);
                        interactionController.isMessageSending(true);
                        await sendMessage(
                          miId: widget.loginSuccessModel.mIID!,
                          amstId: widget.loginSuccessModel.amsTId!,
                          asmayId: widget.loginSuccessModel.asmaYId!,
                          message: textMessage.text,
                          istintComposedByFlg: widget.data.ismintComposedById!,
                          ismintId: widget.data.ismintId!,
                          userId: widget.loginSuccessModel.userId!,
                          image: interactionController.image,
                          base: baseUrlFromInsCode(
                              'portal', widget.mskoolController),
                        ).then(
                          (value) async {
                           
                            if (value) {
                              await interactionController.getMessage(
                                ismintId: widget.data.ismintId!,
                                miId: widget.loginSuccessModel.mIID!,
                                asmayId: widget.loginSuccessModel.asmaYId!,
                                userId: widget.loginSuccessModel.userId!,
                                base: baseUrlFromInsCode(
                                    'portal', widget.mskoolController),
                              );
                              textMessage.text = '';
                            }
                        
                          },
                        );
                        interactionController.isMessageSending(false);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7)
          ],
        ),
      ),
    );
  }
}
