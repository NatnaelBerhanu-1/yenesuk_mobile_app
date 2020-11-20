import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yenesuk/blocs/authbloc/authbloc.dart';
import 'package:yenesuk/blocs/loginbloc/createaccountbloc.dart';
import 'package:yenesuk/blocs/loginbloc/loginbloc.dart';
import 'package:yenesuk/blocs/initbloc/initbloc.dart';
import 'package:yenesuk/blocs/initbloc/initevent.dart';
import 'package:yenesuk/blocs/initbloc/repo/initrepo.dart';
import 'package:yenesuk/blocs/loginbloc/userrepo.dart';
import 'package:yenesuk/blocs/postproductbloc/postproductbloc.dart';
import 'package:yenesuk/blocs/productsbloc/productbloc.dart';
import 'package:yenesuk/blocs/productsbloc/productdetailbloc.dart';
import 'package:yenesuk/blocs/productsbloc/repo/productrepo.dart';
import 'package:yenesuk/screens/loginpage/createaccountpage.dart';
import 'package:yenesuk/screens/splashscreen/splashpage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  print('user: ${await FirebaseAuth.instance.currentUser()}');
  final ProductRepository productRepository = ProductRepository();
  final InitRepository initRepository = InitRepository();
  final UserRepository userRepository = UserRepository();
  final SharedPreferences preferences = await SharedPreferences.getInstance();

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
            create: (BuildContext context) => InitBloc(initRepo: initRepository, sharedPreferences: preferences)..add(GetInit())
        ),
        BlocProvider(
          create: (BuildContext context) => PostProductBloc(productRepository: productRepository, sharedPreferences: preferences),
        ),
        BlocProvider(
          create: (BuildContext context) => LoginBloc(userRepository: userRepository, sharedPreferences: preferences),
        ),
        BlocProvider(
          create: (BuildContext context) => AuthenticationBloc()..add(AppStarted()),
        ),
        BlocProvider(
          create: (BuildContext context) => CreateAccountBloc(userRepository: userRepository, sharedPreferences: preferences)
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
        accentColor: Color(0xFFFFE609),
        accentTextTheme: TextTheme(
            headline1: TextStyle(
                color: Colors.teal,
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
