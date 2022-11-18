import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/library/api/library_data_api.dart';
import 'package:m_skool_flutter/library/model/library_data_model.dart';
import 'package:m_skool_flutter/library/widget/library_item_widget.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class LibraryHome extends StatelessWidget {
  final int asmayId;
  final int miId;
  final int asmtId;
  final String base;
  const LibraryHome(
      {super.key,
      required this.asmayId,
      required this.miId,
      required this.asmtId,
      required this.base});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Library".tr).getAppBar(),
      body: FutureBuilder<List<LibraryDetailsValues>>(
          future: LibraryDataApi.instance
              .getLibraryData(miId, asmayId, asmtId, base),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              int colorIndex = -1;
              return ListView.separated(
                  padding: const EdgeInsets.all(16.0),
                  itemBuilder: (_, index) {
                    colorIndex += 1;
                    if (index % 6 == 0) {
                      colorIndex = 0;
                    }
                    logger.d(colors.elementAt(colorIndex));
                    return LibraryItemWidget(
                      color: colors.elementAt(colorIndex),
                      bookDetails: snapshot.data!.elementAt(index),
                    );
                  },
                  separatorBuilder: (_, index) {
                    return const SizedBox(
                      height: 16.0,
                    );
                  },
                  itemCount: snapshot.data!.length);
            }

            if (snapshot.hasError) {
              return ErrWidget(err: snapshot.error as Map<String, dynamic>);
            }

            return const CustomPgrWidget(
              title: "Getting your library ready",
              desc:
                  "We are getting your library details, please wait while we fetch it for you.",
            );
          }),
    );
  }
}

class CustomPgrWidget extends StatelessWidget {
  final String title;
  final String desc;
  const CustomPgrWidget({
    Key? key,
    required this.title,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(
              height: 24.0,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium!.merge(
                    const TextStyle(fontSize: 24.0),
                  ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              desc,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class LibraryStatusDate extends StatelessWidget {
  final Color color;
  final String title;
  final String date;
  const LibraryStatusDate({
    Key? key,
    required this.color,
    required this.title,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: (Get.size.width * 0.5) - 48,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: color,
      ),
      child: Column(
        children: [
          Text(
            title,
            style:
                Theme.of(context).textTheme.labelMedium!.merge(const TextStyle(
                      fontSize: 14.0,
                    )),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            date,
            style: Theme.of(context).textTheme.titleSmall!.merge(
                  const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
          )
        ],
      ),
    );
  }
}
