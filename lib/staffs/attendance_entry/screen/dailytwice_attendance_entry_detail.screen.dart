import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/api/attendance_entry_related_api.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/controller/attendance_entry_related_controller.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/widget/attendance_checkbox_widget.dart';
import 'package:m_skool_flutter/staffs/marks_entry/widget/save_button.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';

class DailyTwiceAttendanceEntryDetailScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final int asaId;
  final int asmayId;
  final int asmclId;
  final int asmsId;
  const DailyTwiceAttendanceEntryDetailScreen({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
    required this.asaId,
    required this.asmayId,
    required this.asmclId,
    required this.asmsId,
  });

  @override
  State<DailyTwiceAttendanceEntryDetailScreen> createState() =>
      _DailyTwiceAttendanceEntryDetailScreenState();
}

class _DailyTwiceAttendanceEntryDetailScreenState
    extends State<DailyTwiceAttendanceEntryDetailScreen> {
  final AttendanceEntryController attendanceEntryController =
      Get.put(AttendanceEntryController());
  bool selectAll = false;
  List<Map<String, dynamic>> stdList = [];

  void addToStudentList(Map<String, dynamic> data) {
    stdList.add(data);
    logger.d(stdList);
  }

  void removeFromStudentList(int rollNo) {
    stdList.removeWhere((element) => element['amaY_RollNo'] == rollNo);
    logger.d(stdList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomGoBackButton(),
        leadingWidth: 25,
        title: const Text('Attendance Entry'),
        actions: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 13.0, horizontal: 16.0),
            child: SaveBtn(
              title: 'Save',
              onPress: () async {
                if (stdList.isEmpty) {
                  Fluttertoast.showToast(msg: 'Select Attendance');
                  return;
                }
                stdList.clear();
                for (var i = 0;
                    i <
                        attendanceEntryController
                            .dailyOnceAndDailyTwiceStudentList.length;
                    i++) {
                  stdList.add(
                    {
                      "amaY_RollNo": attendanceEntryController
                          .dailyOnceAndDailyTwiceStudentList
                          .elementAt(i)
                          .amaYRollNo,
                      "amsT_AdmNo": attendanceEntryController
                          .dailyOnceAndDailyTwiceStudentList
                          .elementAt(i)
                          .amsTAdmNo,
                      "amsT_Id": attendanceEntryController
                          .dailyOnceAndDailyTwiceStudentList
                          .elementAt(i)
                          .amsTId,
                      "studentname": attendanceEntryController
                          .dailyOnceAndDailyTwiceStudentList
                          .elementAt(i)
                          .studentname,
                      "pdays": 0.0,
                      "selected": null,
                      "ASAS_Id": attendanceEntryController
                          .dailyOnceAndDailyTwiceStudentList
                          .elementAt(i)
                          .asaSId,
                      "FirstHalfflag": true,
                      "SecondHalfflag": true,
                      "asA_Dailytwice_Flag": null,
                      "asA_Id": attendanceEntryController
                          .dailyOnceAndDailyTwiceStudentList
                          .elementAt(i)
                          .asAId,
                      "TTMP_Id": null,
                      "ISMS_Id": 0,
                      "asasB_Id": 0,
                      "amsT_RegistrationNo": attendanceEntryController
                          .dailyOnceAndDailyTwiceStudentList
                          .elementAt(i)
                          .amsTRegistrationNo
                    },
                  );
                }
                attendanceEntryController.issaveloading(true);
                await saveAttendanceEntry(
                  data: {
                    "ASA_Id": widget.asaId,
                    "MI_Id": widget.loginSuccessModel.mIID!,
                    "ASMAY_Id": widget.asmayId,
                    "ASA_Att_Type": "Dailytwice",
                    "ASA_Att_EntryType":
                        attendanceEntryController.attendanceEntryType.value ==
                                'P'
                            ? 'Present'
                            : 'Absent',
                    "ASMCL_Id": widget.asmclId,
                    "ASMS_Id": widget.asmsId,
                    "ASA_Entry_DateTime": DateTime.now().toString(),
                    "ASA_FromDate": DateTime.now().toString(),
                    "ASA_ToDate": DateTime.now().toString(),
                    "ASA_ClassHeld": "1.00",
                    "ASA_Regular_Extra": "Regular",
                    "ASA_Network_IP": "::1",
                    "ASAS_Id": null,
                    "AMST_Id": 0,
                    "ASA_Class_Attended": 0.0,
                    "stdList": stdList,
                    "username": widget.loginSuccessModel.userName!,
                    "userId": widget.loginSuccessModel.userId!,
                    "ismS_Id": 0,
                    "TTMP_Id": 0,
                    "attcount": 0,
                    "asasB_Id": 0
                  },
                  base: baseUrlFromInsCode(
                    'admission',
                    widget.mskoolController,
                  ),
                ).then((value) => logger.d(value));
                attendanceEntryController.issaveloading(false);
              },
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 70),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            child: InkWell(
              child: Container(
                height: 40,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:
                      Colors.white, //Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.grey.withOpacity(0.6),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text("Search",
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: Colors.grey.withOpacity(0.6),
                                )),
                      ),
                      const SizedBox(
                        width: 220,
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {},
            ),
          ),
        ),
      ),
      floatingActionButton: const HomeFab(),
      body: Obx(
        () => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10, right: 10, top: 10, bottom: 100),
            child: Column(
              children: [
                SizedBox(
                  height: 33,
                  child: CheckboxListTile(
                    checkboxShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    dense: true,
                    activeColor: Theme.of(context).primaryColor,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    visualDensity: const VisualDensity(horizontal: -4.0),
                    title: Text(
                      "Select All",
                      style: Theme.of(context).textTheme.labelSmall!.merge(
                          const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                              letterSpacing: 0.3)),
                    ),
                    value: selectAll,
                    onChanged: (value) {
                      setState(() {
                        selectAll = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: DataTable(
                        dataTextStyle: const TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(0, 0, 0, 0.95),
                            fontWeight: FontWeight.w500),
                        dataRowHeight: 45,
                        headingRowHeight: 40,
                        horizontalMargin: 8,
                        columnSpacing: 30,
                        dividerThickness: 0.1,
                        showCheckboxColumn: true,

                        headingTextStyle: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                        border: TableBorder.all(
                          borderRadius: BorderRadius.circular(12),
                          width: 0.6,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        // showBottomBorder: true,
                        headingRowColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                        columns: const [
                          DataColumn(
                            numeric: true,
                            label: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'S.No',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Name',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Roll No',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Adm. No',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Attendance',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Twice\nAttendance',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],

                        rows: List.generate(
                            attendanceEntryController
                                .dailyOnceAndDailyTwiceStudentList
                                .length, (index) {
                          var i = index + 1;
                          return DataRow(
                            cells: [
                              DataCell(Align(
                                  alignment: Alignment.center,
                                  child: Text('$i',
                                      overflow: TextOverflow.ellipsis))),
                              DataCell(
                                Text(
                                    '${attendanceEntryController.dailyOnceAndDailyTwiceStudentList.elementAt(index).studentname}',
                                    overflow: TextOverflow.ellipsis),
                              ),
                              DataCell(
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                      '${attendanceEntryController.dailyOnceAndDailyTwiceStudentList.elementAt(index).amaYRollNo}',
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                              DataCell(
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                      '${attendanceEntryController.dailyOnceAndDailyTwiceStudentList.elementAt(index).amsTAdmNo}',
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                              DataCell(
                                Align(
                                  alignment: Alignment.center,
                                  child: AttendanceCheckboxWidget(
                                    index: index,
                                    attendance: selectAll
                                        ? true
                                        : attendanceEntryController
                                                        .dailyOnceAndDailyTwiceStudentList
                                                        .elementAt(index)
                                                        .pdays ==
                                                    0.50 &&
                                                attendanceEntryController
                                                        .dailyOnceAndDailyTwiceStudentList
                                                        .elementAt(index)
                                                        .asaDailytwiceFlag!
                                                        .toLowerCase() ==
                                                    'secondhalf'
                                            ? true
                                            : false,
                                    admNo: attendanceEntryController
                                        .dailyOnceAndDailyTwiceStudentList
                                        .elementAt(index)
                                        .amsTAdmNo!,
                                    amstId: attendanceEntryController
                                        .dailyOnceAndDailyTwiceStudentList
                                        .elementAt(index)
                                        .amsTId!,
                                    amstRegistrationNo:
                                        attendanceEntryController
                                            .dailyOnceAndDailyTwiceStudentList
                                            .elementAt(index)
                                            .amsTRegistrationNo!,
                                    rollNo: attendanceEntryController
                                        .dailyOnceAndDailyTwiceStudentList
                                        .elementAt(index)
                                        .amaYRollNo!,
                                    studentName: attendanceEntryController
                                        .dailyOnceAndDailyTwiceStudentList
                                        .elementAt(index)
                                        .studentname!,
                                    attendanceEntryController:
                                        attendanceEntryController,
                                  ),
                                ),
                              ),
                              DataCell(
                                Align(
                                  alignment: Alignment.center,
                                  child: AttendanceCheckboxWidget(
                                    index: index,
                                    attendance: selectAll
                                        ? true
                                        : attendanceEntryController
                                                        .dailyOnceAndDailyTwiceStudentList
                                                        .elementAt(index)
                                                        .pdays ==
                                                    0.50 &&
                                                attendanceEntryController
                                                        .dailyOnceAndDailyTwiceStudentList
                                                        .elementAt(index)
                                                        .asaDailytwiceFlag!
                                                        .toLowerCase() ==
                                                    'firsthalf'
                                            ? true
                                            : false,
                                    admNo: attendanceEntryController
                                        .dailyOnceAndDailyTwiceStudentList
                                        .elementAt(index)
                                        .amsTAdmNo!,
                                    amstId: attendanceEntryController
                                        .dailyOnceAndDailyTwiceStudentList
                                        .elementAt(index)
                                        .amsTId!,
                                    amstRegistrationNo:
                                        attendanceEntryController
                                            .dailyOnceAndDailyTwiceStudentList
                                            .elementAt(index)
                                            .amsTRegistrationNo!,
                                    rollNo: attendanceEntryController
                                        .dailyOnceAndDailyTwiceStudentList
                                        .elementAt(index)
                                        .amaYRollNo!,
                                    studentName: attendanceEntryController
                                        .dailyOnceAndDailyTwiceStudentList
                                        .elementAt(index)
                                        .studentname!,
                                    attendanceEntryController:
                                        attendanceEntryController,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
