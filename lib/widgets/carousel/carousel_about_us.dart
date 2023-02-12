import 'package:flutter/material.dart';

class CarouselAboutUs extends StatefulWidget {

  final List<AssetImage> images;
  CarouselAboutUs(this.images);
  @override
  State<CarouselAboutUs> createState() => _CarouselAboutUsState();
}

class _CarouselAboutUsState extends State<CarouselAboutUs>
    with TickerProviderStateMixin {
  var _currentIndex = 0;
  late AssetImage _currentMainImage;
  late AssetImage _rightImage;
  late AssetImage _leftImage;
  bool _isScrolling = false;
  

  late AnimationController _rightAnimationController;
  late AnimationController _leftAnimationController;
  late Animation<double> _rightSizeAnimation;
  late Animation<double> _rightOpacityAnimation;
  late Animation<Offset> _rightOffsetAnimation;
  late Animation<double> _leftSizeAnimation;
  late Animation<double> _leftOpacityAnimation;
  late Animation<Offset> _leftOffsetAnimation;

  void _runInitialAnimations(BuildContext context) {}

  void _setAnimations(bool isLeftScrool){
    _rightAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));

    _leftAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _leftOffsetAnimation = Tween(
            begin: Offset(isLeftScrool ? -1.5 : 0, 0),
            end: Offset(isLeftScrool ? 0 : -1.5, 0))
        .animate(CurvedAnimation(
            parent: _leftAnimationController, curve: Curves.fastLinearToSlowEaseIn));
    _rightOffsetAnimation = Tween(
            begin: Offset(isLeftScrool ? 0 : 1.5, 0),
            end: Offset(isLeftScrool ? 1.5 : 0, 0))
        .animate(CurvedAnimation(
            parent: _leftAnimationController, curve: Curves.fastLinearToSlowEaseIn));
    _leftOpacityAnimation =
        Tween(begin: isLeftScrool ? 0.0 : 1.0, end: isLeftScrool ? 1.0 : 0.0)
            .animate(CurvedAnimation(
                parent: _leftAnimationController, curve: Curves.fastLinearToSlowEaseIn));
    _rightOpacityAnimation =
        Tween(begin: isLeftScrool ? 1.0 : 0.0, end: isLeftScrool ? 0.0 : 1.0)
            .animate(CurvedAnimation(
                parent: _leftAnimationController, curve: Curves.fastLinearToSlowEaseIn));
    _leftSizeAnimation =
        Tween(begin: isLeftScrool ? 0.6 : 1.0, end: isLeftScrool ? 1.0 : 0.6)
            .animate(CurvedAnimation(
                parent: _leftAnimationController, curve: Curves.fastLinearToSlowEaseIn));
    _rightSizeAnimation =
        Tween(begin: isLeftScrool ? 1.0 : 0.6, end: isLeftScrool ? 0.6 : 1.0)
            .animate(CurvedAnimation(
                parent: _leftAnimationController, curve: Curves.fastLinearToSlowEaseIn));
  }

  void _scroll(bool isLeftScroll) async {
    _rightImage = widget.images[(isLeftScroll ? _currentIndex: _currentIndex+1)% widget.images.length];
    _leftImage = widget.images[(isLeftScroll ? _currentIndex - 1 : _currentIndex)% widget.images.length]; //setting images
    _setAnimations(isLeftScroll);
    setState(() {
      _isScrolling = true;
    });
    _rightAnimationController.forward();
    await _leftAnimationController.forward();
    _currentIndex = (isLeftScroll ? _currentIndex - 1 : _currentIndex + 1) % widget.images.length;
    _currentMainImage = widget.images[_currentIndex];
    _isScrolling = false;
    setState(() {});
  }

  @override
  void initState() {
    _leftImage = widget.images[_currentIndex];
    _rightImage = widget.images[(_currentIndex + 1)% widget.images.length]; 
    _currentMainImage = widget.images[0];
    
    _setAnimations(true);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _runInitialAnimations(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 300,
          child: GestureDetector(
            onHorizontalDragUpdate: _isScrolling ? null : (details) =>details.delta.dx.abs()>1 ? _scroll(details.delta.dx >0) : null,
            child: Stack(
              children: [
                Align(alignment: Alignment.center,child: Opacity(opacity: _isScrolling ? 0:1,child: Image(image: _currentMainImage),)),
                Align(alignment: Alignment.center,child: Opacity(opacity: _isScrolling ? 1:0,child: SlideTransition(position: _leftOffsetAnimation,child: FadeTransition(opacity: _leftOpacityAnimation,child: ScaleTransition(scale: _leftSizeAnimation,child: Image(image: _leftImage),),),)),),
                Align(alignment: Alignment.center,child: Opacity(opacity: _isScrolling ? 1:0,child: SlideTransition(position: _rightOffsetAnimation,child: FadeTransition(opacity: _rightOpacityAnimation,child: ScaleTransition(scale: _rightSizeAnimation,child: Image(image: _rightImage),),),)),),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed:_isScrolling ? null : ()=>  _scroll(true), icon: Icon(Icons.arrow_left),splashRadius: 20,),
            const SizedBox(width: 30,),
            IconButton(onPressed:_isScrolling ? null :()=> _scroll(false), icon: Icon(Icons.arrow_right),splashRadius: 20),
          ],
        ),
      ],
    );
  }
}
