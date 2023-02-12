import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import './custom_app_bar_desktop.dart';
import './custom_app_bar_mobile.dart';
import '../../providers/data_provider.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  late List<Map<String,dynamic>> data;

  @override
  Widget build(BuildContext context) {
    data = Provider.of<DataProvider>(context).data;
    return ScreenTypeLayout(
      mobile: CustomAppBarMobile(data),
      desktop: CustomAppBarDesktop(data),
    );
  }
}