import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/homework/screen/home_work.dart';
import 'package:m_skool_flutter/homework/screen/hwcw_detail_screen.dart';
import 'package:m_skool_flutter/information/controller/hwcwnb_controller.dart';
import 'package:m_skool_flutter/library/screen/library_home.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/notice/api/get_datewise_notices.dart';
import 'package:m_skool_flutter/notice/api/get_notice_api.dart';
import 'package:m_skool_flutter/notice/screen/notice_detail_screen.dart';
import 'package:m_skool_flutter/notice/screen/notice_home.dart';

class NoticeFilteredWidget extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final HwCwNbController hwCwNbController;
  const NoticeFilteredWidget(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.hwCwNbController});

  @override
  State<NoticeFilteredWidget> createState() => _NoticeFilteredWidgetState();
}

class _NoticeFilteredWidgetState extends State<NoticeFilteredWidget> {
  int color = -1;
  List<Color> usedColor = [];

  @override
  void initState() {
    getNotices();
    super.initState();
  }

  Future<void> getNotices() async {
    await GetDateWiseNotice.instance.getNotices(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: widget.loginSuccessModel.asmaYId!,
      amstId: widget.loginSuccessModel.amsTId!,
      base: baseUrlFromInsCode("portal", widget.mskoolController),
      startDate: widget.hwCwNbController.dtList.first.toLocal().toString(),
      endDate: widget.hwCwNbController.dtList.last.toLocal().toString(),
      nbController: widget.hwCwNbController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return widget.hwCwNbController.isNoticeDataLoading.value
          ? const CustomPgrWidget(
              title: "Loading Fitered Data",
              desc: "Please wait while we load new data for you")
          : widget.hwCwNbController.noticeList.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      Text(
                        "No Notice Found",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Text(
                          "We couldn't find any notice for these filtration")
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: widget.hwCwNbController.noticeList.length,
                  itemBuilder: (_, index) {
                    color += 1;
                    if (index % 6 == 0) {
                      color = 0;
                    }
                    if (color > 6) {
                      color = 0;
                    }

                    usedColor.add(noticeColor.elementAt(color));
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return NoticeDetailScreen(
                            color: noticeColor.elementAt(color),
                            value: widget.hwCwNbController.noticeList
                                .elementAt(index),
                            isFiltring: true,
                          );
                        }));
                      },
                      child: NoticeItem(
                          color: color,
                          values: widget.hwCwNbController.noticeList
                              .elementAt(index)),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 16.0,
                    );
                  },
                );
    });
  }
}
