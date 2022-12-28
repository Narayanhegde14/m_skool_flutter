import 'package:flutter/material.dart';
import 'package:m_skool_flutter/constants/constants.dart';

class BirthdayItem extends StatelessWidget {
  const BirthdayItem({
    Key? key,
    required this.color,
  }) : super(key: key);

  final int color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: noticeBackgroundColor.elementAt(color),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 36.0,
            backgroundColor: noticeColor.elementAt(color),
            backgroundImage: const NetworkImage(
                "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=388&q=80"),
          ),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ankush",
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                        const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                ),
                const SizedBox(
                  height: 6.0,
                ),
                const Text("BGHS1254"),
                const SizedBox(
                  height: 6.0,
                ),
                const Text("IX & A"),
              ],
            ),
          ),
          Text(
            "22-11-2011",
            style: Theme.of(context).textTheme.titleSmall!.merge(
                  const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
