import 'package:flutter/material.dart';

class GoalItem extends StatefulWidget {
  final AssetImage image;
  final String text;
  final double? height;
  final double? width;
  final Duration? waitTimer;
  final bool isMobile;

  GoalItem(this.image,this.text,{required this.isMobile, this.height,this.width,this.waitTimer});


  @override
  State<GoalItem> createState() => _GoalItemState();
}

class _GoalItemState extends State<GoalItem> with TickerProviderStateMixin{
  late AnimationController _imageAnimationController;
  late AnimationController _textAnimationController;
  late Animation<double> _textOpacityAnimation;
  late Animation<Offset> _textOffsetAnimation;
  late Animation<double> _imageOpacityAnimation;

  @override
  void initState() {
    _imageAnimationController = AnimationController(vsync: this,duration: const Duration(milliseconds: 500));
    _textAnimationController = AnimationController(vsync: this,duration: const Duration(milliseconds: 500));
    _textOpacityAnimation = Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(parent: _textAnimationController, curve: Curves.linearToEaseOut));
    _imageOpacityAnimation = Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(parent: _imageAnimationController, curve: Curves.linearToEaseOut));
    _textOffsetAnimation = Tween(begin: widget.isMobile ? const Offset(0,1): const Offset(2,0),end: const Offset(0,0)).animate(CurvedAnimation(parent: _textAnimationController, curve: Curves.linearToEaseOut));

    super.initState();
    Future.delayed(widget.waitTimer == null ? const Duration(milliseconds: 1600) : widget.waitTimer!).whenComplete(() {
    _imageAnimationController.forward();
    _textAnimationController.forward();
    });

  }
@override
  void dispose() {
    _imageAnimationController.dispose();
    _textAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2.5,vertical: 5),
      //color: Colors.amber,
     //color: Colors.amber,
      child: widget.isMobile ? Column(children: [
        FadeTransition(opacity: _imageOpacityAnimation,child: Container(height:widget.height,width: widget.width,decoration: BoxDecoration(image: DecorationImage(image: widget.image,fit: BoxFit.contain)),),),
        const SizedBox(height: 2.5,),
        SlideTransition(position: _textOffsetAnimation,child: FadeTransition(opacity: _textOpacityAnimation,child: Text(widget.text,style: Theme.of(context).textTheme.bodyMedium,overflow: TextOverflow.visible,maxLines: 20,textAlign: TextAlign.center,),),)
      ],) : Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        FadeTransition(opacity: _imageOpacityAnimation,child: Container(height:widget.height,width: widget.width,decoration: BoxDecoration(image: DecorationImage(image: widget.image,fit: BoxFit.contain)),)),
        const SizedBox(width: 60,),
        Expanded(child: SlideTransition(position: _textOffsetAnimation,child: FadeTransition(opacity: _textOpacityAnimation,child: Text(widget.text,style: Theme.of(context).textTheme.bodyMedium,overflow: TextOverflow.visible,maxLines: 20,),),)),
      ],),
    );
  }
}