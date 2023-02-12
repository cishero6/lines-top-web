import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:provider/provider.dart';
import '../../providers/data_provider.dart';
import '../../widgets/buttons/telegram_button.dart';

class Stories extends StatefulWidget {
  final SizingInformation sizingInformation;
  Stories(this.sizingInformation);
  @override
  State<Stories> createState() => _StoriesState();
}

class _StoriesState extends State<Stories> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String,dynamic>> storiesData = Provider.of<DataProvider>(context).aboutUs['stories'];
    return (widget.sizingInformation.isMobile ||
            widget.sizingInformation.isTablet)
        ? Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15,top:10),
                      child: Text(
                        storiesData[0]['name'],
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 24),
                      ),
                    ),
                    Image(
                      image: storiesData[0]['image'],
                      fit: BoxFit.contain,
                      width: 200,
                      //height: 400,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        storiesData[0]['story'],
                        maxLines: 100,
                      ),
                    ),
                    TelegramButton('https://t.me/stasy_ilc', name: 'Анастасия'),
                    const SizedBox(height: 30,),
                  ],
                ),
              ),
            ],
          )
        : Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        storiesData[0]['name'],
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 24),
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                            flex: 1,
                            child: Column(
                              children: [
                                Image(
                                  image: storiesData[0]['image'],
                                  fit: BoxFit.contain,
                                  width: 200,
                                 // height: 400,
                                ),
                                const SizedBox(height: 30,),
                                TelegramButton('https://t.me/stacy_ilc', name: 'Анастасия'),
                              ],
                            )),
                        const SizedBox(
                          width: 30,
                        ),
                        Flexible(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 28),
                              child: Text(
                                storiesData[0]['story'],
                                maxLines: 40,
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
