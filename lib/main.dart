import 'package:flutter/material.dart';
import 'package:terathon2020/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Teravision Recruitment Assistant',
        theme: ThemeData(fontFamily: 'Poppins'),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: getApplicationRoutes());
  }
}
