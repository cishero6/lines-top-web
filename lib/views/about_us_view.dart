import 'package:flutter/material.dart';
import 'package:lines_top_web_project/bodies/about_us_body/about_us_body.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../widgets/custom_app_bar/custom_app_bar.dart';
import '../widgets/parallax_widget/parallax_image.dart';
import 'package:provider/provider.dart';
import '../providers/data_provider.dart';

class AboutUsView extends StatelessWidget {
  AboutUsView({super.key});
  final GlobalKey scrollKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var aboutUs = Provider.of<DataProvider>(context, listen: false).aboutUs;
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 80),
          child: CustomAppBar(),
        ),
        body: Stack(
          children: [
            ParallaxImage(
                aboutUs[sizingInformation.isMobile
                    ? 'bg_image_mobile'
                    : 'bg_image_desktop'],
                scrollKey),
            CustomScrollView(
              slivers: [
                SliverList(
                    delegate: SliverChildListDelegate(
                        [AboutUsBody(sizingInformation,key: scrollKey,)])),
              ],
            ),
          ],
        ),
      );
    });
  }
}
