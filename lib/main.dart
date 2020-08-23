import 'package:flutter/material.dart';
import 'package:terathon2020/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Teravision - Asistente de reclutamiento',
        theme: ThemeData(
            fontFamily: 'Poppins', primaryColor: Color.fromRGBO(0, 45, 116, 1)),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: getApplicationRoutes());
  }
}
