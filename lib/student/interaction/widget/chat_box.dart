import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/student/interaction/screen/show_image_screen.dart';

class ChatBox extends StatelessWidget {
  final String name;
  final bool isFromMe;
  final String messages;
  final DateTime istintDateTime;
  final String attactment;
  const ChatBox(
      {required this.name,
      required this.isFromMe,
      required this.messages,
      required this.istintDateTime,
      required this.attactment,
      super.key});

  @override
  Widget build(BuildContext context) {
    Radius radius = const Radius.circular(10);
    Radius zero = const Radius.circular(0);
    Widget profile = CircleAvatar(
      backgroundColor: Theme.of(context).primaryColor,
      child: Text(name[0].toUpperCase(),
          style: const TextStyle(
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.w400)),
    );
    return Align(
      alignment: isFromMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment:
            isFromMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isFromMe) ...[profile, const SizedBox(width: 7)],
          Column(
            crossAxisAlignment:
                isFromMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              // Stack(
              //   children: [
              Container(
                width: messages.length > 18
                    ? MediaQuery.of(context).size.width / 2
                    : null,
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: isFromMe ? 25 : 10),
                decoration: BoxDecoration(
                    color: Color(isFromMe ? 0xffC1E2FF : 0xffEEEEEE),
                    borderRadius: BorderRadius.only(
                        topLeft: radius,
                        topRight: radius,
                        bottomLeft: isFromMe ? radius : zero,
                        bottomRight: isFromMe ? zero : radius)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    attactment.isNotEmpty
                        ? InkWell(
                            onTap: () {
                              Get.to(() => ShowImageScreen(
                                    image: attactment,
                                  ));
                            },
                            child: SizedBox(
                                height: 200,
                                width: 100,
                                child: Image.network(
                                  attactment,
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.cover,
                                )),
                          )
                        : const SizedBox(),
                    if (messages.isNotEmpty) const SizedBox(height: 5),
                    Text(messages,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
              // if (isFromMe)
              //   Positioned(
              //       right: 2,
              //       bottom: 2,
              //       child: SvgPicture.asset(
              //           "assets/svg/blue_double_check.svg"))
              //   ],
              // ),
              Text(
                convertToAgoShort(istintDateTime),
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          if (isFromMe) ...[const SizedBox(width: 7), profile],
        ],
      ),
    );
  }
}
