import 'package:flutter/material.dart';
import 'package:lines_top_web_project/widgets/buttons/cool_button.dart';
import 'package:lines_top_web_project/widgets/buttons/pay_pair_button.dart';
import 'package:lines_top_web_project/widgets/buttons/review_button.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:webviewx/webviewx.dart';
import '../../widgets/carousel/carousel_about_us.dart';
import '../../widgets/goal/goal_item.dart';
import '../../widgets/buttons/telegram_button.dart';

class UniqueAddition extends StatelessWidget {
  String name;
  Map<String, dynamic> data;
  SizingInformation sizingInformation;
  final void Function(void Function()) pageSetState;
  UniqueAddition(
      this.name, this.data, this.sizingInformation, this.pageSetState);



  @override
  Widget build(BuildContext context) {
    const String url =
        'https://yoomoney.ru/quickpay/button-widget?targets=%D0%9E%D0%BF%D0%BB%D0%B0%D1%82%D0%B0%20%D0%B8%D0%BD%D1%82%D0%B5%D0%BB%D0%BB%D0%B5%D0%BA%D1%82%D1%83%D0%B0%D0%BB%D1%8C%D0%BD%D0%BE%D0%B9%20%D1%81%D0%BE%D0%B1%D1%81%D1%82%D0%B2%D0%B5%D0%BD%D0%BD%D0%BE%D1%81%D1%82%D0%B8&default-sum=1990&button-text=11&any-card-payment-type=on&button-size=m&button-color=black&fio=on&phone=on&successURL=&quickpay=small&account=4100118024780268&';
    if (name == 'Интенсивы') {
      int milliseconds = 1200;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 60,
          ),
          ...(data['items'] as List<Map<String, dynamic>>).map(
            (e) => (sizingInformation.isMobile || sizingInformation.isTablet)
                ? Column(
                    children: [
                      const Divider(
                        thickness: 5,
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15, top: 10),
                        child: Text(
                          e['text'],
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 24),
                        ),
                      ),
                      Image(
                        image: e['image'],
                        fit: BoxFit.contain,
                        width: 200,
                        //height: 400,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          e['desc'],
                          maxLines: 100,
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      const Divider(
                        height: 5,
                        thickness: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Text(
                          e['text'],
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 24),
                        ),
                      ),
                      Row(
                        children: [
                          Flexible(
                              flex: 1,
                              child: Image(
                                image: e['image'],
                                fit: BoxFit.contain,
                                width: 200,
                                // height: 400,
                              )),
                          const SizedBox(
                            width: 30,
                          ),
                          Flexible(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Text(
                                e['desc'],
                                maxLines: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
          ),
          ...(data['goals'] as List<Map<String, dynamic>>).map(
            (e) {
              milliseconds += 400;
              return Column(
                children: [
                  const Divider(
                    thickness: 3,
                  ),
                  GoalItem(
                    e['image'],
                    e['text'],
                    waitTimer: Duration(milliseconds: milliseconds),
                    width: sizingInformation.isDesktop ? 200 : 120,
                    height: sizingInformation.isDesktop ? 100 : 70,
                    isMobile: sizingInformation.isMobile,
                  ),
                ],
              );
            },
          ),
          const Divider(
            thickness: 6,
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Text(
              data['price_text'],
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          //const WebViewX(width: 180,height: 40,initialContent: htmlLink,initialSourceType: SourceType.html,),
          //Padding(padding: const EdgeInsets.symmetric(vertical: 40),child: Text( data['questions_text'],style: Theme.of(context).textTheme.bodyMedium,textAlign: TextAlign.center,),),
          FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TelegramButton('https://t.me/stasy_ilc', name: 'Анастасия'),
              ],
            ),
          ),
          const SizedBox(
            height: 35,
          ),
        ],
      );
    }
    if (name == 'Марафоны') {
      int milliseconds = 1200;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          (sizingInformation.isMobile || sizingInformation.isTablet)
              ? Column(
                  children: [
                    ReviewButton(
                      data['buttons'][0]['title'],
                      data['buttons'][0]['text'],
                      pageSetState,
                      sizingInformation,
                      width: 330,
                      hasHoverColor: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ReviewButton(
                      data['buttons'][1]['title'],
                      data['buttons'][1]['text'],
                      pageSetState,
                      sizingInformation,
                      width: 330,
                      hasHoverColor: true,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReviewButton(
                      data['buttons'][0]['title'],
                      data['buttons'][0]['text'],
                      pageSetState,
                      sizingInformation,
                      width: 330,
                      hasHoverColor: true,
                    ),
                    ReviewButton(
                      data['buttons'][1]['title'],
                      data['buttons'][1]['text'],
                      pageSetState,
                      sizingInformation,
                      width: 330,
                      hasHoverColor: true,
                    ),
                  ],
                ),
          const SizedBox(
            height: 15,
          ),
          ...(data['goals'] as List<Map<String, dynamic>>).map(
            (e) {
              milliseconds += 400;
              return Column(
                children: [
                  const Divider(
                    thickness: 3,
                  ),
                  GoalItem(
                    e['image'],
                    e['text'],
                    waitTimer: Duration(milliseconds: milliseconds),
                    width: sizingInformation.isDesktop ? 200 : 120,
                    height: sizingInformation.isDesktop ? 100 : 70,
                    isMobile: sizingInformation.isMobile,
                  ),
                ],
              );
            },
          ),
          const Divider(
            thickness: 6,
            height: 6,
          ),
          PayPairButton(data['price_text']),

          
          //Padding(padding: const EdgeInsets.symmetric(vertical: 40),child: Text( data['questions_text'],style: Theme.of(context).textTheme.bodyMedium,textAlign: TextAlign.center,),),
          const Divider(
            thickness: 6,
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 7),
            child: Text(
              'Отзывы наших участниц',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 24),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: CarouselAboutUs(
              data['reviews'],
            ),
          ),
          const Divider(
            thickness: 6,
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: Text(
              'Часто задаваемые вопросы',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 24),
            ),
          ),
          ...(data['questions'] as List<Map<String, dynamic>>).map((e) {
            return Column(
              children: [
                const Divider(thickness: 3),
                ReviewButton(
                    e['title'], e['text'], pageSetState, sizingInformation),
              ],
            );
          }),
        ],
      );
    }
    if (name == 'Психология') {
      var milliseconds = 1200;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...(data['items'] as List<Map<String, dynamic>>).map(
            (e) => (sizingInformation.isMobile || sizingInformation.isTablet)
                ? Column(
                    children: [
                      const Divider(
                        thickness: 5,
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15, top: 10),
                        child: Text(
                          e['text'],
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Image(
                        image: e['image'],
                        fit: BoxFit.contain,
                        width: 200,
                        //height: 400,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          e['desc'],
                          maxLines: 100,
                        ),
                      ),
                      ...(data['goals'] as List<Map<String, dynamic>>).map(
                        (e) {
                          milliseconds += 400;
                          return Column(
                            children: [
                              const Divider(
                                thickness: 3,
                              ),
                              GoalItem(
                                e['image'],
                                e['text'],
                                waitTimer: Duration(milliseconds: milliseconds),
                                width: sizingInformation.isDesktop ? 200 : 120,
                                height: sizingInformation.isDesktop ? 100 : 70,
                                isMobile: sizingInformation.isMobile,
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  )
                : Column(
                    children: [
                      const Divider(
                        height: 5,
                        thickness: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Text(
                          e['text'],
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Row(
                        children: [
                          Flexible(
                              flex: 1,
                              child: Image(
                                image: e['image'],
                                fit: BoxFit.contain,
                                width: 200,
                                // height: 400,
                              )),
                          const SizedBox(
                            width: 30,
                          ),
                          Flexible(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Text(
                                e['desc'],
                                maxLines: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ...(data['goals'] as List<Map<String, dynamic>>).map(
                        (e) {
                          milliseconds += 400;
                          return Column(
                            children: [
                              const Divider(
                                thickness: 3,
                              ),
                              GoalItem(
                                e['image'],
                                e['text'],
                                waitTimer: Duration(milliseconds: milliseconds),
                                width: sizingInformation.isDesktop ? 200 : 120,
                                height: sizingInformation.isDesktop ? 100 : 70,
                                isMobile: sizingInformation.isMobile,
                              ),
                            ],
                          );
                        },
                      ),
                      const Divider(
                        thickness: 6,
                        height: 6,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Text(
                          data['price_text'],
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      //const WebViewX(width: 180,height: 40,initialContent: htmlLink,initialSourceType: SourceType.html,),
                      //Padding(padding: const EdgeInsets.symmetric(vertical: 40),child: Text( data['questions_text'],style: Theme.of(context).textTheme.bodyMedium,textAlign: TextAlign.center,),),

                      TelegramButton('https://t.me/olyasplash', name: 'Ольга'),

                      const SizedBox(
                        height: 35,
                      ),
                    ],
                  ),
          ),
        ],
      );
    }
    return const Center(
      child: Text('???'),
    );
  }
}
