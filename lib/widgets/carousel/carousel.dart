import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lines_top_web_project/providers/carousel_provider.dart';
import 'package:lines_top_web_project/providers/data_provider.dart';
import '../buttons/cool_button.dart';
import 'package:responsive_builder/responsive_builder.dart';
import './page_navigation_manager/page_navigation_manager_desktop.dart';
import './page_navigation_manager/page_navigation_manager_mobile.dart';
import 'package:provider/provider.dart';

class Carousel extends StatefulWidget {
  late List<Map<String, dynamic>> carouselData;

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> with TickerProviderStateMixin {
  late AssetImage _currentImage;
  String _currentTitle = '';
  String _currentDescription = '';
  int _currentIndex = 0;
 // bool _isMobile = false;
  late AnimationController _imageAnimationController;
  late Animation<double> _imageOpacityAnimation;
  late AnimationController _textAnimationController;
  late Animation<double> _textOpacityAnimation;
  late AnimationController _titleAnimationController;
  late Animation<Offset> _titleOffsetAnimation;
  bool _detailsOpened = false;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  @override
  void initState() {
    Provider.of<CarouselProvider>(context,listen: false).setIndex(1,shouldNotify: false);
    widget.carouselData = Provider.of<DataProvider>(context,listen: false).data;
    _currentIndex = Provider.of<CarouselProvider>(context,listen: false).currentIndex;
    _currentTitle = widget.carouselData[_currentIndex]['tagline'];
    _currentDescription = widget.carouselData[_currentIndex]['short_desc'];
    _currentImage = widget.carouselData[_currentIndex]['image_mobile'];
    _imageAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _textAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _titleAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _imageOpacityAnimation = Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: _imageAnimationController, curve: Curves.linear));
    _imageOpacityAnimation.addListener(() {
      setState(() {});
    });
    _textOpacityAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: _textAnimationController, curve: Curves.linear));
    _textOpacityAnimation.addListener(() {
      setState(() {});
    });
    _titleOffsetAnimation =
        Tween(begin: const Offset(0, 1.5), end: const Offset(0, 0)).animate(
            CurvedAnimation(
                parent: _titleAnimationController,
                curve: Curves.fastLinearToSlowEaseIn));
    _titleOffsetAnimation.addListener(() {
      setState(() {});
    });


    _titleAnimationController.forward();
    super.initState();
  }

@override
  void dispose() {
    _textAnimationController.dispose();
    _imageAnimationController.dispose();
    _titleAnimationController.dispose();
    super.dispose();
  }

  void _setNextPage(bool isMobile) async {
    _textAnimationController.forward();
    _imageAnimationController.forward();
    await _titleAnimationController.reverse();
    setState(() {
      _increaseIndex(isMobile);
    });
    if (!_detailsOpened) {
    await _imageAnimationController.reverse();
    _textAnimationController.reverse();
    _titleAnimationController.forward();
    }
  }

  void _setPreviousPage(bool isMobile) async {
    _textAnimationController.forward();
   _imageAnimationController.forward();
    await  _titleAnimationController.reverse();
    setState(() {
      _decreaseIndex(isMobile);
    });
    await _imageAnimationController.reverse();
    if (!_detailsOpened) {
    _textAnimationController.reverse();
    _titleAnimationController.forward();
    }
  }

  void _setPage(int index,bool isMobile) async {
    _textAnimationController.forward();
    _imageAnimationController.forward();
    await _titleAnimationController.reverse();
    setState(() {
      _setIndex(index,isMobile);
    });
    await _imageAnimationController.reverse();
   if (!_detailsOpened) {
    _textAnimationController.reverse();
    _titleAnimationController.forward();
   }
  }

  void _increaseIndex(bool isMobile) {
    _currentIndex = (_currentIndex + 1) % widget.carouselData.length;
    _currentTitle = widget.carouselData[_currentIndex]['tagline'];
    _currentDescription = widget.carouselData[_currentIndex]['short_desc'];
    _currentImage = widget.carouselData[_currentIndex][isMobile ? 'image_mobile' : 'image_desktop'];
  }

  void _decreaseIndex(bool isMobile) {
    _currentIndex = (_currentIndex - 1) % widget.carouselData.length;
    _currentTitle = widget.carouselData[_currentIndex]['tagline'];
    _currentDescription = widget.carouselData[_currentIndex]['short_desc'];
    _currentImage = widget.carouselData[_currentIndex][isMobile ? 'image_mobile' : 'image_desktop'];
  }

  void _setIndex(int index,bool isMobile) {
    _currentIndex = index % widget.carouselData.length;
    _currentTitle = widget.carouselData[_currentIndex]['tagline'];
    _currentDescription = widget.carouselData[_currentIndex]['short_desc'];
    _currentImage = widget.carouselData[_currentIndex][isMobile ? 'image_mobile' : 'image_desktop'];
  }



  void _clickDetails(int index){
    Navigator.of(context).pushReplacementNamed(widget.carouselData[index]['route_name'], arguments: widget.carouselData[index]);
  }


  double getMarginLeft(SizingInformation sizInfo){
    if (sizInfo.isMobile) return 45;
    if (sizInfo.isDesktop) return 180;
    return 90;
  }

  @override
  Widget build(BuildContext context) {
    widget.carouselData =
        Provider.of<DataProvider>(context, listen: false).data;
    var deviceSize = MediaQuery.of(context).size;
    var indexData = Provider.of<CarouselProvider>(context);
    return ResponsiveBuilder(
      builder: (ctx, sizingInformation) {
        indexData.addListener(() => _setPage(indexData.currentIndex,sizingInformation.isMobile),);
        _currentImage = widget.carouselData[_currentIndex][sizingInformation.isMobile ? 'image_mobile' : 'image_desktop'];
        return Container(
        alignment: sizingInformation.isMobile ? Alignment.center :Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 50),
        width: double.infinity,
        height: 500,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: _currentImage,
                fit: BoxFit.cover,
                opacity: _imageOpacityAnimation.value)),
        child: Column(
          crossAxisAlignment: sizingInformation.isMobile
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 100),
            SlideTransition(
                position: _titleOffsetAnimation,
                child: Opacity(
                    opacity: _textOpacityAnimation.value,
                    child: Text(_currentTitle,
                    textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 36,fontWeight: FontWeight.bold)))),
            // Opacity(opacity: _textOpacityAnimation.value,child: Text(_currentDescription,style: Theme.of(context).textTheme.bodyMedium)),
            CoolButton(
              'Подробнее',
              hoverColor: const Color.fromARGB(32, 0, 0, 0),
              primaryColor: Colors.black,
              onPressed: () {_clickDetails(_currentIndex);},
              textStyle:
                  Theme.of(context).textTheme.bodyMedium,
              opacity: _textOpacityAnimation.value,
            ),
            Align(
              alignment: sizingInformation.isMobile ? Alignment.center: Alignment.centerLeft,
              child: SizedBox(
                height: 80,
                width: 120,
                child: sizingInformation.isMobile
                    ? PageNavigationManagerMobile(
                        _setPage, widget.carouselData.length,sizingInformation)
                    : PageNavigationManagerDesktop(
                        _setNextPage, _setPreviousPage,sizingInformation),
              ),
            ),
          ],
        ),);
      }
    );
  }
}
