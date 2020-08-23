import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:terathon2020/src/models/interviewed_model.dart';
import 'package:terathon2020/src/providers/db_provider.dart';

class RRHHReview extends StatelessWidget {
  //const TechnicalInterviewPage({Key key}) : super(key: key);

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
            'Entrevista técnica',
            style: header,
          ),
          toolbarHeight: 100.0,
        ),
        body: SafeArea(

            child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
            children: [
              Card(
              elevation: 0.0,
              color: Color.fromRGBO(244, 244, 244, 1),
              child: ListTile(
                contentPadding: EdgeInsets.all(15.0),
                title: Text('${element.firstName} ${element.lastName}',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(117, 117, 117, 1))),
                subtitle: Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: Text('${element.area}  ·  ${element.country}',
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(117, 117, 117, 1))),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.pushNamed(context, 'detail', arguments: element);
                },
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text('${element.technicalInterviewer}',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(117, 117, 117, 1))),
                SizedBox(
                  height: 5.0,
                ),
                Text('Entrevistador asignado',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(117, 117, 117, 1))),
                SizedBox(height: 30.0),
                _createSection('Habilidades técnicas y comentarios', element.technicalFeedback != null ? element.technicalFeedback : ""),
                SizedBox(height: 150.0,),
                Container(
                  alignment: Alignment.center,
                  child: _submitButton(element, context)
                ),
                SizedBox(height: 20.0,),
                Container(
                  alignment: Alignment.center,
                  child: _cancelButton(element, context)
                )
            ],
          )
        ),
    );
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

  _submitButton(Interviewed element, BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(23.0)),
        child: Container(
            child: RaisedButton(
              textColor: Colors.white,
              onPressed: () {
                _sendFeedbackAlert(context, element, DBProvider.db.hired, '¿Deseas contratar este candidato?', 'Una vez contratado podrás verlo en en la lista de "Contratado"', 'SÍ, CONTRATAR');
              },
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              color: Color.fromRGBO(0, 45, 116, 0.9),
              child: Text(
                'CONTRATAR CANDIDATO',
                style: GoogleFonts.poppins(fontSize: 14.0, color: Colors.white),
              ),
            )));
  }

  _cancelButton(Interviewed element, BuildContext context) {
    return ClipRRect(
        child: Container(
            child: RaisedButton(
              elevation: 0.0,
              onPressed: () {
                _sendFeedbackAlert(context, element, DBProvider.db.reject, '¿Deseas rechazar este candidato?', 'Una vez rechazado podrás verlo en en la lista de "Rechazado"', 'SÍ, RECHAZAR');
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(23.0)),
                side: BorderSide(color: Color.fromRGBO(0, 45, 116, 0.9))
              ),
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              color: Colors.white,
              child: Text(
                'RECHAZAR CANDIDATO',
                style: GoogleFonts.poppins(fontSize: 14.0, color: Color.fromRGBO(0, 45, 116, 0.9)),
              ),
            )));
  }

  void _sendFeedbackAlert(BuildContext context, Interviewed element, sendToDatabase, String title, String content, String button) {
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
                        Navigator.pushNamedAndRemoveUntil(context, "/", (Route<dynamic> route) => false);
                      });
                    },
                    color: Color.fromRGBO(0, 45, 116, 0.9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.0)),
                    child: Text(button,
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
