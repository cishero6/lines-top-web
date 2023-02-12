import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lines_top_web_project/bodies/details_body/details_column.dart';
import '../../helpers/widget_size.dart';
class DetailsBodyDesktop extends StatefulWidget {
  final Map<String, dynamic> bodyData;

  DetailsBodyDesktop(this.bodyData);

  @override
  State<DetailsBodyDesktop> createState() => _DetailsBodyDesktopState();
}

class _DetailsBodyDesktopState extends State<DetailsBodyDesktop> {
      late Size textSize = Size(5,5);
  @override
  Widget build(BuildContext context) {
    return WidgetSize(
      onChange:(Size size) {
        textSize = size;
        setState(() {});},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Image(
              height:textSize.height,
              image: const AssetImage('assets/images/bubbles1.jpeg'),
              fit: BoxFit.cover,
            ),
          )),
              DetailsColumn(widget.bodyData,ScrollController()),
          Expanded(
              child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Image(
              height: textSize.height,
                image: const AssetImage('assets/images/bubbles1.jpeg'),
                fit: BoxFit.cover),
          )),
        ],
      ),
    );
  }
}
