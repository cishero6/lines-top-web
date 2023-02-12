import 'package:flutter/material.dart';
import 'package:lines_top_web_project/providers/page_size_provider.dart';
import 'package:lines_top_web_project/widgets/about_us/about_us_widget.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../helpers/widget_size.dart';
import '../../widgets/parallax_widget/parallax_image.dart';
import 'unique_addition.dart';

class DetailsColumn extends StatefulWidget {
  final Map<String, dynamic> bodyData;
  final ScrollController scrollController;

  DetailsColumn(this.bodyData, this.scrollController);
  @override
  State<DetailsColumn> createState() => _DetailsColumnState();
}

class _DetailsColumnState extends State<DetailsColumn>
    with TickerProviderStateMixin {
  double height = 2;
  late AnimationController animationController;
  late Animation<Offset> offsetAnimation;
  late Animation<double> opacityAnimation;
  late Animation<double> uniqueAdditionOpacityAnimation;
  late AnimationController uniqueAdditionAnimationController;

  @override
  void initState() {
    uniqueAdditionAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    uniqueAdditionOpacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: uniqueAdditionAnimationController,
            curve: Curves.fastLinearToSlowEaseIn));
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    offsetAnimation = Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
        .animate(CurvedAnimation(
            parent: animationController, curve: Curves.fastLinearToSlowEaseIn));
    opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeIn));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _runInitialAnimations(context);
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _setBackgroundHeight(Size size) async {
    Provider.of<PageSizeProvider>(context, listen: false)
        .setHeight(size.height);
  }

  void _runInitialAnimations(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 700));
    animationController.forward();
    await Future.delayed(const Duration(milliseconds: 600));
    uniqueAdditionAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      return Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 900),
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: WidgetSize(
            onChange: (Size value) => _setBackgroundHeight(value),
            child: Column(children: [
              const SizedBox(
                height: 100,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SlideTransition(
                  position: offsetAnimation,
                  child: FadeTransition(
                    opacity: opacityAnimation,
                    child: Text(
                      widget.bodyData['name'],
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 34),
                    ),
                  ),
                ),
              ),
              FadeTransition(
                opacity: opacityAnimation,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Text(
                    widget.bodyData['long_desc'],
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              FadeTransition(
                  opacity: uniqueAdditionOpacityAnimation,
                  child: UniqueAddition(widget.bodyData['name'],
                      widget.bodyData, sizingInformation, setState)),
              AboutUsWidget(sizingInformation),
            ]),
          ),
        ),
      );
    });
  }
}
