import 'package:flutter/material.dart';
import 'package:lines_top_web_project/providers/carousel_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PageNavigationManagerMobile extends StatefulWidget {
  final void Function(int pageIndex,bool isMobile) goToPage;
  final int size;
  SizingInformation sizingInformation;
  PageNavigationManagerMobile(this.goToPage, this.size,this.sizingInformation);

  @override
  State<PageNavigationManagerMobile> createState() =>
      _PageNavigationManagerMobileState();
}

class _PageNavigationManagerMobileState
    extends State<PageNavigationManagerMobile> {
  int _currentIndex = 0;

  @override
  void initState() {
    _currentIndex =
        Provider.of<CarouselProvider>(context, listen: false).currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final list = List<int>.generate(widget.size, (i) => i);
    return Container(
      decoration: const BoxDecoration(
        //borderRadius: BorderRadius.circular(23),
        color: Colors.black45,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: list
            .map((e) => AnimatedContainer(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      color: e == _currentIndex ? Colors.white : Colors.white24,
                      shape: BoxShape.circle),
                  width: e == _currentIndex ? 18 : 16,
                  height: e == _currentIndex ? 18 : 16,
                  duration: const Duration(milliseconds: 100),
                  child: TextButton(
                    child: const Text(''),
                    onPressed: () {
                      _currentIndex = e;
                      widget.goToPage(e,widget.sizingInformation.isMobile);
                      setState(() {});
                    },
                  ),
                ))
            .toList(),
      ),
    );
  }
}
