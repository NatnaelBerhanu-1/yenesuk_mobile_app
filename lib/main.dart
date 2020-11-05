import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yenesuk/blocs/productsbloc/productbloc.dart';
import 'package:yenesuk/blocs/productsbloc/repo/productrepo.dart';
import 'package:yenesuk/screens/homepage/homepage.dart';
import 'package:yenesuk/screens/loginpage/loginpage.dart';

void main() {
  final ProductRepository productRepository = ProductRepository();
  runApp(MyApp(productRepository: productRepository));
}

class MyApp extends StatelessWidget {
  final ProductRepository productRepository;
  MyApp({Key key, @required this.productRepository}):assert(productRepository!=null), super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Abay',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: Color(0xff2e6591),
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
      home: HomePage(),
    );
  }
}
