import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/api/get_student_attachment_api.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/cw_student_attachment_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/hw_student_attachment_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/verify_cw_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/verify_hw_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/widget/hw_cw_content_item.dart';
import 'package:m_skool_flutter/student/coe/screen/view_image.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as p;

class VerifyHwCwItem extends StatelessWidget {
  final Color color;
  final VerifyHwListModelValues? model;
  final VerifyClassworkListValues? cwList;
  final LoginSuccessModel loginSuccessModel;

  const VerifyHwCwItem({
    Key? key,
    required this.forHw,
    required this.color,
    this.model,
    required this.miId,
    required this.base,
    required this.loginSuccessModel,
    required this.asmayId,
    this.cwList,
  }) : super(key: key);

  final bool forHw;
  final int miId;
  final String base;
  final int asmayId;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: color),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 36.0,
                        backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=388&q=80",
                        ),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            forHw
                                ? "${model!.studentname}"
                                : "${cwList!.studentname}",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .merge(const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.0)),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            forHw
                                ? "${model!.amstAdmno}"
                                : "${cwList!.amstAdmno}",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .merge(TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .color,
                                    fontSize: 14.0,
                                    letterSpacing: 0.2)),
                          ),
                        ],
                      ))
                    ],
                  )
                ]),
              ),
              forHw
                  ? const SizedBox()
                  : Text(
                      "02.75",
                      style: Theme.of(context).textTheme.titleSmall!.merge(
                            TextStyle(
                                fontSize: 20.0,
                                decoration: TextDecoration.underline,
                                color: Theme.of(context).primaryColor),
                          ),
                    ),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          Row(
            children: [
              Expanded(
                flex: 7,
                child: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return Dialog(
                            insetPadding: const EdgeInsets.all(16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 16.0),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      topRight: Radius.circular(8.0),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Attachment's",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .merge(
                                              const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0),
                                            ),
                                      ),
                                      IconButton(
                                          padding: const EdgeInsets.all(0),
                                          visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ))
                                    ],
                                  ),
                                ),
                                forHw
                                    ? FutureBuilder<
                                            List<HwStuAttachmentModelValues>>(
                                        future: GetStudentAttachmentApi.instance
                                            .getHomeWorkUploads(
                                                miId: miId,
                                                loginId:
                                                    loginSuccessModel.userId!,
                                                asmayId: asmayId,
                                                userId:
                                                    loginSuccessModel.userId!,
                                                amstId: model!.aMSTId!,
                                                iHwuplId: model!.iHWUPLId!,
                                                iHwId: model!.iHWId!,
                                                base: base),
                                        builder: (_, snapshot) {
                                          if (snapshot.hasData) {
                                            return ListView.separated(
                                                shrinkWrap: true,
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                itemBuilder: (_, index) {
                                                  if (snapshot.data!
                                                      .elementAt(index)
                                                      .ihwupLFileName!
                                                      .endsWith(".pdf")) {
                                                    return HwCwUploadedContentItem(
                                                      onViewClicked: () async {
                                                        if (await canLaunchUrl(
                                                            Uri.parse(snapshot
                                                                .data!
                                                                .elementAt(
                                                                    index)
                                                                .ihwupLAttachment!))) {
                                                          await launchUrl(
                                                              Uri.parse(snapshot
                                                                  .data!
                                                                  .elementAt(
                                                                      index)
                                                                  .ihwupLAttachment!),
                                                              mode: LaunchMode
                                                                  .externalApplication);
                                                        }
                                                      },
                                                      onDownloadClicked:
                                                          () async {
                                                        if (await canLaunchUrl(
                                                            Uri.parse(snapshot
                                                                .data!
                                                                .elementAt(
                                                                    index)
                                                                .ihwupLAttachment!))) {
                                                          await launchUrl(
                                                              Uri.parse(snapshot
                                                                  .data!
                                                                  .elementAt(
                                                                      index)
                                                                  .ihwupLAttachment!),
                                                              mode: LaunchMode
                                                                  .externalApplication);
                                                        }
                                                      },
                                                      title: snapshot.data!
                                                          .elementAt(index)
                                                          .ihwupLFileName!,
                                                      isPdf: true,
                                                    );
                                                  }
                                                  return HwCwUploadedContentItem(
                                                      onViewClicked: () async {
                                                        if ([
                                                          ".jpg",
                                                          ".png",
                                                          ".jpeg",
                                                          ".gif",
                                                        ].contains(p.extension(
                                                            "snapshot.data.elementAt(index).ihwupLAttachment"))) {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (_) => ViewImage(
                                                                      image: snapshot
                                                                          .data!
                                                                          .elementAt(
                                                                              index)
                                                                          .ihwupLAttachment!)));
                                                          return;
                                                        }
                                                        if (await canLaunchUrl(
                                                            Uri.parse(snapshot
                                                                .data!
                                                                .elementAt(
                                                                    index)
                                                                .ihwupLAttachment!))) {
                                                          await launchUrl(
                                                              Uri.parse(snapshot
                                                                  .data!
                                                                  .elementAt(
                                                                      index)
                                                                  .ihwupLAttachment!),
                                                              mode: LaunchMode
                                                                  .externalApplication);
                                                        }
                                                      },
                                                      onDownloadClicked:
                                                          () async {
                                                        if (await canLaunchUrl(
                                                            Uri.parse(snapshot
                                                                .data!
                                                                .elementAt(
                                                                    index)
                                                                .ihwupLAttachment!))) {
                                                          await launchUrl(
                                                              Uri.parse(snapshot
                                                                  .data!
                                                                  .elementAt(
                                                                      index)
                                                                  .ihwupLAttachment!),
                                                              mode: LaunchMode
                                                                  .externalApplication);
                                                        }
                                                      },
                                                      title: snapshot.data!
                                                          .elementAt(index)
                                                          .ihwupLFileName!,
                                                      isPdf: false);
                                                },
                                                separatorBuilder: (_, index) {
                                                  return const SizedBox(
                                                    height: 16.0,
                                                  );
                                                },
                                                itemCount:
                                                    snapshot.data!.length);
                                          }
                                          if (snapshot.hasError) {
                                            return ErrWidget(
                                                err: snapshot.error
                                                    as Map<String, dynamic>);
                                          }
                                          return const AnimatedProgressWidget(
                                            animationPath:
                                                "assets/json/default.json",
                                            title: "Loading attachment",
                                            desc:
                                                'Student uploaded files will appear here..',
                                          );
                                        })
                                    : FutureBuilder<
                                            List<CwStuAttachmentModelValues>>(
                                        future: GetStudentAttachmentApi.instance
                                            .getClassWorkUploads(
                                                miId: miId,
                                                loginId:
                                                    loginSuccessModel.userId!,
                                                asmayId: asmayId,
                                                userId:
                                                    loginSuccessModel.userId!,
                                                amstId: cwList!.aMSTId!,
                                                icwuplId: cwList!.iCWUPLId!,
                                                icwId: cwList!.iCWId!,
                                                base: base),
                                        builder: (_, snapshot) {
                                          if (snapshot.hasData) {
                                            return ListView.separated(
                                                shrinkWrap: true,
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                itemBuilder: (_, index) {
                                                  if (snapshot.data!
                                                      .elementAt(index)
                                                      .icwupLFileName!
                                                      .endsWith(".pdf")) {
                                                    return HwCwUploadedContentItem(
                                                      onViewClicked: () async {
                                                        if (await canLaunchUrl(
                                                            Uri.parse(snapshot
                                                                .data!
                                                                .elementAt(
                                                                    index)
                                                                .icwupLAttachment!))) {
                                                          await launchUrl(
                                                              Uri.parse(snapshot
                                                                  .data!
                                                                  .elementAt(
                                                                      index)
                                                                  .icwupLAttachment!),
                                                              mode: LaunchMode
                                                                  .externalApplication);
                                                        }
                                                      },
                                                      onDownloadClicked:
                                                          () async {
                                                        if (await canLaunchUrl(
                                                            Uri.parse(snapshot
                                                                .data!
                                                                .elementAt(
                                                                    index)
                                                                .icwupLAttachment!))) {
                                                          await launchUrl(
                                                              Uri.parse(snapshot
                                                                  .data!
                                                                  .elementAt(
                                                                      index)
                                                                  .icwupLAttachment!),
                                                              mode: LaunchMode
                                                                  .externalApplication);
                                                        }
                                                      },
                                                      title: snapshot.data!
                                                          .elementAt(index)
                                                          .icwupLAttachment!,
                                                      isPdf: true,
                                                    );
                                                  }
                                                  return HwCwUploadedContentItem(
                                                      onViewClicked: () async {
                                                        if ([
                                                          ".jpg",
                                                          ".png",
                                                          ".jpeg",
                                                          ".gif",
                                                        ].contains(p.extension(
                                                            "snapshot.data.elementAt(index).ihwupLAttachment"))) {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (_) => ViewImage(
                                                                      image: snapshot
                                                                          .data!
                                                                          .elementAt(
                                                                              index)
                                                                          .icwupLAttachment!)));
                                                          return;
                                                        }
                                                        if (await canLaunchUrl(
                                                            Uri.parse(snapshot
                                                                .data!
                                                                .elementAt(
                                                                    index)
                                                                .icwupLAttachment!))) {
                                                          await launchUrl(
                                                              Uri.parse(snapshot
                                                                  .data!
                                                                  .elementAt(
                                                                      index)
                                                                  .icwupLAttachment!),
                                                              mode: LaunchMode
                                                                  .externalApplication);
                                                        }
                                                      },
                                                      onDownloadClicked:
                                                          () async {
                                                        if (await canLaunchUrl(
                                                            Uri.parse(snapshot
                                                                .data!
                                                                .elementAt(
                                                                    index)
                                                                .icwupLAttachment!))) {
                                                          await launchUrl(
                                                              Uri.parse(snapshot
                                                                  .data!
                                                                  .elementAt(
                                                                      index)
                                                                  .icwupLAttachment!),
                                                              mode: LaunchMode
                                                                  .externalApplication);
                                                        }
                                                      },
                                                      title: snapshot.data!
                                                          .elementAt(index)
                                                          .icwupLAttachment!,
                                                      isPdf: false);
                                                },
                                                separatorBuilder: (_, index) {
                                                  return const SizedBox(
                                                    height: 16.0,
                                                  );
                                                },
                                                itemCount:
                                                    snapshot.data!.length);
                                          }
                                          if (snapshot.hasError) {
                                            return ErrWidget(
                                                err: snapshot.error
                                                    as Map<String, dynamic>);
                                          }
                                          return const AnimatedProgressWidget(
                                            animationPath:
                                                "assets/json/default.json",
                                            title: "Loading attachment",
                                            desc:
                                                'Student uploaded files will appear here..',
                                          );
                                        })
                              ],
                            ),
                          );
                        });
                  },
                  child: CustomContainer(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.attachment_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Text(
                            "View Attachment's",
                            style: Theme.of(context).textTheme.titleSmall,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Expanded(flex: 3, child: SizedBox())
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          // HwCwUploadedContentItem(
          //   onViewClicked: () {},
          //   onDownloadClicked: () {},
          //   isPdf: false,
          //   title: 'Eye Diagram',
          // ),
          // const SizedBox(
          //   height: 12.0,
          // ),
          // HwCwUploadedContentItem(
          //   onViewClicked: () {},
          //   onDownloadClicked: () {},
          //   isPdf: false,
          //   title: 'Intestine Description',
          // ),
          // const SizedBox(
          //   height: 12.0,
          // ),
          // HwCwUploadedContentItem(
          //   onViewClicked: () {},
          //   onDownloadClicked: () {},
          //   isPdf: true,
          //   title: 'Human eye',
          // ),
          // const SizedBox(
          //   height: 16.0,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return Dialog(
                          insetPadding: const EdgeInsets.all(16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 16.0),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Uploaded Files",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(
                                            const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.0),
                                          ),
                                    ),
                                    IconButton(
                                        padding: const EdgeInsets.all(0),
                                        visualDensity: const VisualDensity(
                                            horizontal:
                                                VisualDensity.minimumDensity,
                                            vertical:
                                                VisualDensity.minimumDensity),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                        ))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(children: [
                                  HwCwUploadedContentItem(
                                    onViewClicked: () {},
                                    onDownloadClicked: () {},
                                    isPdf: false,
                                    title: 'Eye Diagram',
                                    deleteAsset: "assets/svg/delete.svg",
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  HwCwUploadedContentItem(
                                    onViewClicked: () {},
                                    onDownloadClicked: () {},
                                    isPdf: false,
                                    title: 'Intestine Description',
                                    deleteAsset: "assets/svg/delete.svg",
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  HwCwUploadedContentItem(
                                    onViewClicked: () {},
                                    onDownloadClicked: () {},
                                    isPdf: true,
                                    title: 'Human eye',
                                    deleteAsset: "assets/svg/delete.svg",
                                  ),
                                ]),
                              )
                            ],
                          ),
                        );
                      });
                },
                child: Text(
                  "View Uploaded files",
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                        TextStyle(
                          color: Theme.of(context).primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(Get.width * 0.4, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    )),
                onPressed: () {},
                child: const Text("Upload"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
