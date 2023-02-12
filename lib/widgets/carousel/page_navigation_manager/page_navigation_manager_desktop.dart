import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PageNavigationManagerDesktop extends StatelessWidget {
  final void Function(bool isMobile) nextPage;
  final void Function(bool isMobile) prevPage;
  SizingInformation sizingInformation;

  PageNavigationManagerDesktop(this.nextPage, this.prevPage,this.sizingInformation);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          splashRadius: 20,
          onPressed: () => nextPage(sizingInformation.isMobile),
          icon: const Icon(
            Icons.navigate_before,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        IconButton(
          splashRadius: 20,
          onPressed: () => prevPage(sizingInformation.isMobile),
          icon: const Icon(
            Icons.navigate_next,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
