import 'package:flutter/material.dart';
import 'package:terathon2020/src/pages/add_candidate.dart';
import 'package:terathon2020/src/pages/home_page.dart';
import 'package:terathon2020/src/pages/technical_interview.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    'candidate': (BuildContext context) => AddCandidatePage(),
    'techinterview': (BuildContext context) => TechnicalInterviewPage()
  };
}
