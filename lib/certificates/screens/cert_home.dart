import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:m_skool_flutter/certificates/screens/apply_now.dart';
import 'package:m_skool_flutter/certificates/screens/view_details.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/controller/tab_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class CertificateHomeScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const CertificateHomeScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<CertificateHomeScreen> createState() => _CertificateHomeScreenState();
}

class _CertificateHomeScreenState extends State<CertificateHomeScreen>
    with TickerProviderStateMixin {
  TabController? tabController;
  final TabStateController tabStateController =
      Get.put<TabStateController>(TabStateController());

  final List<Widget> tabsChildren = [];

  final PageController pageViewController = PageController();

  @override
  void initState() {
    tabsChildren.addAll([
      ApplyNow(
        loginSuccessModel: widget.loginSuccessModel,
        mskoolController: widget.mskoolController,
      ),
      ViewDetails(
        loginSuccessModel: widget.loginSuccessModel,
        mskoolController: widget.mskoolController,
      ),
    ]);
    tabController = TabController(length: 2, vsync: this);
    tabController!.addListener(() {
      tabStateController.updateSelectedIndex(tabController!.index);
      pageViewController.animateToPage(
        tabController!.index,
        duration: const Duration(
          milliseconds: 300,
        ),
        curve: Curves.fastOutSlowIn,
      );
    });

    super.initState();
  }

  @override
  void dispose() {
    tabController!.dispose();
    pageViewController.dispose();

    Get.delete<TabStateController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Certificate").getAppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: Obx(() {
              return Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                child: TabBar(
                  controller: tabController,
                  //indicatorColor: Get.theme.primaryColor,

                  indicator: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                  ),

                  tabs: [
                    Tab(
                      child: Text(
                        "Apply",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .merge(TextStyle(
                              color: tabStateController.selectedIndex.value == 0
                                  ? Get.theme.primaryColor
                                  : Colors.white,
                            )),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "View Details",
                        style: Theme.of(context).textTheme.titleMedium!.merge(
                              TextStyle(
                                color:
                                    tabStateController.selectedIndex.value == 1
                                        ? Get.theme.primaryColor
                                        : Colors.white,
                              ),
                            ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(
            height: 12.0,
          ),
          Expanded(
            child: SizedBox(
              height: Get.height,
              child: PageView.builder(
                controller: pageViewController,
                itemCount: tabsChildren.length,
                itemBuilder: (_, index) {
                  return tabsChildren.elementAt(index);
                },
                onPageChanged: (index) {
                  tabController!.animateTo(index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
