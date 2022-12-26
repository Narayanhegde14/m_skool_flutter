import 'package:get/get.dart';
import 'package:m_skool_flutter/apis/dashboard_apis.dart';
import 'package:m_skool_flutter/model/exam_graph_model.dart';
import 'package:m_skool_flutter/model/exam_list.dart';
import 'package:m_skool_flutter/model/student_dashboard_model.dart';

class DashboardController extends GetxController {
  RxList<AttendanceList> attendance = <AttendanceList>[].obs;
  RxList<FeesList> feeList = <FeesList>[].obs;
  RxList<TimeTableList> timeTableList = <TimeTableList>[].obs;
  RxList<ExamListNew> examList = <ExamListNew>[].obs;

  RxList<ExamGraphListValues> values = RxList();

  void addToValues(List<ExamGraphListValues> val) {
    if (values.isNotEmpty) {
      values.clear();
    }
    values.addAll(val);
  }

  RxBool isLoadingGraphData = RxBool(false);

  void updateIsLoadingGraphData(bool val) {
    isLoadingGraphData.value = val;
  }

  Rx<ExamListNewValues> selectedOption =
      Rx<ExamListNewValues>(ExamListNewValues());

  RxList<CalListValues> calList = RxList<CalListValues>();
  RxList<BirthdayListValues> birthday = RxList<BirthdayListValues>();
  Future studentDashBoardDetails({
    required int miId,
    required int asmayId,
    required int amstId,
    required String base,
    required int asmcLId,
    required int asmSId,
  }) async {
    StudentDashboardModel studentDashboardModel = await getStudentDashboardData(
      miId: miId,
      asmayId: asmayId,
      amstId: amstId,
      base: base,
      asmSId: asmSId,
      asmcLId: asmcLId,
    );

    if (studentDashboardModel.birthdayList != null) {
      if (birthday.isNotEmpty) {
        birthday.clear();
      }

      birthday.addAll(studentDashboardModel.birthdayList!.values!);
    }

    if (studentDashboardModel.calList != null) {
      calList.addAll(studentDashboardModel.calList!.values!);
    }

    if (studentDashboardModel.attendanceList != null) {
      attendance.add(studentDashboardModel.attendanceList!);
    }
    if (studentDashboardModel.feesList != null) {
      feeList.add(studentDashboardModel.feesList!);
    }
    if (studentDashboardModel.feesList != null) {
      feeList.add(studentDashboardModel.feesList!);
    }
    if (studentDashboardModel.timeTableList != null) {
      timeTableList.add(studentDashboardModel.timeTableList!);
    }
    if (studentDashboardModel.examList != null) {
      examList.add(studentDashboardModel.examList!);
    }
    selectedOption.value = studentDashboardModel.examList!.values!.first;
  }
}
