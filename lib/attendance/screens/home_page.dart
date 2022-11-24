import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:m_skool_flutter/attendance/api/get_academic_year.dart';
import 'package:m_skool_flutter/attendance/api/get_attendance_details.dart';
import 'package:m_skool_flutter/attendance/controller/attendance_handler.dart';
import 'package:m_skool_flutter/attendance/model/attendance_detail_model.dart';
import 'package:m_skool_flutter/attendance/screens/attendance_details.dart';
import 'package:m_skool_flutter/coe/models/academic_year_model.dart';
import 'package:m_skool_flutter/config/themes/theme_data.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/library/screen/library_home.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class AttendanceHomeScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const AttendanceHomeScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<AttendanceHomeScreen> createState() => _AttendanceHomeScreenState();
}

class _AttendanceHomeScreenState extends State<AttendanceHomeScreen> {
  List<String> dummySession = [
    "2017-2018",
    "2018-2019",
    "2019-2020",
    "2020-2021",
    "2021-2022",
  ];

  String selectedValue = "2021-2022";

  final AttendanceHandler handler = Get.put(AttendanceHandler());
  @override
  void initState() {
    getAttendanceDatum();
    super.initState();
  }

  Future<void> getAttendanceDatum() async {
    await GetAttendanceAcademicYear.instance.getAcademicYear(
      miId: widget.loginSuccessModel.mIID!,
      amstId: widget.loginSuccessModel.amsTId!,
      base: baseUrlFromInsCode("portal", widget.mskoolController),
      handler: handler,
    );

    await GetAttendanceDetails.instance.getAttendance(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: handler.asmayId.value,
      amstId: widget.loginSuccessModel.amsTId!,
      base: baseUrlFromInsCode("portal", widget.mskoolController),
      handler: handler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: const CustomGoBackButton(),
        leadingWidth: 30,
        title: Text("Attendance".tr),
      ),
      body: Obx(() {
        return handler.errorHappend.value
            ? const ErrWidget(err: {
                "errorTitle": "Unable to connect to server",
                "errorMsg":
                    "Sorry! but we are unable to connect to server right now, Try again later."
              })
            : handler.isLoadingWholeScreen.value
                ? const CustomPgrWidget(
                    title: "Getting your detail's",
                    desc:
                        "We are fetching your attendance directly from attendance register.")
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 16.0),
                        Obx(() {
                          return Container(
                            //padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(16.0),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 8,
                                  color: Colors.black12,
                                ),
                              ],
                            ),
                            child: DropdownButtonFormField<AttyearlistValues>(
                              value: handler.selectedInDorpDown.value,
                              decoration: InputDecoration(
                                // border: OutlineInputBorder(
                                //   borderRadius: BorderRadius.circular(12.0),
                                // ),
                                contentPadding: EdgeInsets.all(16.0),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),

                                label: Text(
                                  "Academic Year".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .merge(TextStyle(
                                          color: Colors.grey.shade600)),
                                ),
                              ),
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 30,
                              ),
                              iconSize: 30,
                              items: List.generate(
                                handler.academicYearList.length,
                                (index) => DropdownMenuItem<AttyearlistValues>(
                                  value:
                                      handler.academicYearList.elementAt(index),
                                  child: Text(
                                    handler.academicYearList
                                        .elementAt(index)
                                        .asmaYYear!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .merge(const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.0,
                                            letterSpacing: 0.3)),
                                  ),
                                ),
                              ),
                              onChanged: (s) async {
                                handler.updateSelectedInDropDown(s!);
                                handler.updateAsmayId(s.asmaYId!);
                                logger.d(handler.asmayId.value);
                                handler.updateIsLoadingAttendanceDetails(true);
                                await GetAttendanceDetails.instance
                                    .getAttendance(
                                        miId: widget.loginSuccessModel.mIID!,
                                        asmayId: handler.asmayId.value,
                                        amstId:
                                            widget.loginSuccessModel.amsTId!,
                                        base: baseUrlFromInsCode(
                                            "portal", widget.mskoolController),
                                        handler: handler);
                              },
                            ),
                          );
                        }),
                        // const SizedBox(
                        //   height: 8.0,
                        // ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     color: Theme.of(context).scaffoldBackgroundColor,
                        //     borderRadius: BorderRadius.circular(16.0),
                        //     boxShadow: const [
                        //       BoxShadow(
                        //         offset: Offset(0, 1),
                        //         blurRadius: 4,
                        //         color: Colors.black12,
                        //       ),
                        //     ],
                        //   ),
                        //   child: Column(
                        //     children: [
                        //       Container(
                        //         padding: const EdgeInsets.all(12.0),
                        //         decoration: BoxDecoration(
                        //           color: Theme.of(context).colorScheme.secondary,
                        //           borderRadius: const BorderRadius.only(
                        //             topLeft: Radius.circular(16.0),
                        //             topRight: Radius.circular(16.0),
                        //           ),
                        //         ),
                        //         child: Row(
                        //           crossAxisAlignment: CrossAxisAlignment.center,
                        //           children: [
                        //             Image.asset(
                        //               'assets/images/vpslogo.png',
                        //               height: 36,
                        //             ),
                        //             const SizedBox(
                        //               width: 12.0,
                        //             ),
                        //             Text(
                        //               "VAPS International School".tr,
                        //               style: Theme.of(context)
                        //                   .textTheme
                        //                   .titleMedium!
                        //                   .merge(const TextStyle(color: Color(0xFF35658F))),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       const SizedBox(
                        //         height: 8.0,
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.all(12.0),
                        //         child: Container(
                        //           //padding: const EdgeInsets.all(12.0),
                        //           decoration: BoxDecoration(
                        //             color: Theme.of(context).scaffoldBackgroundColor,
                        //             borderRadius: BorderRadius.circular(16.0),
                        //             boxShadow: const [
                        //               BoxShadow(
                        //                 offset: Offset(0, 1),
                        //                 blurRadius: 8,
                        //                 color: Colors.black12,
                        //               ),
                        //             ],
                        //           ),
                        //           child: DropdownButtonFormField<String>(
                        //             value: selectedValue,
                        //             decoration: InputDecoration(
                        //               // border: OutlineInputBorder(
                        //               //   borderRadius: BorderRadius.circular(12.0),
                        //               // ),

                        //               focusedBorder: const OutlineInputBorder(
                        //                 borderSide: BorderSide(
                        //                   color: Colors.transparent,
                        //                 ),
                        //               ),
                        //               enabledBorder: const OutlineInputBorder(
                        //                 borderSide: BorderSide(
                        //                   color: Colors.transparent,
                        //                 ),
                        //               ),

                        //               label: Text(
                        //                 "Academic Year".tr,
                        //                 style: Theme.of(context)
                        //                     .textTheme
                        //                     .labelLarge!
                        //                     .merge(TextStyle(color: Colors.grey.shade600)),
                        //               ),
                        //             ),
                        //             icon: const Icon(
                        //               Icons.keyboard_arrow_down_rounded,
                        //               size: 30,
                        //             ),
                        //             iconSize: 30,
                        //             items: List.generate(
                        //               dummySession.length,
                        //               (index) => DropdownMenuItem(
                        //                 value: dummySession.elementAt(index),
                        //                 child: Text(
                        //                   dummySession.elementAt(index),
                        //                   style: Theme.of(context)
                        //                       .textTheme
                        //                       .labelSmall!
                        //                       .merge(const TextStyle(
                        //                           fontWeight: FontWeight.w400,
                        //                           fontSize: 16.0,
                        //                           letterSpacing: 0.3)),
                        //                 ),
                        //               ),
                        //             ),
                        //             onChanged: (s) {},
                        //           ),
                        //         ),
                        //       ),
                        //       const SizedBox(
                        //         height: 8.0,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Obx(() {
                          return handler.isLoadingAttendanceDetails.value
                              ? const CustomPgrWidget(
                                  title: "Getting Details",
                                  desc:
                                      "We found your attendance register now we will see your presence.")
                              : handler.attendanceData.isEmpty
                                  ? Column(
                                      children: [
                                        Text(
                                          "No Data found ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        const SizedBox(
                                          height: 12.0,
                                        ),
                                        const Text(
                                            "For this academic year attendance register is empty.."),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                            boxShadow:
                                                CustomThemeData.getShadow(),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  100, 238, 232, 255),
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              //boxShadow: CustomThemeData.getShadow(),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        RichText(
                                                          text: TextSpan(
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelSmall!
                                                                .merge(
                                                                  const TextStyle(
                                                                    fontSize:
                                                                        15.0,
                                                                    //fontWeight: FontWeight.w400,
                                                                    letterSpacing:
                                                                        0.3,
                                                                  ),
                                                                ),
                                                            text:
                                                                "Total Class Held : "
                                                                    .tr,
                                                            children: [
                                                              TextSpan(
                                                                text:
                                                                    "${attendanceDetails(handler.attendanceData)['tch']}",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .labelSmall!
                                                                    .merge(
                                                                      const TextStyle(
                                                                        fontSize:
                                                                            15.0,
                                                                        letterSpacing:
                                                                            0.3,
                                                                      ),
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 8.0,
                                                        ),
                                                        RichText(
                                                          text: TextSpan(
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelSmall!
                                                                .merge(
                                                                  const TextStyle(
                                                                    fontSize:
                                                                        15.0,
                                                                    letterSpacing:
                                                                        0.3,
                                                                  ),
                                                                ),
                                                            text:
                                                                "Total Class Attended : "
                                                                    .tr,
                                                            children: [
                                                              TextSpan(
                                                                text:
                                                                    "${attendanceDetails(handler.attendanceData)['tca']}",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .labelSmall!
                                                                    .merge(
                                                                      const TextStyle(
                                                                        fontSize:
                                                                            15.0,
                                                                        letterSpacing:
                                                                            0.3,
                                                                      ),
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 8.0,
                                                        ),
                                                        RichText(
                                                          text: TextSpan(
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelSmall!
                                                                .merge(
                                                                  const TextStyle(
                                                                    fontSize:
                                                                        15.0,
                                                                    letterSpacing:
                                                                        0.3,
                                                                  ),
                                                                ),
                                                            text:
                                                                "Total Class Percentage : "
                                                                    .tr,
                                                            children: [
                                                              TextSpan(
                                                                text:
                                                                    "${attendanceDetails(handler.attendanceData)['tcp']}%",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .labelSmall!
                                                                    .merge(
                                                                      const TextStyle(
                                                                        fontSize:
                                                                            15.0,
                                                                        letterSpacing:
                                                                            0.3,
                                                                      ),
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Get.to(
                                                      () => AttendanceDetails(
                                                        details: attendanceDetails(
                                                            handler
                                                                .attendanceData),
                                                        handler: handler,
                                                      ),
                                                    );
                                                  },
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(16.0),
                                                    bottomRight:
                                                        Radius.circular(16.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Text(
                                                      "View",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall!
                                                          .merge(const TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline)),
                                                    ),
                                                  ),
                                                  // child: Container(
                                                  //   height: 100,
                                                  //   padding: const EdgeInsets.all(16.0),
                                                  //   decoration: BoxDecoration(
                                                  //     color: Theme.of(context).colorScheme.secondary,
                                                  //     borderRadius: const BorderRadius.only(
                                                  //       topRight: Radius.circular(16.0),
                                                  //       bottomRight: Radius.circular(16.0),
                                                  //     ),
                                                  //   ),
                                                  //   child: const Icon(
                                                  //     Icons.remove_red_eye_outlined,
                                                  //     color: Color(0xFF35658F),
                                                  //   ),
                                                  // ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 16.0,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                            boxShadow:
                                                CustomThemeData.getShadow(),
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                            child: DataTable(
                                                headingRowColor:
                                                    MaterialStateColor
                                                        .resolveWith(
                                                            (states) =>
                                                                Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary),
                                                border: const TableBorder(
                                                  //horizontalInside: BorderSide.,
                                                  verticalInside: BorderSide(
                                                      color: Colors.black12,
                                                      width: 1.0),
                                                ),
                                                columns: [
                                                  DataColumn(
                                                    label: Text(
                                                      "Months".tr,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall!
                                                          .merge(
                                                            const TextStyle(
                                                              fontSize: 16.0,
                                                              letterSpacing:
                                                                  0.3,
                                                            ),
                                                          ),
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    label: Flexible(
                                                      child: Text(
                                                        "Class Held".tr,
                                                        overflow: TextOverflow
                                                            .visible,
                                                        maxLines: 2,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall!
                                                            .merge(
                                                              const TextStyle(
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.3,
                                                              ),
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    label: Flexible(
                                                      fit: FlexFit.loose,
                                                      child: Text(
                                                        "Total Present".tr,
                                                        overflow: TextOverflow
                                                            .visible,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall!
                                                            .merge(
                                                              const TextStyle(
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.3,
                                                              ),
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                                rows: List.generate(
                                                    handler
                                                        .attendanceData.length,
                                                    (index) => populateData(
                                                        context,
                                                        handler.attendanceData
                                                            .elementAt(index)
                                                            .mONTHNAME!,
                                                        handler.attendanceData
                                                            .elementAt(index)
                                                            .cLASSHELD
                                                            .toString(),
                                                        handler.attendanceData
                                                            .elementAt(index)
                                                            .tOTALPRESENT
                                                            .toString()))),
                                          ),
                                        ),
                                      ],
                                    );
                        }),
                      ],
                    ),
                  );
      }),
    );
  }

  DataRow populateData(
      BuildContext context, String month, String classHeld, String present) {
    return DataRow(
      cells: [
        DataCell(
          Center(
            child: Text(
              month,
              style: Theme.of(context).textTheme.labelSmall!.merge(
                    const TextStyle(
                      fontSize: 14.0,
                      letterSpacing: 0.3,
                    ),
                  ),
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              classHeld,
              style: Theme.of(context).textTheme.labelSmall!.merge(
                    const TextStyle(
                      fontSize: 13.0,
                      letterSpacing: 0.3,
                    ),
                  ),
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              present,
              style: Theme.of(context).textTheme.labelSmall!.merge(
                    const TextStyle(
                      fontSize: 13.0,
                      letterSpacing: 0.3,
                    ),
                  ),
            ),
          ),
        ),
      ],
    );
  }

  Map<String, dynamic> attendanceDetails(
      RxList<AttendanceDetailValues> attendanceData) {
    int tca = 0;
    int tch = 0;
    double tcp = 0.0;
    for (int i = 0; i < attendanceData.length; i++) {
      final AttendanceDetailValues values = attendanceData.elementAt(i);
      tca += double.parse(values.tOTALPRESENT.toString()).toInt();
      tch += int.parse(values.cLASSHELD!);
    }

    tcp = ((tca / tch) * 100).toPrecision(1);

    return {
      "tca": tca,
      "tch": tch,
      "tcp": tcp,
    };
  }
}
