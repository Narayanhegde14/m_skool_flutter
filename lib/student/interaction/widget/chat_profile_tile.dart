import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/interaction/model/inbox_model.dart';
import 'package:m_skool_flutter/student/interaction/screen/messaging_section.dart';

class ChatProfileTile extends StatelessWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  // final bool isGroup;
  final bool isSeen;
  // final Color color;
  final GetinboxmsgValue data;
  const ChatProfileTile(
      {required this.loginSuccessModel,
      required this.mskoolController,
      // required this.isGroup,
      required this.isSeen,
      // required this.color,
      required this.data,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: () => Get.to(
        () => MessagingScreen(
          data: data,
          loginSuccessModel: loginSuccessModel,
          mskoolController: mskoolController,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
      leading:
          // data.receiverFilepath!.isNotEmpty
          //     ?
          CircleAvatar(
        radius: 30,
        // backgroundColor: color,
        backgroundImage: data.receiverFilepath!.isNotEmpty
            ? NetworkImage(data.receiverFilepath.toString())
            : const NetworkImage(
                "https://img.icons8.com/fluency/48/null/user-male-circle.png"),
      ),
      title: Text.rich(TextSpan(
          text: "${data.receiver}  |",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18),
          children: [
            TextSpan(
              text:
                  "  ${data.istintToFlg![0].toUpperCase()}${data.istintToFlg!.substring(1).toLowerCase()}",
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(fontSize: 18),
            )
          ])),
      subtitle: Row(
        children: [
          Flexible(
            child: Text(
              data.ismintSubject.toString(),
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(fontSize: 16),
            ),
          ),
          SvgPicture.asset(
            "assets/svg/double_check.svg",
            color: isSeen ? Colors.blue : Colors.grey,
          )
        ],
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              convertToAgo(data.ismintDateTime!),
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(fontSize: 14),
            ),
          ),
          const SizedBox(height: 15),
          //double_check.svg
          //blue_double_check.svg
          //single_check.svg
          // SvgPicture.asset(
          //     "assets/svg/${isSeen ? "blue_double_check.svg" : "double_check.svg"}")
        ],
      ),
    );
  }
}
