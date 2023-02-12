import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/data_provider.dart';

class CustomAppBarMobile extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  CustomAppBarMobile(this.data);

  @override
  Widget build(BuildContext context) {
    int i = -1;
    return Container(
        height: 80,
        padding: const EdgeInsets.only(left: 10, right: 10),
        color: Theme.of(context).primaryColor,
        child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  child: Row(
                    children: [...data.map((dataPart) {
                      i++;
                      int tempI = i;
                      return TextButton(
                        child: Text(dataPart['name'],
                            style: Theme.of(context).textTheme.bodyMedium),
                        onPressed: () => Navigator.of(context)
                            .pushReplacementNamed(Provider.of<DataProvider>(context,
                                      listen: false)
                                  .data[tempI]['route_name'],
                                arguments: Provider.of<DataProvider>(context,
                                        listen: false)
                                    .data[tempI]),
                      );
                    }).toList(),
                    const SizedBox(width: 80,),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed('/'),
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                        const Color.fromARGB(0, 0, 0, 0)),
                  ),
                  child: Image.asset(
                    'assets/images/BlackLogo.jpeg',
                    fit: BoxFit.contain,
                    width: 65,
                  ),
                ),
              ),
            ]));
  }
}
