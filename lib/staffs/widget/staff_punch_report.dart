import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/staffs/model/dashboard_punch_report_model.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class StaffPunchReport extends StatelessWidget {
  final DashboardPunchReportModelValues values;
  const StaffPunchReport({super.key, required this.values});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.width * 0.5 - 28,
      child: CustomContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              visualDensity:
                  const VisualDensity(vertical: VisualDensity.minimumDensity),
              title: Text(
                "Punch Report",
                style: Theme.of(context).textTheme.titleSmall!.merge(
                      const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
              ),
              trailing: Text(
                  getFormatedDate(DateTime.parse(values.punchdate!))
                      .substring(
                          0,
                          getFormatedDate(DateTime.parse(values.punchdate!))
                                  .length -
                              2)
                      .trim(),
                  style: Theme.of(context).textTheme.titleSmall),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomContainer(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${int.parse(values.punchOUTtime!.split(":").first) - int.parse(values.punchINtime!.split(":").first)} H",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleSmall!.merge(
                              const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18.0)),
                        ),
                      ),
                    ),
                  ),
                  const Text(" : "),
                  Expanded(
                    child: CustomContainer(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${int.parse(values.punchOUTtime!.split(":").last) - int.parse(values.punchINtime!.split(":").last)} min",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleSmall!.merge(
                              const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18.0)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: const Color.fromRGBO(222, 205, 233, 0.6),
              ),
              child: Text(
                  "Late in : ${values.lateby!.split(":").first}H ${values.lateby!.split(":").last} min"),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12.0),
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: const Color.fromRGBO(234, 222, 185, 0.6)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Early Out : ",
                  ),
                  SizedBox(
                      width: Get.width * 0.12,
                      height: 30,
                      child: TextField(
                        readOnly: true,
                        controller: TextEditingController(
                            text: values.earlyby.toString()),
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
          ],
        ),
      ),
    );
  }
}
