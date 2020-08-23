import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:terathon2020/src/models/interviewed_model.dart';
import 'package:terathon2020/src/providers/db_provider.dart';

class TechnicalFeedbackPage extends StatefulWidget {
  //TechnicalFeedbackPage({Key key}) : super(key: key);

  @override
  _TechnicalFeedbackPageState createState() => _TechnicalFeedbackPageState();
}

class _TechnicalFeedbackPageState extends State<TechnicalFeedbackPage> {
  final header = GoogleFonts.poppins(
      fontSize: 20.0,
      color: Color.fromRGBO(117, 117, 117, 1),
      fontWeight: FontWeight.w500);

  final _style = GoogleFonts.poppins(
      fontSize: 14.0,
      color: Color.fromRGBO(117, 117, 117, 1),
      fontWeight: FontWeight.w500);

  final hintTextColorOnly =
      GoogleFonts.poppins(color: Color.fromRGBO(173, 173, 173, 1));

  final _hintText = GoogleFonts.poppins(
      fontSize: 14.0,
      color: Color.fromRGBO(173, 173, 173, 1),
      fontWeight: FontWeight.w500);

  List<String> _recruiters = [
    'Omar Fariñez',
    'Joaquin Molina',
    'José Calderon',
    'Luis Arismendi',
    'Francisco López',
    'Maria Cordobes'
  ];
  String _assignedRecruiters;

  String _techFeedback = '';

  final textStyle =
      TextStyle(fontSize: 14.0, color: Color.fromARGB(100, 117, 117, 117));

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
            _assignedRecruiter(),
            SizedBox(
              height: 20.0,
            ),
            _feedbackField(),
            SizedBox(
              height: 75.0,
            ),
            Container(
                alignment: Alignment.center,
                child: _submitButton(element, context))
          ],
        )));
  }

  _assignedRecruiter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          border: Border.all(color: Color.fromRGBO(226, 226, 226, 1))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            isExpanded: true,
            hint: Text(
              'Entrevistador asignado',
              style: _hintText,
            ),
            icon: Icon(Icons.arrow_drop_down),
            value: _assignedRecruiters,
            items: getDropDownOptions(_recruiters),
            onChanged: (opt) {
              setState(() {
                _assignedRecruiters = opt;
              });
            }),
      ),
    );
  }

  List<DropdownMenuItem<String>> getDropDownOptions(List<String> array) {
    List<DropdownMenuItem<String>> itemlist = new List();
    array.forEach((item) {
      itemlist.add(DropdownMenuItem(
        child: Text(item),
        value: item,
      ));
    });
    return itemlist;
  }

  _feedbackField() {
    return TextField(
      textAlign: TextAlign.left,
      textAlignVertical: TextAlignVertical.top,
      style: _style,
      maxLines: 10,
      cursorColor: Color.fromRGBO(0, 45, 116, 1),
      decoration: InputDecoration(
          alignLabelWithHint: true,
          hintStyle: hintTextColorOnly,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Color.fromRGBO(0, 45, 116, 1),
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Color.fromRGBO(226, 226, 226, 1))),
          hintText: "Habilidades técnicas y comentarios",
          labelText: 'Habilidades técnicas y comentarios'),
      onChanged: (value) {
        setState(() {
          _techFeedback = value;
        });
      },
    );
  }

  _submitButton(Interviewed element, BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(23.0)),
        child: Container(
            child: RaisedButton(
          textColor: Colors.white,
          onPressed: () => _sendFeedbackAlert(context, element),
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
          color: Color.fromRGBO(0, 45, 116, 0.9),
          child: Text(
            'ENVIAR A REVISIÓN DE RRHH',
            style: GoogleFonts.poppins(fontSize: 12.0, color: Colors.white),
          ),
        )));
  }

  void _sendFeedbackAlert(BuildContext context, Interviewed element) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return SimpleDialog(children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '¿Estás seguro de enviar tu feedback?',
                  style: _style,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0,),
                RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 15.0),
                  onPressed: () {
                    DBProvider.db.addTechnicalFeedback(_techFeedback, _assignedRecruiters, element.id).then( (response) {
                      _greetinsAlert(context);
                    });
                  },
                  color: Color.fromRGBO(0, 45, 116, 0.9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23.0)
                  ),
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
                          fontSize: 12.0, color: Color.fromRGBO(117, 117, 117, 1)),
                  ),
                )
              ],
            )
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 35.0),);
        });
  }

  void _greetinsAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return SimpleDialog(children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(image: AssetImage('assets/images/check_1.png'), height: 40.0,),
                SizedBox(height: 15.0),
                Text(
                  '¡Gracias por formar parte de nuestro equipo de entrevistadores!',
                  style: _style,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0,),
                RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 15.0),
                  onPressed: () => Navigator.pushNamed(context, '/'),
                  color: Color.fromRGBO(0, 45, 116, 0.9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23.0)
                  ),
                  child: Text('OK',
                      style: GoogleFonts.poppins(
                          fontSize: 12.0, color: Colors.white)),
                ),
                SizedBox(height: 15.0),
              ],
            )
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 35.0),);
      },
    ).then((value) => Navigator.pushNamed(context, '/')).catchError((value) => Navigator.pushNamed(context, '/'));
  }
}
