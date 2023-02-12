import 'package:flutter/material.dart';
import 'package:lines_top_web_project/bodies/details_body/details_body_desktop.dart';
import 'package:lines_top_web_project/bodies/details_body/details_column.dart';
import 'package:lines_top_web_project/providers/data_provider.dart';
import 'package:lines_top_web_project/providers/page_size_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/goal/goal_item.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DetailsBody extends StatefulWidget {
  final Map<String, dynamic> bodyData;
  final ScrollController scrollController;
  DetailsBody(this.bodyData,this.scrollController,{super.key});

  @override
  State<DetailsBody> createState() => _DetailsBodyState();
}

class _DetailsBodyState extends State<DetailsBody>{
  @override
  Widget build(BuildContext context) {
    Provider.of<PageSizeProvider>(context,listen: false).setParallaxContext(context);
    return DetailsColumn(widget.bodyData,widget.scrollController);
  }
}
