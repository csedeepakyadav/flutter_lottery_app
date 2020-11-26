import 'Dashboard.dart';
import 'Login.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'StateManagement/UserProvider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.green));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
         theme: ThemeData(
            primaryColor: Colors.white,
            appBarTheme: AppBarTheme(
              color: Colors.green,
            )), 
        home: NeumorphicTheme(
          usedTheme: UsedTheme.LIGHT,
          theme: NeumorphicThemeData(
            baseColor: Colors.white,
            lightSource: LightSource.topLeft,
            depth: 10,
          ),
          darkTheme: NeumorphicThemeData(
            baseColor: Color(0xFF3E3E3E),
            lightSource: LightSource.topLeft,
            depth: 6,
          ),child: Splash()),
      ),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future<bool> saveEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('email') != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();

    saveEmail().then((res) {
      if (res == true) {
        Timer(
            Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => Dashboard())));
      } else {
        Timer(
            Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) => Login())));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            'assets/images/splashgif.gif',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          )),
    );
  }
}
