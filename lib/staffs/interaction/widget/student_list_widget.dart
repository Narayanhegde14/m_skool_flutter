import 'package:flutter/material.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/interaction/model/interactionStudentListModel.dart';

class StudentListWidget extends StatefulWidget {
  final GetStudentValue data;
  final Function(int) function;
  final Function(int) function1;
  const StudentListWidget({
    super.key,
    required this.data,
    required this.function,
    required this.function1,
  });

  @override
  State<StudentListWidget> createState() => _StudentListWidgetState();
}

class _StudentListWidgetState extends State<StudentListWidget> {
  bool check = false;
  @override
  void initState() {
    logger.d(widget.data.amstId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        checkboxShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        dense: true,
        activeColor: Theme.of(context).primaryColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        visualDensity: const VisualDensity(horizontal: -4.0),
        title: Text(
          widget.data.studentName!,
          style: Theme.of(context).textTheme.labelSmall!.merge(const TextStyle(
              fontWeight: FontWeight.w400, fontSize: 14.0, letterSpacing: 0.3)),
        ),
        value: check,
        onChanged: (value) {
          setState(() {
            check = value!;
          });
          if (value!) {
            widget.function(widget.data.amstId!);
            return;
          }
          widget.function1(widget.data.amstId!);
        },
      ),
    );
  }
}
