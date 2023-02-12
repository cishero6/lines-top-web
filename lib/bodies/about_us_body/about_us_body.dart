import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lines_top_web_project/providers/data_provider.dart';
import 'package:lines_top_web_project/widgets/about_us/about_us_widget.dart';
import 'package:lines_top_web_project/widgets/carousel/carousel_about_us.dart';
import 'package:lines_top_web_project/widgets/parallax_widget/parallax_image.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import './stories.dart';
import '../../helpers/widget_size.dart';
import '../../providers/page_size_provider.dart';

class AboutUsBody extends StatefulWidget {
  SizingInformation sizingInformation;
  AboutUsBody(this.sizingInformation,{super.key});

  @override
  State<AboutUsBody> createState() => _AboutUsBodyState();
}

class _AboutUsBodyState extends State<AboutUsBody>
    with TickerProviderStateMixin {
  late AnimationController _mainTextAnimationController;
  late Animation<double> _mainTextOpacityAnimation;
  late AnimationController _titleAnimationController;
  late Animation<double> _titleOpacityAnimation;
  late Animation<Offset> _titleOffsetAnimation;
  late Animation<double> _storiesOpacityAnimation;
  late Animation<Offset> _storiesOffsetAnimation;
  late AnimationController _storiesAnimationController;

  _runInitialAnimations() async {
    await Future.delayed(const Duration(milliseconds: 700));
    _titleAnimationController.forward();
    await Future.delayed(const Duration(milliseconds: 500));
    _mainTextAnimationController.forward();
    await Future.delayed(const Duration(milliseconds: 700));
    _storiesAnimationController.forward();
  }

  @override
  void initState() {
    _mainTextAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _mainTextOpacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _mainTextAnimationController, curve: Curves.easeIn));
    _titleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _titleOffsetAnimation =
        Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(
            CurvedAnimation(
                parent: _titleAnimationController,
                curve: Curves.fastLinearToSlowEaseIn));
    _titleOpacityAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_titleAnimationController);
    _storiesAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _storiesOpacityAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_storiesAnimationController);
    _storiesOffsetAnimation =
        Tween(begin: const Offset(0, -1), end: const Offset(0, 0)).animate(
            CurvedAnimation(
                parent: _storiesAnimationController,
                curve: Curves.fastLinearToSlowEaseIn));
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _runInitialAnimations());
    super.initState();
  }
  void _setBackgroundHeight(Size size)async{
    await Future.delayed(const Duration(milliseconds: 100));
    Provider.of<PageSizeProvider>(context,listen: false).setHeight(size.height);
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<PageSizeProvider>(context,listen: false).setParallaxContext(context);
    var aboutUs = Provider.of<DataProvider>(context, listen: false).aboutUs;
    return 
        WidgetSize(
          onChange: (Size value)=>_setBackgroundHeight(value),
          child: Column(
          children:[
                const SizedBox(
                  height: 100,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: FadeTransition(
                        opacity: _titleOpacityAnimation,
                        child: SlideTransition(
                          position: _titleOffsetAnimation,
                          child: Text(
                            'Обо мне',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 32),
                          ),
                        ),
                      )),
                ),
                FadeTransition(
                  opacity: _mainTextOpacityAnimation,
                  child: Container(
                    constraints:
                        const BoxConstraints(minWidth: 300, maxWidth: 1000),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 80, vertical: 30),
                    child: Text(
                      aboutUs['long_desc'],
                      maxLines: 10,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SlideTransition(
                      position: _storiesOffsetAnimation,
                      child: FadeTransition(
                          opacity: _storiesOpacityAnimation,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            child: Text(
                              'Автор проекта',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 24),
                            ),
                          ))),
                ),
                FadeTransition(
                    opacity: _storiesOpacityAnimation,
                    child: const Divider(
                      thickness: 5,
                    )),
                FadeTransition(
                    opacity: _storiesOpacityAnimation,
                    child: Stories(widget.sizingInformation)),
                FadeTransition(
                    opacity: _storiesOpacityAnimation,
                    child: const Divider(
                      thickness: 5,
                      height: 5,
                    )),
                Align(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Text(
                      'Мои дипломы',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 24),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CarouselAboutUs(
                      Provider.of<DataProvider>(context, listen: false).diploms),
                ),
                AboutUsWidget(
                  widget.sizingInformation,
                  withButton: false,
                ),
              ],
              ),
        );
  }
}
