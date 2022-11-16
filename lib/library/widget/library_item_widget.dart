import 'package:flutter/material.dart';
import 'package:m_skool_flutter/library/widget/library_dt_status.dart';
import 'package:m_skool_flutter/library/widget/library_sub_item.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class LibraryItemWidget extends StatelessWidget {
  const LibraryItemWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(101, 255, 232, 231),
            borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Too Good To Be True",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 8.0,
              ),
              const LibrarySubItem(title: "Accession No", value: "2011202"),
              const SizedBox(
                height: 12.0,
              ),
              const LibrarySubItem(title: "Status", value: "Issued"),
              const SizedBox(
                height: 12.0,
              ),
              const LibrarySubItem(title: "Total Fine", value: "₹ 100"),
              const SizedBox(
                height: 12.0,
              ),
              const LibrarySubItem(
                  title: "Total Fine Collected", value: "₹ 110"),
              const SizedBox(
                height: 12.0,
              ),
              Center(
                child: Row(
                  // alignment: WrapAlignment.center,
                  // runSpacing: 16.0,
                  // spacing: 16.0,
                  children: [
                    Expanded(
                      child: LibraryStatusDate(
                        title: "Issued Date",
                        date: "10 Oct 2022",
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    const Expanded(
                      child: LibraryStatusDate(
                        title: "Due Date",
                        date: "12 Oct 2022",
                        color: Color(0xFFFF968F),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    const Expanded(
                      child: LibraryStatusDate(
                        title: "Return Date",
                        date: "11 Oct 2022",
                        color: Color(0xFFB9F0B8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
