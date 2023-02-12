import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lines_top_web_project/providers/debug_provider.dart';
import 'package:lines_top_web_project/views/agreement_view.dart';
import './providers/carousel_provider.dart';
import './views/home_view.dart';
import './helpers/create_material_color.dart';
import 'package:provider/provider.dart';
import './providers/data_provider.dart';
import './views/details_view.dart';
import './views/about_us_view.dart';
import './providers/page_size_provider.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
        create: (ctx) => DebugProvider(),
        ),
        ChangeNotifierProvider(
        create: (ctx) => CarouselProvider(),
        ),
        ChangeNotifierProvider(
        create: (ctx) => DataProvider(),
        ),
        ChangeNotifierProvider(
        create: (ctx) => PageSizeProvider(),
        ),
      ],
        child: MaterialApp(
          title: 'Lines.Top',
          theme: ThemeData(
            primarySwatch: createMaterialColor(Color.fromARGB(255, 255, 255, 255)),
            textTheme: TextTheme(bodyMedium: GoogleFonts.ptSerif(fontSize: 18)),
          ),
         // home: HomeView(), 
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/':
                return MaterialPageRoute(builder: (context) => HomeView());
              case '/details/marathon':
                return MaterialPageRoute(builder: (context) => DetailsView(settings.arguments as Map<String,dynamic>));
              case '/details/intensive':
                return MaterialPageRoute(builder: (context) => DetailsView(settings.arguments as Map<String,dynamic>));  
              case '/about_me':
                return MaterialPageRoute(builder: (context) => AboutUsView()); 
              case '/agreement':
                return MaterialPageRoute(builder: (context) => AgreementView()); 
              default:
            }
          },
        ),
    );
  }
}
