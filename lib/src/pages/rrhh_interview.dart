import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:terathon2020/src/models/interviewed_model.dart';
import 'package:terathon2020/src/providers/db_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class RRHHInterview extends StatelessWidget {
  final header = GoogleFonts.poppins(
      fontSize: 20.0,
      color: Color.fromRGBO(117, 117, 117, 1),
      fontWeight: FontWeight.w500);

  final _style = GoogleFonts.poppins(
      fontSize: 14.0,
      color: Color.fromRGBO(117, 117, 117, 1),
      fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    final Interviewed element = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color.fromRGBO(117, 117, 117, 1)),
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text(
            'Entrevista de RRHH',
            style: header,
          ),
          actions: [
            IconButton(
                icon: Image(
                  image: AssetImage('assets/images/edit.png'),
                  height: 23.0,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'editcandidate',
                      arguments: element);
                  print('clicked');
                })
          ],
          toolbarHeight: 100.0,
        ),
        body: Container(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 30.0),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Color.fromRGBO(244, 244, 244, 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0))),
          child: ListView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${element.firstName} ${element.lastName}',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(117, 117, 117, 1))),
                SizedBox(
                  height: 5.0,
                ),
                Text('${element.area}  ·  ${element.country}',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(117, 117, 117, 1))),
                SizedBox(height: 30.0),
                _createURL('URL de Linkedin',
                    element.linkedinUrl != null ? element.linkedinUrl : ""),
                SizedBox(height: 15.0),
                _createSection('Trabajo actual',
                    element.company != null ? element.company : ""),
                SizedBox(height: 15.0),
                _createSection('Correo electrónico',
                    element.email != null ? element.email : ""),
                SizedBox(height: 15.0),
                _createSection('Número de teléfono',
                    element.phone != null ? element.phone : ""),
                SizedBox(height: 15.0),
                _createSection('Nivel de inglés',
                    element.englishLevel != null ? element.englishLevel : ""),
                SizedBox(height: 15.0),
                _createSection('Habilidades y comentarios',
                    element.skills != null ? element.skills : ""),
                SizedBox(height: 30.0),
                _createRecluter(
                    'Reclutador asignado',
                    element.rrhhInterviewer != null
                        ? element.rrhhInterviewer
                        : ""),
                SizedBox(
                  height: 45.0,
                ),
                Container(
                    alignment: Alignment.center,
                    child: _submitButton(element, context)),
                SizedBox(height: 20.0,),
                Container(
                  alignment: Alignment.center,
                  child: _cancelButton(element, context)
                )
              ],
            ),
          ]),
        ));
  }

  Widget _createSection(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.w300,
                color: Color.fromRGBO(149, 149, 149, 1))),
        SizedBox(
          height: 5.0,
        ),
        Text(subtitle,
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(149, 149, 149, 1)))
      ],
    );
  }

  Widget _createURL(String title, String url) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.w300,
                color: Color.fromRGBO(149, 149, 149, 1))),
        SizedBox(
          height: 5.0,
        ),
        GestureDetector(
          child: Text(url,
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                  color: Color.fromRGBO(149, 149, 149, 1))),
          onTap: () => _launchURL(url),
        )
      ],
    );
  }

  _createRecluter(String title, String name) {
    AssetImage image;
    if (name == 'Claudia Dos Santos') {
      image = AssetImage('assets/images/claudia.png');
    } else if (name == 'Yessnehidy Contreras') {
      image = AssetImage('assets/images/yessnehidy.png');
    } else {
      image = AssetImage('assets/images/claudia.png');
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title,
          style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.w300,
              color: Color.fromRGBO(149, 149, 149, 1))),
      SizedBox(
        height: 5.0,
      ),
      Row(
        children: [
          Image(image: image, height: 25.0),
          Container(
            margin: EdgeInsets.only(left: 5.0),
            child: Text(name,
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(149, 149, 149, 1))),
          )
        ],
      )
    ]);
  }

  _submitButton(Interviewed element, BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(23.0)),
        child: Container(
            child: RaisedButton(
          textColor: Colors.white,
          onPressed: () {
            DBProvider.db.sendToTechnicalInterview(element.id).then((response) {
              _greetinsAlert(context);
            });
          },
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
          color: Color.fromRGBO(0, 45, 116, 0.9),
          child: Text(
            'ENVIAR A ENTREVISTA TÉCNICA',
            style: GoogleFonts.poppins(fontSize: 14.0, color: Colors.white),
          ),
        )));
  }

  void _greetinsAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return SimpleDialog(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(
                  image: AssetImage('assets/images/check_1.png'),
                  height: 40.0,
                ),
                SizedBox(height: 15.0),
                Text(
                  '¡Gracias por formar parte de nuestro equipo de entrevistadores!',
                  style: _style,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  padding:
                      EdgeInsets.symmetric(horizontal: 100.0, vertical: 15.0),
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context, "/", (Route<dynamic> route) => false),
                  color: Color.fromRGBO(0, 45, 116, 0.9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23.0)),
                  child: Text('OK',
                      style: GoogleFonts.poppins(
                          fontSize: 12.0, color: Colors.white)),
                ),
                SizedBox(height: 15.0),
              ],
            )
          ],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 35.0),
        );
      },
    )
        .then((value) => Navigator.pushNamedAndRemoveUntil(
            context, "/", (Route<dynamic> route) => false))
        .catchError((value) => Navigator.pushNamedAndRemoveUntil(
            context, "/", (Route<dynamic> route) => false));
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _cancelButton(Interviewed element, BuildContext context) {
    return ClipRRect(
        child: Container(
            child: RaisedButton(
      elevation: 0.0,
      onPressed: () {
        _sendFeedbackAlert(
            context,
            element,
            DBProvider.db.reject,
            '¿Deseas rechazar este candidato?',
            'Una vez rechazado podrás verlo en en la lista de "Rechazado"');
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(23.0)),
          side: BorderSide(color: Color.fromRGBO(0, 45, 116, 0.9))),
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
      color: Colors.white,
      child: Text(
        'RECHAZAR CANDIDATO',
        style: GoogleFonts.poppins(
            fontSize: 14.0, color: Color.fromRGBO(0, 45, 116, 0.9)),
      ),
    )));
  }

  void _sendFeedbackAlert(BuildContext context, Interviewed element,
      sendToDatabase, String title, String content) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return SimpleDialog(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(117, 117, 117, 1),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    content,
                    style: _style,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  RaisedButton(
                    padding:
                        EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
                    onPressed: () {
                      sendToDatabase(element.id).then((response) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/", (Route<dynamic> route) => false);
                      });
                    },
                    color: Color.fromRGBO(0, 45, 116, 0.9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.0)),
                    child: Text('SÍ, ENVIAR',
                        style: GoogleFonts.poppins(
                            fontSize: 12.0, color: Colors.white)),
                  ),
                  SizedBox(height: 15.0),
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    color: Colors.white,
                    child: Text(
                      'NO, CANCELAR',
                      style: GoogleFonts.poppins(
                          fontSize: 12.0,
                          color: Color.fromRGBO(117, 117, 117, 1)),
                    ),
                  )
                ],
              )
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 35.0),
          );
        });
  }
}
