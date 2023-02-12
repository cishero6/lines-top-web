import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_saver/file_saver.dart';
import 'package:provider/provider.dart';
import '../../providers/debug_provider.dart';
import 'package:image_downloader_web/image_downloader_web.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lines_top_web_project/providers/data_provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';
import '../buttons/telegram_button.dart';
import '../buttons/cool_button.dart';


class AboutUsWidget extends StatefulWidget {
  final SizingInformation sizingInformation;
  late bool? withButton;
  AboutUsWidget(this.sizingInformation, {this.withButton});

  @override
  State<AboutUsWidget> createState() => _AboutUsWidgetState();
}

class _AboutUsWidgetState extends State<AboutUsWidget>
    with TickerProviderStateMixin {
  bool _detailsOpened = false;





  @override
  Widget build(BuildContext context) {
    var text = Provider.of<DebugProvider>(context).text;
    widget.withButton ??= true;
    return Column(
      children: [
        const Divider(thickness: 6),
        const SizedBox(
          height: 20,
        ),
        Image.asset(
          'assets/images/BlackLogo.png',
          fit: BoxFit.contain,
          height: 300,
        ),
        if (widget.withButton!)
          const SizedBox(
            height: 35,
          ),
        if (widget.withButton!)
          CoolButton(
            'Подробнее о нас',
            hoverColor: const Color.fromARGB(32, 0, 0, 0),
            primaryColor: Colors.black,
            onPressed: () =>
                Navigator.of(context).pushReplacementNamed('/about_me'),
            textStyle: Theme.of(context).textTheme.bodyMedium,
          ),
        const SizedBox(
          height: 50,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Контакты:',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 24),
            ),
            const SizedBox(
              height: 40,
            ),
            FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TelegramButton(
                    'https://t.me/lines_top',
                    name: 'Наш канал',
                    isShortened: _detailsOpened,
                  ),
                  SizedBox(
                    width: _detailsOpened ? 10 : 50,
                  ),
                  AnimatedContainer(
                    padding: EdgeInsets.only(left: _detailsOpened ? 5 : 0),
                    width: !_detailsOpened ? 160 : 320,
                    height: !_detailsOpened ? 40 : 80,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(_detailsOpened ? 4 : 50),
                      color: _detailsOpened ? Colors.black38 : Colors.black,
                    ),
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.fastLinearToSlowEaseIn,
                    child: !_detailsOpened
                        ? TextButton(
                            onPressed: () =>
                                setState((() => _detailsOpened = true)),
                            child: Text(
                              'Контакты',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: FittedBox(
                                  child: Text(
                                    text != '' ? text : 'Адрес электронной почты: nusha485@mail.ru \nИльицинская Анастасия  Евгеньевна ИНН784803690278 \nТел. +7-911-019-17-03',
                                    maxLines: 9,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: Colors.white, fontSize: 16),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                  splashRadius: double.minPositive,
                                  onPressed: () =>
                                      setState(() => _detailsOpened = false),
                                ),
                              )
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.copyright,color: Color.fromARGB(102, 0, 0, 0),),
                Text(
                  ' Все права защищены.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: const Color.fromARGB(102, 0, 0, 0), fontSize: 14),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            TextButton(onPressed: ()=>Navigator.of(context).pushReplacementNamed('/agreement'), child: Text('Пользовательское соглашение',style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: const Color.fromARGB(102, 0, 0, 0), fontSize: 14),
                  textAlign: TextAlign.left,)),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Divider(
          thickness: 6,
        ),
      ],
    );
  }
}
