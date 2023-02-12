import 'package:flutter/material.dart';
import 'package:lines_top_web_project/widgets/parallax_widget/parallax_image.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../bodies/details_body/details_body.dart';
import '../widgets/custom_app_bar/custom_app_bar.dart';

class DetailsView extends StatelessWidget {
  final Map<String, dynamic> detailedData;
  DetailsView(this.detailedData);
  late ScrollController scrollController;
  final GlobalKey scrollKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    scrollController = ScrollController();
    return ResponsiveBuilder(builder: (ctx, sizingInformation) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 80),
          child: CustomAppBar(),
        ),
        body: Stack(
          children: [
            ParallaxImage(
                detailedData[sizingInformation.isMobile
                    ? 'bg_image_mobile'
                    : 'bg_image_desktop'],
                scrollKey),
            CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      DetailsBody(detailedData, scrollController,
                          key: scrollKey),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
