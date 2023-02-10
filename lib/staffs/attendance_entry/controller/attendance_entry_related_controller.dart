import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/api/attendance_entry_related_api.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/model/dailyonceAndDailytwiceStudentListModel.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/model/initialdataModel.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/model/monthwiseStudentListModel.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/model/periodwiseStudentlistModel.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/model/sectionModel.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/model/subjectModel.dart'
    as PWM;

class AttendanceEntryController extends GetxController {
  RxList<AcademicYearListValue> academicYearList =
      <AcademicYearListValue>[].obs;
  RxList<ClassListValue> classList = <ClassListValue>[].obs;
  RxList<SectionListValue> sectionList = <SectionListValue>[].obs;
  RxList<PWM.SubjectListValue> subjectList = <PWM.SubjectListValue>[].obs;
  RxList<PeriodlistValue> periodList = <PeriodlistValue>[].obs;
  RxList<MonthListValue> monthList = <MonthListValue>[].obs;

  RxList<MonthWiseStudentListValue> monthwiseStudentList =
      <MonthWiseStudentListValue>[].obs;
  RxList<DailyOnceAndDailyTwiceStudentListValue>
      dailyOnceAndDailyTwiceStudentList =
      <DailyOnceAndDailyTwiceStudentListValue>[].obs;
  RxList<PeroidWiseStudentListValue> periodwiseStudentList =
      <PeroidWiseStudentListValue>[].obs;

  RxList<TextEditingController> textEditingController =
      <TextEditingController>[].obs;
  RxList<bool> boolList = <bool>[].obs;

  RxString attendanceEntry = ''.obs;
  RxString attendanceEntryType = ''.obs;
  RxNum countClassHeld = RxNum(0.0);
  RxInt asaId = RxInt(0);

  RxBool isInitialData = RxBool(false);
  RxBool isSection = RxBool(false);
  RxBool isStudentData = RxBool(false);
  RxBool isSubject = RxBool(false);
  RxBool isSave = RxBool(false);

  // void addToTextFeildList(TextEditingController value) {
  //   textEditingController.add(value);
  // }

  // void addToBoolList(bool value) {
  //   boolList.add(value);
  // }

  void isinitialdataloading(bool loading) async {
    isInitialData.value = loading;
  }

  void issectionloading(bool loading) async {
    isSection.value = loading;
  }

  void isstudentdataloading(bool loading) async {
    isStudentData.value = loading;
  }

  void issubjectloading(bool loading) async {
    isSubject.value = loading;
  }

  void issaveloading(bool loading) async {
    isSave.value = loading;
  }

  Future<bool> getAttendanceEntryInitialData({
    required int asmayId,
    required int userId,
    required int miId,
    required String username,
    required int roleId,
    required String base,
  }) async {
    InitialDataModel? initialDataModel = await getAttendanceEntryIntialData(
        asmayId: asmayId,
        userId: userId,
        miId: miId,
        username: username,
        roleId: roleId,
        base: base);
    try {
      if (initialDataModel!.academicYearList != null ||
          initialDataModel.academicYearList!.values != null) {
        academicYearList.clear();
        for (var i = 0;
            i < initialDataModel.academicYearList!.values!.length;
            i++) {
          academicYearList
              .add(initialDataModel.academicYearList!.values!.elementAt(i)!);
        }
      }

      if (initialDataModel.classList != null ||
          initialDataModel.classList!.values != null) {
        classList.clear();
        for (var i = 0; i < initialDataModel.classList!.values!.length; i++) {
          classList.add(initialDataModel.classList!.values!.elementAt(i)!);
        }
      }

      if (initialDataModel.monthList != null ||
          initialDataModel.monthList!.values != null) {
        monthList.clear();
        for (var i = 0; i < initialDataModel.monthList!.values!.length; i++) {
          monthList.add(initialDataModel.monthList!.values!.elementAt(i)!);
        }
      }

      if (initialDataModel.periodlist != null ||
          initialDataModel.periodlist!.values != null) {
        periodList.clear();
        for (var i = 0; i < initialDataModel.periodlist!.values!.length; i++) {
          periodList.add(initialDataModel.periodlist!.values!.elementAt(i)!);
        }
        return true;
      }
      return false;
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }

  Future<bool> getSection({
    required int asmayId,
    required String asmclId,
    required int miId,
    required String username,
    required int roleId,
    required int userId,
    required String base,
  }) async {
    SectionModel? sectionModel = await getSectionData(
        asmayId: asmayId,
        asmclId: asmclId,
        miId: miId,
        username: username,
        roleId: roleId,
        userId: userId,
        base: base);

    try {
      if (sectionModel!.sectionList != null ||
          sectionModel.sectionList!.values != null) {
        sectionList.clear();
        attendanceEntryType.value = '';
        attendanceEntry.value = '';
        for (var i = 0; i < sectionModel.sectionList!.values!.length; i++) {
          sectionList.add(sectionModel.sectionList!.values!.elementAt(i)!);
        }
        attendanceEntry.value = sectionModel.asAAttEntryType!;
        attendanceEntryType.value = sectionModel.attendanceentryflag!;
        return true;
      }
      return false;
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }

  Future<bool> getAttendanceDataOnchangeofMonth({
    required int miId,
    required int asmayId,
    required int asmclId,
    required int asmsId,
    required int monthId,
    required String base,
  }) async {
    MonthWiseStudentListModel? studentListModel =
        await getAttendanceDataOnChangeofMonth(
            miId: miId,
            asmayId: asmayId,
            asmclId: asmclId,
            asmsId: asmsId,
            monthId: monthId,
            base: base);
    monthwiseStudentList.clear();
    try {
      if (studentListModel!.studentList != null ||
          studentListModel.studentList!.values != null) {
        for (var i = 0; i < studentListModel.studentList!.values!.length; i++) {
          monthwiseStudentList
              .add(studentListModel.studentList!.values!.elementAt(i)!);
          textEditingController.add(TextEditingController(
              text: studentListModel.studentList!.values!
                  .elementAt(i)!
                  .pdays!
                  .toString()));
        }
        countClassHeld.value = studentListModel.countclass!;
        asaId.value = studentListModel.asAId!;
        return true;
      }
      return false;
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }

  Future<bool> getAttendanceDataOnChangeOfSection({
    required int asmayId,
    required int userId,
    required int miId,
    required String username,
    required int roleId,
    required String fromDate,
    required String asmclId,
    required String asmsId,
    required String monthFlag,
    required String monthFlag1,
    required String base,
  }) async {
    DailyOnceAndDailyTwiceStudentListModel? studentListModel1 =
        await onChangeOfSection(
            asmayId: asmayId,
            userId: userId,
            miId: miId,
            username: username,
            roleId: roleId,
            fromDate: fromDate,
            asmclId: asmclId,
            asmsId: asmsId,
            monthFlag: monthFlag,
            monthFlag1: monthFlag1,
            base: base);

    try {
      if (studentListModel1!.studentList != null ||
          studentListModel1.studentList!.values != null) {
        dailyOnceAndDailyTwiceStudentList.clear();
        boolList.clear();
        for (var i = 0;
            i < studentListModel1.studentList!.values!.length;
            i++) {
          dailyOnceAndDailyTwiceStudentList
              .add(studentListModel1.studentList!.values!.elementAt(i)!);
          boolList.add(
              studentListModel1.studentList!.values!.elementAt(i)!.pdays == 0.0
                  ? false
                  : true);
        }
        asaId.value = studentListModel1.asAId!;
        return true;
      }
      return false;
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }

  Future<bool> getSubjectListOnChangeSection({
    required int asmayId,
    required String asmclId,
    required int asmsId,
    required int userId,
    required int miId,
    required String username,
    required int roleId,
    required String base,
  }) async {
    PWM.SubjectModel? subjectModel = await onChangeSection(
        asmayId: asmayId,
        asmclId: asmclId,
        asmsId: asmsId,
        userId: userId,
        miId: miId,
        username: username,
        roleId: roleId,
        base: base);
    try {
      if (subjectModel!.subjectList != null ||
          subjectModel.subjectList!.values != null) {
        subjectList.clear();
        for (var i = 0; i < subjectModel.subjectList!.values!.length; i++) {
          subjectList.add(subjectModel.subjectList!.values!.elementAt(i)!);
        }
        return true;
      }
      // if (subjectModel.studentList != null ||
      //     subjectModel.studentList!.values != null) {
      //   studentList2.clear();
      //   for (var i = 0; i < subjectModel.studentList!.values!.length; i++) {
      //     studentList2.add(subjectModel.studentList!.values!.elementAt(i)!);
      //   }
      //   asaId.value = subjectModel.asAId!;
      //   return true;
      // }
      return false;
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }

  Future<bool> getStudentListOnChangePeriod({
    required int asmayId,
    required int asmclId,
    required int asmsId,
    required int ttmpId,
    required int ismsId,
    required int miId,
    required String base,
  }) async {
    PeriodWiseStudentListModel? periodWiseStudentListModel =
        await onChangeOfPeriod(
            asmayId: asmayId,
            asmclId: asmclId,
            asmsId: asmsId,
            ttmpId: ttmpId,
            ismsId: ismsId,
            miId: miId,
            base: base);
    try {
      if (periodWiseStudentListModel!.studentList != null ||
          periodWiseStudentListModel.studentList!.values != null) {
        for (var i = 0;
            i < periodWiseStudentListModel.studentList!.values!.length;
            i++) {
          periodwiseStudentList.add(
              periodWiseStudentListModel.studentList!.values!.elementAt(i)!);
          boolList.add(periodWiseStudentListModel.studentList!.values!
                      .elementAt(i)!
                      .pdays ==
                  0.0
              ? false
              : true);
        }
        asaId.value = periodWiseStudentListModel.asAId!;
        return true;
      }
      return false;
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }
}
