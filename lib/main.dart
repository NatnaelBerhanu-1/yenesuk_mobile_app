import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yenesuk/blocs/initbloc/initbloc.dart';
import 'package:yenesuk/blocs/initbloc/initevent.dart';
import 'package:yenesuk/blocs/initbloc/repo/initrepo.dart';
import 'package:yenesuk/blocs/postproductbloc/postproductbloc.dart';
import 'package:yenesuk/blocs/postproductbloc/repo/postadrepo.dart';
import 'package:yenesuk/blocs/productsbloc/productbloc.dart';
import 'package:yenesuk/blocs/productsbloc/productdetailbloc.dart';
import 'package:yenesuk/blocs/productsbloc/repo/productrepo.dart';
import 'package:yenesuk/screens/splashscreen/splashpage.dart';

void main() {
  final ProductRepository productRepository = ProductRepository();
  final InitRepository initRepository = InitRepository();
  final PostAdRepo postAdRepo = PostAdRepo();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ProductBloc(productRepository: productRepository)
        ),
        BlocProvider(
            create: (BuildContext context) => ProductDetailsBloc(productRepository: productRepository)
        ),
        BlocProvider(
            create: (BuildContext context) => InitBloc(initRepo: initRepository)..add(GetInit())
        ),
        BlocProvider(
          create: (BuildContext contest) => PostProductBloc(postAdRepo: postAdRepo),
        )
      ],
      child: MyApp(),
    )
    );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Abay',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: Colors.teal,
        accentColor: Color(0xFFb33225),
        accentTextTheme: TextTheme(
            headline1: TextStyle(
                color: Color(0xFF1137F6),
                fontSize: 18.0,
                fontWeight: FontWeight.bold)),
        textTheme: TextTheme(
            headline6: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
                fontWeight: FontWeight.w600),
            bodyText1: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.normal)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
    );
  }
}
