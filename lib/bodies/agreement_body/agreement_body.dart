import 'dart:html';

import 'package:flutter/material.dart';
import 'package:lines_top_web_project/widgets/about_us/about_us_widget.dart';
import 'package:lines_top_web_project/widgets/carousel/page_navigation_manager/page_navigation_manager_desktop.dart';
import 'package:pdfx/pdfx.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AgreementBody extends StatelessWidget {
  AgreementBody({super.key});
  final PdfController controller = PdfController(
      document: PdfDocument.openAsset('assets/files/Agreement.pdf'));

  downloadFile(url) {
    AnchorElement anchorElement = new AnchorElement(href: url);
    anchorElement.download = "Пользовательское_соглашение_24_01_23";
    anchorElement.click();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      return Container(
        width: sizingInformation.screenSize.width * 0.7,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Пользовательское соглашение',style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 24),),
            ),
            SizedBox(
                height: sizingInformation.isMobile ? 500 : 800,
                width: 500,
                child: Card(child: PdfView(controller: controller))),
                PageNavigationManagerDesktop((isMobile)=>controller.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.ease), (isMobile)=>controller.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.ease), sizingInformation),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                  onPressed: () => downloadFile('assets/files/Agreement.pdf'),
                  child: Text(
                    'Скачать',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: const Color.fromARGB(102, 0, 0, 0),
                        fontSize: 28),
                    textAlign: TextAlign.left,
                  )),
            ),
            AboutUsWidget(sizingInformation),
          ],
        ),
      );
    });
  }
}
