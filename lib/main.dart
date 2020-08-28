import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yenesuk/widgets/title.dart';
import 'widgets/product.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff7B0567),
        accentColor: Color(0xFF1137F6),
        accentTextTheme: TextTheme(
            headline1: TextStyle(
                color: Color(0xFF1137F6),
                fontSize: 18.0,
                fontWeight: FontWeight.bold)),
        textTheme: TextTheme(
          headline6: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold)
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {},
            )
          ],
        ),
        drawer: Drawer(
            child: Container(
          child: Text(
            'Drawer text',
            style: TextStyle(color: Colors.red),
          ),
        )),
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                PrimaryTitle(title: "Featured"),
                Container(
                  height: 190.0,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        ProductWidget(),
                        ProductWidget(),
                        ProductWidget(),
                        ProductWidget(),
                        ProductWidget(),
                        ProductWidget(),
                      ]),
                )
              ]),
        ),
      ),
    );
  }
}
