import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/online_leave/model/leave_name_model.dart';
import 'package:m_skool_flutter/staffs/online_leave/screen/apply_leave.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class Leaves extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final List<LeaveNamesModelValues> leaves;
  const Leaves(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.leaves});

  @override
  State<Leaves> createState() => _LeavesState();
}

class _LeavesState extends State<Leaves> {
  int backgroundColor = -1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 88,
        // width: double.infinity,
        child: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8.0),
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            backgroundColor += 1;

            if (index % 6 == 0) {
              backgroundColor = 0;
            }
            if (backgroundColor > 6) {
              backgroundColor = 0;
            }
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const ApplyForLeave();
                }));
              },
              child: LeaveNames(
                backgroundColor: backgroundColor,
                leave: widget.leaves.elementAt(index),
              ),
            );
          },
          itemCount: widget.leaves.length,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              width: 16.0,
            );
          },
        ),
      ),
    );
  }
}

class LeaveNames extends StatelessWidget {
  final LeaveNamesModelValues leave;
  const LeaveNames({
    Key? key,
    required this.backgroundColor,
    required this.leave,
  }) : super(key: key);

  final int backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.42,
      child: CustomContainer(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: leave.hrelSCBLeaves! / leave.hrelSTotalLeaves!,
                  backgroundColor: noticeBackgroundColor
                      .elementAt(backgroundColor)
                      .withOpacity(0.8),
                  color: noticeColor.elementAt(backgroundColor),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      leave.hrmLLeaveCode!.toLowerCase() == "sl"
                          ? "assets/images/sl.png"
                          : leave.hrmLLeaveCode!.toLowerCase() == "cl"
                              ? "assets/images/cl.png"
                              : leave.hrmLLeaveCode!.toLowerCase() == "el"
                                  ? "assets/images/el.png"
                                  : "assets/images/el.png",
                      color: noticeColor.elementAt(backgroundColor),
                      width: 24.0,
                    )),
              ],
            ),
            const SizedBox(
              width: 12.0,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${leave.hrelSCBLeaves!.toInt()}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    "${leave.hrmLLeaveName}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
