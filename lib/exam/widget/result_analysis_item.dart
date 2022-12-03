import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

import '../model/markoverview_model.dart';

class ResultAnalysisItem extends StatelessWidget {
  final ExamWiseReportListValue datamodel;

  final Color chipColor;
  final Color containerColor;
  final Color gradeColor;
  const ResultAnalysisItem({
    super.key,
    required this.datamodel,
    required this.chipColor,
    required this.containerColor,
    required this.gradeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(
              12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Chip(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 6.0),
                  backgroundColor: chipColor,
                  label: Text(datamodel.ismsSubjectName!),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mark Obtained",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .merge(const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(124, 124, 124, 1))),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            "     ${datamodel.estmpsObtainedMarks!.toInt()}",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .merge(const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Grade",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            "${datamodel.estmpsObtainedGrade}  ",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .merge(
                                  TextStyle(fontSize: 20.0, color: gradeColor),
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1.5,
            height: 1.5,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: MarksAnalysisItem(
                      marks: datamodel.estmpsClassHighest.toString(),
                      title: "Class Highest",
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: MarksAnalysisItem(
                      marks: datamodel.estmpsSectionHighest.toString(),
                      title: "Section Highest",
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: MarksAnalysisItem(
                      marks: datamodel.estmpsSectionAverage.toString(),
                      title: "Section Avg",
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: MarksAnalysisItem(
                      marks: datamodel.estmpsClassAverage.toString(),
                      title: "Class Avg",
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}

class MarksAnalysisItem extends StatelessWidget {
  final String marks;
  final String title;
  const MarksAnalysisItem({
    Key? key,
    required this.marks,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        marks,
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .merge(const TextStyle(color: Colors.black)),
      ),
      const SizedBox(
        height: 6.0,
      ),
      Text(
        title,
        //maxLines: 2,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleSmall!.merge(
              const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(124, 124, 124, 1),
                letterSpacing: 0.2,
              ),
            ),
      )
    ]);
  }
}
