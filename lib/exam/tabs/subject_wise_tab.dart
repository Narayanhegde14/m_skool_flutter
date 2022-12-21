import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/exam/controller/exam_controller.dart';
import 'package:m_skool_flutter/exam/model/pie_data_model.dart';
import 'package:m_skool_flutter/exam/model/subjectoverview_model.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../controller/global_utilities.dart';
import '../../controller/mskoll_controller.dart';
import '../../main.dart';
import '../../model/login_success_model.dart';
import '../apis/exam_related_api.dart';
import '../model/academic_year_model.dart';
import '../model/subject_list_model.dart';
import '../widget/result_analysis_item.dart';
import '../widget/subjectwise_container.dart';

class SubjectWiseTab extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const SubjectWiseTab({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  State<SubjectWiseTab> createState() => _SubjectWiseTabState();
}

class _SubjectWiseTabState extends State<SubjectWiseTab> {
  final examController = Get.put(ExamController());
  AcademicYearValues? selectedYear;

  SubjectListValue? selectedSubject;

  void getsubjecData(int ismsID) async {
    examController.subjectwiseMarkOverview.clear();
    examController.issubjectData(true);
    await examController.getSubjectWiseOverviewData(
        miID: widget.loginSuccessModel.mIID!,
        asmayID: selectedYear!.asmaYId!,
        asmtID: widget.loginSuccessModel.amsTId!,
        ismsID: ismsID,
        base: baseUrlFromInsCode(
          'portal',
          widget.mskoolController,
        ));
    examController.issubjectData(false);
  }

  void getsubList(int asmayID) async {
    examController.subjectList.clear();
    examController.issubjectwiseloading(true);
    await examController
        .getSubjectListData(
            miID: widget.loginSuccessModel.mIID!,
            amstID: widget.loginSuccessModel.amsTId!,
            asmayID: asmayID,
            base: baseUrlFromInsCode(
              'portal',
              widget.mskoolController,
            ))
        .then((value) {
      if (value) {
        selectedSubject = examController.subjectList.first;
        getsubjecData(selectedSubject!.ismSId!);
      }
    });
    examController.issubjectwiseloading(false);
  }

  getAcademicYear() async {
    examController.issubjectwiseloading(true);
    await examController
        .getAcademicYearData(
            miID: widget.loginSuccessModel.mIID!,
            amstID: widget.loginSuccessModel.amsTId!,
            base: baseUrlFromInsCode(
              'portal',
              widget.mskoolController,
            ))
        .then((value) async {
      if (value) {
        selectedYear = examController.academicYearList.first;
        getsubList(this.selectedYear!.asmaYId!);
      }
    });
    examController.issubjectwiseloading(false);
  }

  RxBool showGraph = RxBool(false);

  @override
  void initState() {
    super.initState();
    getAcademicYear();
  }

  int color = -1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Obx(
        () => examController.isSubjectWiseLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : examController.academicYearList.isEmpty
                ? Center(
                    child: Text(
                      'Unable to fetch data from server...',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .merge(const TextStyle(
                            color: Colors.black,
                            fontSize: 19.0,
                          )),
                    ),
                  )
                : Column(
                    children: [
                      const SizedBox(
                        height: 16.0,
                      ),
                      Column(
                        children: [
                          Container(
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
                            child: DropdownButtonFormField<AcademicYearValues>(
                              isExpanded: true,
                              value: examController.selectedYear,
                              decoration: InputDecoration(
                                // border: OutlineInputBorder(
                                //   borderRadius: BorderRadius.circular(12.0),
                                // ),
                                // contentPadding: const EdgeInsets.symmetric(
                                //     vertical: 12.0, horizontal: 12.0),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18.0, horizontal: 12.0),
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

                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 6.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24.0),
                                      color: const Color(0xFFDFFBFE)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        "assets/images/cap.png",
                                        height: 28.0,
                                      ),
                                      const SizedBox(
                                        width: 6.0,
                                      ),
                                      Text(
                                        "Academic Year".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .merge(const TextStyle(
                                                fontSize: 20,
                                                color: Color(0xFF28B6C8))),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 30,
                              ),
                              iconSize: 30,
                              items: List.generate(
                                examController.academicYearList.length,
                                (index) {
                                  return DropdownMenuItem<AcademicYearValues>(
                                    value: examController.academicYearList
                                        .elementAt(index),
                                    child: Text(
                                      examController.academicYearList
                                          .elementAt(index)
                                          .asmaYYear!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .merge(const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.0,
                                            letterSpacing: 0.3,
                                          )),
                                    ),
                                  );
                                },
                              ),
                              onChanged: (s) {
                                examController.selectedYear = s;
                                getsubList(s!.asmaYId!);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 24.0,
                          ),
                          Container(
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
                            child: DropdownButtonFormField<SubjectListValue>(
                              isExpanded: true,
                              value: selectedSubject,
                              decoration: InputDecoration(
                                  // border: OutlineInputBorder(
                                  //   borderRadius: BorderRadius.circular(12.0),
                                  // ),
                                  // contentPadding: const EdgeInsets.symmetric(
                                  //     vertical: 12.0, horizontal: 12.0),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 18.0, horizontal: 12.0),
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

                                  // label: Text(
                                  //   'Select Subject',
                                  //   style: Theme.of(context)
                                  //       .textTheme
                                  //       .labelLarge!
                                  //       .merge(TextStyle(
                                  //         color: Colors.grey.shade600,
                                  //       )),
                                  // ),
                                  label: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 8.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                        color: const Color(0xFFFFEBEA)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/exam_icon_.svg',
                                          height: 24.0,
                                        ),
                                        const SizedBox(
                                          width: 8.0,
                                        ),
                                        Text(
                                          'Select Subject',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .merge(const TextStyle(
                                                  color: Color(0xFFFF6F67),
                                                  fontSize: 20.0)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always),
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 30,
                              ),
                              iconSize: 30,
                              items: List.generate(
                                  examController.subjectList.length, (index) {
                                return DropdownMenuItem<SubjectListValue>(
                                  value: examController.subjectList
                                      .elementAt(index),
                                  child: Text(
                                    examController.subjectList
                                        .elementAt(index)
                                        .ismSSubjectName!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .merge(const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.0,
                                            letterSpacing: 0.3)),
                                  ),
                                );
                              }),
                              onChanged: (s) {
                                selectedSubject = s;
                                getsubjecData(s!.ismSId!);
                              },
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      // const CircularProgressIndicator(),
                      examController.issubjectdata.value
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Exam - Wise Assessment',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .merge(
                                              const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                width: 1.5)),
                                        child: Row(
                                          children: [
                                            Obx(() {
                                              return InkWell(
                                                onTap: () {
                                                  showGraph.value = false;
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12.0,
                                                      vertical: 6.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft: Radius.circular(
                                                        24.0,
                                                      ),
                                                      bottomLeft:
                                                          Radius.circular(24.0),
                                                    ),
                                                    color: showGraph.value
                                                        ? Colors.transparent
                                                        : Theme.of(context)
                                                            .primaryColor,
                                                  ),
                                                  child: Text(
                                                    "Static",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .merge(TextStyle(
                                                            color: showGraph
                                                                    .value
                                                                ? Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleSmall!
                                                                    .color
                                                                : Colors
                                                                    .white)),
                                                  ),
                                                ),
                                              );
                                            }),
                                            Obx(() {
                                              return InkWell(
                                                onTap: () {
                                                  showGraph.value = true;
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12.0,
                                                      vertical: 6.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topRight: Radius.circular(
                                                        24.0,
                                                      ),
                                                      bottomRight:
                                                          Radius.circular(24.0),
                                                    ),
                                                    color: showGraph.value
                                                        ? Theme.of(context)
                                                            .primaryColor
                                                        : Colors.transparent,
                                                  ),
                                                  child: Text(
                                                    "Graph",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .merge(TextStyle(
                                                            color: showGraph
                                                                    .value
                                                                ? Colors.white
                                                                : Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleSmall!
                                                                    .color)),
                                                  ),
                                                ),
                                              );
                                            }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  examController
                                          .subjectwiseMarkOverview.isNotEmpty
                                      ? Obx(() {
                                          color = -1;
                                          return showGraph.value
                                              ? ListView.separated(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: examController
                                                      .subjectwiseMarkOverview
                                                      .length,
                                                  itemBuilder: (_, index) {
                                                    color += 1;
                                                    if (index % 4 == 0) {
                                                      color = 0;
                                                    }
                                                    if (color > 4) {
                                                      color = 0;
                                                    }
                                                    return CustomContainer(
                                                      child:
                                                          GraphSubjectWiseResultItem(
                                                        datamodel: examController
                                                            .subjectwiseMarkOverview
                                                            .elementAt(index),
                                                        chipColor: chipColor
                                                            .elementAt(color),
                                                        textColor: textColor
                                                            .elementAt(color),
                                                        gradeColor: pieColor
                                                            .elementAt(color),
                                                        containerColor:
                                                            examCardColor
                                                                .elementAt(
                                                                    color),
                                                        obtainedColor: pieColor
                                                            .elementAt(color),
                                                        pieColor: examCardColor
                                                            .elementAt(color),
                                                      ),
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return const SizedBox(
                                                      height: 16.0,
                                                    );
                                                  },
                                                )
                                              : ListView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: examController
                                                      .subjectwiseMarkOverview
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    color += 1;
                                                    if (index % 4 == 0) {
                                                      color = 0;
                                                    }
                                                    if (color > 4) {
                                                      color = 0;
                                                    }
                                                    return SubjectWiseContainer(
                                                      datamodel: examController
                                                          .subjectwiseMarkOverview
                                                          .elementAt(index),
                                                      chipColor: examController
                                                          .chipColor
                                                          .elementAt(color),
                                                      containerColor:
                                                          examController
                                                              .containerColor
                                                              .elementAt(color),
                                                      gradeColor: examController
                                                          .gradeColor
                                                          .elementAt(color),
                                                    );
                                                  },
                                                );
                                        })
                                      : Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20.0),
                                            child: Text(
                                              'No data for selected subject....',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium!
                                                  .merge(
                                                    TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                    ),
                                                  ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            )
                    ],
                  ),
      ),
    );
  }
}

class GraphSubjectWiseResultItem extends StatefulWidget {
  final SubjectWiseReportListValue datamodel;
  final Color chipColor;
  final Color containerColor;
  final Color gradeColor;
  final Color textColor;
  final Color obtainedColor;
  final Color pieColor;
  const GraphSubjectWiseResultItem(
      {super.key,
      required this.datamodel,
      required this.chipColor,
      required this.containerColor,
      required this.gradeColor,
      required this.textColor,
      required this.obtainedColor,
      required this.pieColor});

  @override
  State<GraphSubjectWiseResultItem> createState() =>
      _GraphSubjectWiseResultItemState();
}

class _GraphSubjectWiseResultItemState
    extends State<GraphSubjectWiseResultItem> {
  List<PieDataModel> pie = [];

  @override
  void initState() {
    // TODO: implement initState

    pie.add(PieDataModel(
        marks: widget.datamodel.estmpsMaxMarks!.toInt(),
        name: "Max Marks",
        color: widget.pieColor));
    pie.add(PieDataModel(
        marks: widget.datamodel.estmpsObtainedMarks!.toInt(),
        name: "Mark Obtained",
        color: widget.obtainedColor));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.containerColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 6.0),
                  backgroundColor: widget.chipColor,
                  label: Text(
                    widget.datamodel.emeExamName!,
                    style: TextStyle(color: widget.textColor),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Text(
                    //   "Grade",
                    //   style: Theme.of(context).textTheme.labelMedium,
                    // ),
                    // const SizedBox(
                    //   height: 6.0,
                    // ),
                    Text(
                      "${widget.datamodel.estmpsObtainedGrade}  ",
                      style: Theme.of(context).textTheme.titleMedium!.merge(
                            TextStyle(fontSize: 20.0, color: widget.gradeColor),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: Get.width * 0.4,
                height: Get.width * 0.4,
                child: Transform.translate(
                  offset: const Offset(-5, 0),
                  child: SfCircularChart(
                    series: <CircularSeries>[
                      PieSeries<PieDataModel, String>(
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          dataSource: pie,
                          pointColorMapper: ((datum, index) => datum.color),
                          xValueMapper: ((datum, index) => datum.name),
                          yValueMapper: ((datum, index) => datum.marks)),
                      PieSeries<PieDataModel, String>(
                          dataSource: pie,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          pointColorMapper: ((datum, index) => datum.color),
                          xValueMapper: ((datum, index) => datum.name),
                          yValueMapper: ((datum, index) => datum.marks)),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Maximum Marks",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .merge(const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.2,
                                          color: Color.fromRGBO(
                                              124, 124, 124, 1))),
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                Text(
                                  "${widget.datamodel.estmpsMaxMarks!.toInt()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .merge(const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Class Highest",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .merge(const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.2,
                                          color: Color.fromRGBO(
                                              124, 124, 124, 1))),
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                Text(
                                  "${widget.datamodel.estmpsClassHighest!.toInt()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .merge(const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Section Highest",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .merge(const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.2,
                                          color: Color.fromRGBO(
                                              124, 124, 124, 1))),
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                Text(
                                  "${widget.datamodel.estmpsSectionHighest!.toInt()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .merge(const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Minimum Marks",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .merge(const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.2,
                                          color: Color.fromRGBO(
                                              124, 124, 124, 1))),
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                Text(
                                  "${widget.datamodel.eycesMinMarks!.toInt()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .merge(const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Class avg",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .merge(const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.2,
                                          color: Color.fromRGBO(
                                              124, 124, 124, 1))),
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                Text(
                                  "${widget.datamodel.estmpsClassAverage!.toInt()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .merge(const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Section Avg",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .merge(const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.2,
                                          color: Color.fromRGBO(
                                              124, 124, 124, 1))),
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                Text(
                                  "${widget.datamodel.estmpsSectionAverage!.toInt()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .merge(const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Expanded(
              //   child: Wrap(
              //     runSpacing: 12.0,
              //     spacing: 12.0,
              //     alignment: WrapAlignment.center,
              //     children: [
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             "Maximum Marks",
              //             style: Theme.of(context).textTheme.labelSmall!.merge(
              //                 const TextStyle(
              //                     fontSize: 13,
              //                     fontWeight: FontWeight.w400,
              //                     letterSpacing: 0.2,
              //                     color: Color.fromRGBO(124, 124, 124, 1))),
              //           ),
              //           const SizedBox(
              //             height: 6.0,
              //           ),
              //           Text(
              //             "${widget.datamodel.estmpsMaxMarks!.toInt()}",
              //             style: Theme.of(context).textTheme.labelMedium!.merge(
              //                 const TextStyle(
              //                     fontWeight: FontWeight.w700,
              //                     color: Colors.black)),
              //           ),
              //         ],
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             "Minimum",
              //             style: Theme.of(context).textTheme.labelSmall!.merge(
              //                 const TextStyle(
              //                     fontSize: 13,
              //                     fontWeight: FontWeight.w400,
              //                     letterSpacing: 0.2,
              //                     color: Color.fromRGBO(124, 124, 124, 1))),
              //           ),
              //           const SizedBox(
              //             height: 6.0,
              //           ),
              //           Text(
              //             "${widget.datamodel.eycesMinMarks!.toInt()}",
              //             style: Theme.of(context).textTheme.labelMedium!.merge(
              //                 const TextStyle(
              //                     fontWeight: FontWeight.w700,
              //                     color: Colors.black)),
              //           ),
              //         ],
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             "Class Highest",
              //             style: Theme.of(context).textTheme.labelSmall!.merge(
              //                 const TextStyle(
              //                     fontSize: 13,
              //                     fontWeight: FontWeight.w400,
              //                     letterSpacing: 0.2,
              //                     color: Color.fromRGBO(124, 124, 124, 1))),
              //           ),
              //           const SizedBox(
              //             height: 6.0,
              //           ),
              //           Text(
              //             "${widget.datamodel.estmpsClassHighest!.toInt()}",
              //             style: Theme.of(context).textTheme.labelMedium!.merge(
              //                 const TextStyle(
              //                     fontWeight: FontWeight.w700,
              //                     color: Colors.black)),
              //           ),
              //         ],
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             "Class avg",
              //             style: Theme.of(context).textTheme.labelSmall!.merge(
              //                 const TextStyle(
              //                     fontSize: 13,
              //                     fontWeight: FontWeight.w400,
              //                     letterSpacing: 0.2,
              //                     color: Color.fromRGBO(124, 124, 124, 1))),
              //           ),
              //           const SizedBox(
              //             height: 6.0,
              //           ),
              //           Text(
              //             "${widget.datamodel.estmpsClassAverage!.toInt()}",
              //             style: Theme.of(context).textTheme.labelMedium!.merge(
              //                 const TextStyle(
              //                     fontWeight: FontWeight.w700,
              //                     color: Colors.black)),
              //           ),
              //         ],
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             "Section Highest",
              //             style: Theme.of(context).textTheme.labelSmall!.merge(
              //                 const TextStyle(
              //                     fontSize: 13,
              //                     fontWeight: FontWeight.w400,
              //                     letterSpacing: 0.2,
              //                     color: Color.fromRGBO(124, 124, 124, 1))),
              //           ),
              //           const SizedBox(
              //             height: 6.0,
              //           ),
              //           Text(
              //             "${widget.datamodel.estmpsSectionHighest!.toInt()}",
              //             style: Theme.of(context).textTheme.labelMedium!.merge(
              //                 const TextStyle(
              //                     fontWeight: FontWeight.w700,
              //                     color: Colors.black)),
              //           ),
              //         ],
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             "Section Avg",
              //             style: Theme.of(context).textTheme.labelSmall!.merge(
              //                 const TextStyle(
              //                     fontSize: 13,
              //                     fontWeight: FontWeight.w400,
              //                     letterSpacing: 0.2,
              //                     color: Color.fromRGBO(124, 124, 124, 1))),
              //           ),
              //           const SizedBox(
              //             height: 6.0,
              //           ),
              //           Text(
              //             "${widget.datamodel.estmpsSectionAverage!.toInt()}",
              //             style: Theme.of(context).textTheme.labelMedium!.merge(
              //                 const TextStyle(
              //                     fontWeight: FontWeight.w700,
              //                     color: Colors.black)),
              //           ),
              //         ],
              //       ),
              //       // Column(
              //       //   crossAxisAlignment: CrossAxisAlignment.start,
              //       //   children: [
              //       //     Text(
              //       //       "Class avg",
              //       //       style: Theme.of(context)
              //       //           .textTheme
              //       //           .labelSmall!
              //       //           .merge(const TextStyle(
              //       //               fontSize: 13,
              //       //               fontWeight: FontWeight.w400,
              //       //               letterSpacing: 0.2,
              //       //               color: Color.fromRGBO(124, 124, 124, 1))),
              //       //     ),
              //       //     const SizedBox(
              //       //       height: 6.0,
              //       //     ),
              //       //     Text(
              //       //       "${widget.datamodel.estmpsClassAverage!.toInt()}",
              //       //       style: Theme.of(context)
              //       //           .textTheme
              //       //           .labelMedium!
              //       //           .merge(const TextStyle(
              //       //               fontWeight: FontWeight.w700,
              //       //               color: Colors.black)),
              //       //     ),
              //       //   ],
              //       // ),
              //     ],
              //   ),
              // ),
            ],
          ),
          const SizedBox(
            height: 12.0,
          ),
        ],
      ),
    );
  }
}
