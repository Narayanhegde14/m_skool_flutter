import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/card_widget.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../main.dart';

class SchoolDetailsScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  const SchoolDetailsScreen({super.key, required this.loginSuccessModel});

  @override
  State<SchoolDetailsScreen> createState() => _SchoolDetailsScreenState();
}

class _SchoolDetailsScreenState extends State<SchoolDetailsScreen> {
  MskoolController mskoolController = Get.find<MskoolController>();

  final VideoPlayerController controller =
      VideoPlayerController.asset("assets/video/highschool.mp4");

  @override
  void initState() {
    controller.initialize().then((value) {
      controller.play();
      controller.setLooping(true);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    logger.d(mskoolController.universalInsCodeModel!.toJson());
    return Scaffold(
      appBar: AppBar(
        leading: const CustomGoBackButton(),
        leadingWidth: 30,
        title: const Text("School Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // SvgPicture.asset(
            //   "assets/svg/ShoolDetails.svg",
            //   fit: BoxFit.cover,
            //   // color: Colors.red,
            // ),
            AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller)),
            Transform.translate(
              offset: const Offset(0, -36),
              child: CardWidget(
                backgroundColor: const Color(0xFFF2FEFF),
                padding: const EdgeInsets.all(10),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 120,
                        child: Text(
                          "Name",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .merge(const TextStyle(fontSize: 16.0)),
                        ),
                      ),
                      const Text(":  "),
                      Flexible(
                        child: Text(
                          "${widget.loginSuccessModel.institutedetails!.values!.first.mIName}",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .merge(const TextStyle(fontSize: 16.0)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            "Address",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .merge(const TextStyle(fontSize: 16.0)),
                          ),
                        ),
                        const Text(":  "),
                        Flexible(
                          child: Text(
                            "${widget.loginSuccessModel.institutedetails!.values!.first.mIAddress1}"
                            " ${widget.loginSuccessModel.institutedetails!.values!.first.mIAddress2},"
                            " ${widget.loginSuccessModel.institutedetails!.values!.first.mIAddress3}.",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .merge(const TextStyle(fontSize: 16.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            "E-mail Id",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .merge(const TextStyle(fontSize: 16.0)),
                          ),
                        ),
                        const Text(":  "),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${widget.loginSuccessModel.institutedetails!.values!.first.mIEEmailId}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .merge(const TextStyle(fontSize: 16.0)),
                                textAlign: TextAlign.left,
                              ),
                              InkWell(
                                  onTap: () async {
                                    if (await canLaunchUrl(Uri.parse(
                                        "mailto:${widget.loginSuccessModel.institutedetails!.values!.first.mIEEmailId}"))) {
                                      await launchUrl(Uri.parse(
                                          "mailto:${widget.loginSuccessModel.institutedetails!.values!.first.mIEEmailId}"));
                                    }
                                  },
                                  child:
                                      SvgPicture.asset('assets/svg/mail.svg')),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            "Contact Number",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .merge(const TextStyle(fontSize: 16.0)),
                          ),
                        ),
                        const Text(":  "),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${widget.loginSuccessModel.institutedetails!.values!.first.mIMNMobileNo} / ${widget.loginSuccessModel.institutedetails!.values!.first.mIPNPhoneNo}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .merge(const TextStyle(fontSize: 16.0)),
                              ),
                              InkWell(
                                  onTap: () async {
                                    if (await canLaunchUrl(Uri.parse(
                                        "tel:${widget.loginSuccessModel.institutedetails!.values!.first.mIMNMobileNo}"))) {
                                      await launchUrl(Uri.parse(
                                          "tel:${widget.loginSuccessModel.institutedetails!.values!.first.mIMNMobileNo}"));
                                    }
                                  },
                                  child:
                                      SvgPicture.asset('assets/svg/phone.svg')),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 120,
                          child: Expanded(
                            child: Text(
                              "Website",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .merge(const TextStyle(fontSize: 16.0)),
                            ),
                          ),
                        ),
                        const Text(":  "),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Text(
                            "${widget.loginSuccessModel.institutedetails!.values!.first}",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .merge(const TextStyle(fontSize: 16.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // SvgPicture.asset(
            //   "assets/svg/ShoolDetails.svg",
            //   // color: Colors.red,
            // ),
            const SizedBox()
          ],
        ),
      ),
    );
  }
}
