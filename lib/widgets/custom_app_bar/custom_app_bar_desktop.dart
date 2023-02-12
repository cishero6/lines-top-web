import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lines_top_web_project/providers/carousel_provider.dart';
import 'package:lines_top_web_project/providers/data_provider.dart';
import 'package:lines_top_web_project/widgets/buttons/telegram_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppBarDesktop extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  CustomAppBarDesktop(this.data);

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    int i = -1;
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 35),
      height: 80,
      color: Theme.of(context).primaryColor,
      child: Stack(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: data.map((dataPart) {
                i++;
                int tempI = i;
                return Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                            const Color.fromARGB(0, 0, 0, 0)),
                      ),
                      child: Text(dataPart['name'],
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 14)),
                      onPressed: () => Navigator.of(context)
                          .pushReplacementNamed(Provider.of<DataProvider>(context,
                                      listen: false)
                                  .data[tempI]['route_name'],
                              arguments: Provider.of<DataProvider>(context,
                                      listen: false)
                                  .data[tempI]),
                    ),
                  ],
                );
              }).toList(),
            ),
            Row(
              children: [
                TextButton(
                  style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                            const Color.fromARGB(0, 0, 0, 0)),
                      ),
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed('/about_me'),
                  child: Text('Обо мне',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14)),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40,width: 160,child: TelegramButton('https://t.me/lines_top', name: 'Наш канал',isShortened: false,color: Colors.black45,)),
                  ],
                ),
              ],
            )
          ],
        ),
        Align(
          alignment: Alignment.center,
          child: TextButton(
            onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
            style: ButtonStyle(
              overlayColor:
                  MaterialStateProperty.all(const Color.fromARGB(0, 0, 0, 0)),
            ),
            child: Image.asset(
              'assets/images/BlackLogo.jpeg',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ]),
    );
  }
}
