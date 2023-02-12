import '../bodies/home_body/home_body.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../providers/data_provider.dart';

import '../widgets/custom_app_bar/custom_app_bar.dart';

class HomeView extends StatelessWidget {
  final drawerKey = GlobalKey<ScaffoldState>();
  final Widget? child;
  HomeView({Key? key, this.child}) : super(key: key);
    final List<Map<String,dynamic>> _data = [
    {
      'name': 'Хуй',
      'tagline' : 'Крутой хуй',
      'short_desc' : 'хуй ваще залупа прям круто',
      'long_desc': 'ХУЙХУЙХУЙХУЙХУЙХУЙХУЙХУЙХУЙХУЙХУЙХУЙХУЙХУЙХ',
      'image': AssetImage('assets/images/bubbles2.jpeg')
    },
    {
      'name': 'Пенис',
      'tagline' : 'Ебейший пенис',
      'short_desc' : 'Пенис прям вообще пушка ае',
      'long_desc': 'Подробно про марафоны',
      'image': AssetImage('assets/images/photo1.jpg')
    },
    {
      'name': 'Моча',
      'tagline' : 'Ебанутая моча',
      'short_desc' : 'Моча прям нассал с кайфом',
      'long_desc': 'Подробно про псиологию',
      'image': AssetImage('assets/images/bubbles1.jpeg'),
    }
  ];


  final String _aboutUs = 'Подробно про вас там как-то дадададдадададдадададдадададдадададдадададдадададдадададдадададдадададдадададдададад';
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAppBar(),
            Expanded(child: HomeBody(_aboutUs)),
          ],
        ),
        );
      }
    );
  }
}
