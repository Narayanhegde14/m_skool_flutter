import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class ViewImage extends StatelessWidget {
  final String image;
  const ViewImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "View File").getAppBar(),
      body: SizedBox(
          width: double.infinity,
          child: InteractiveViewer(child: Image.network(image))),
    );
  }
}
