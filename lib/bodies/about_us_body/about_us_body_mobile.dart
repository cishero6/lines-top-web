import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lines_top_web_project/providers/data_provider.dart';
import 'package:lines_top_web_project/widgets/carousel/carousel_about_us.dart';
import 'package:provider/provider.dart';
class AboutUsBodyMobile extends StatefulWidget {
  const AboutUsBodyMobile({super.key});

  @override
  State<AboutUsBodyMobile> createState() => _AboutUsBodyMobileState();
}

class _AboutUsBodyMobileState extends State<AboutUsBodyMobile> with TickerProviderStateMixin{
  late AnimationController _mainTextAnimationController;
  late Animation<double> _mainTextOpacityAnimation;


  _runInitialAnimations()async{
    await Future.delayed(Duration(milliseconds: 700));
    _mainTextAnimationController.forward();
  }
  @override
  void initState() {
    _mainTextAnimationController = AnimationController(vsync: this,duration: const Duration(milliseconds: 400),);
    _mainTextOpacityAnimation = Tween(begin: 0.0,end: 1.0).animate(_mainTextAnimationController);
        WidgetsBinding.instance
        .addPostFrameCallback((_) => _runInitialAnimations());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var aboutUs = Provider.of<DataProvider>(context,listen: false).aboutUs;
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
       const SizedBox(height: 100,),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'О нас',
              style: GoogleFonts.adventPro(
                  textStyle: const TextStyle(fontSize: 24)),
            )),
        FadeTransition(opacity: _mainTextOpacityAnimation,child: Container(
          constraints: const BoxConstraints(minWidth: 300,maxWidth: 1000),
          padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 30),
          child: Text(aboutUs['long_desc'],maxLines: 10,textAlign: TextAlign.center,),
        ),),
        const Divider(thickness: 5,),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(children: [
            Flexible(flex: 1,child: Image(image: aboutUs['stories'][0]['image'],fit:BoxFit.contain,width: 200,height: 400,)),const SizedBox(width: 30,), Flexible(flex: 3,child: Text(aboutUs['stories'][0]['story'],maxLines: 40,)),
          ],),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(children: [
             Flexible(flex: 3,child: Text(aboutUs['stories'][1]['story'],maxLines: 40,)),const SizedBox(width: 30,),Flexible(flex: 1,child: Image(image: aboutUs['stories'][1]['image'],fit:BoxFit.contain,width: 200,height: 400,)),
          ],),
        ),
        const Divider(thickness: 5,),
        CarouselAboutUs(Provider.of<DataProvider>(context,listen: false).diploms),
        const Divider(thickness: 5,),
      ]),
    );
  }
}
