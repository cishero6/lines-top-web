import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../widgets/carousel/carousel.dart';
import '../../widgets/about_us/about_us_widget.dart';

class HomeBody extends StatelessWidget {
  final String aboutUs;
  HomeBody(this.aboutUs);
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (ctx, sizingInformation) => CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate(
            [
              Carousel(),
              const SizedBox(height: 20),
              AboutUsWidget(sizingInformation),
            ],
          )),
        ],
      ),
    );
  }
}
