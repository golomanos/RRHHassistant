import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TechnicalInterviewPage extends StatelessWidget {
  //const TechnicalInterviewPage({Key key}) : super(key: key);

  final header = GoogleFonts.poppins(
      fontSize: 20.0,
      color: Color.fromARGB(100, 117, 117, 117),
      fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: Theme.of(context)
            .primaryIconTheme
            .copyWith(color: Color.fromARGB(100, 117, 117, 117)),
        title: Text('Technical Interview', style: header),
      ),
    );
  }
}
