import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:terathon2020/src/models/interviewed_model.dart';
import 'package:terathon2020/src/providers/db_provider.dart';

class AddCandidatePage extends StatefulWidget {
  //AddCandidatePage({Key key}) : super(key: key);

  @override
  _AddCandidatePageState createState() => _AddCandidatePageState();
}

class _AddCandidatePageState extends State<AddCandidatePage> {
  String _name = '';
  String _lastname = '';
  String _email = '';
  String _recruiterOpt = null;
  String _selectedOption = null;
  String _countryOpt = null;
  String _linkedIn = '';
  String _actualCompany = '';
  String _phoneNumber = '';
  String _skills = '';
  String _jobPosition = '';
  String _workOpt = null;

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

  final header = GoogleFonts.poppins(
      fontSize: 20.0,
      color: Color.fromRGBO(117, 117, 117, 1),
      fontWeight: FontWeight.w500);

  final _formKey = GlobalKey<FormState>();

  List<String> _englishLevel = ['Básico', 'Intermedio', 'Avanzado', 'Nativo'];
  List<String> _residenceCountry = ['Venezuela', 'Colombia', 'México', 'EEUU'];
  List<String> _assignedRecruiter = [
    'Claudia Dos Santos',
    'Yessnehidy Contreras'
  ];

  List<String> _workArea = [
    'Developer',
    'QA Analyst',
    'QA Automation',
    'UX/UI Design',
    'Human Resources',
    'Project Management'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color.fromRGBO(117, 117, 117, 1)),
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text(
            'Agrega un candidato',
            style: header,
          ),
        ),
        body: Container(
          child: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
                children: [
                  Column(
                    children: [
                      _createRecruiter(),
                      SizedBox(height: 50.0),
                      _linkedInUrl(),
                      SizedBox(height: 20.0),
                      _jobSeat(),
                      SizedBox(height: 20.0),
                      _company(),
                      SizedBox(height: 20.0),
                      _createName(),
                      SizedBox(height: 20.0),
                      _createLastName(),
                      SizedBox(height: 20.0),
                      _country(),
                      SizedBox(height: 20.0),
                      _createEmail(),
                      SizedBox(height: 20.0),
                      _createPhone(),
                      SizedBox(height: 20.0),
                      _englishLevelDropDown(),
                      SizedBox(height: 20.0),
                      _createSkills(),
                      SizedBox(height: 20.0),
                      _submitButton(context)
                    ],
                  ),
                ],
              )),
        ));
  }

  _createRecruiter() {
    return DropdownButtonFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo requerido *';
          }
          return null;
        },
        decoration: InputDecoration(
          hintStyle: hintTextColorOnly,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Color.fromRGBO(0, 45, 116, 1),
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Color.fromRGBO(226, 226, 226, 1))),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        isExpanded: true,
        hint: Text(
          'Reclutador asignado',
          style: _hintText,
        ),
        value: _recruiterOpt,
        items: getDropDownOptions(_assignedRecruiter),
        onChanged: (opt) {
          setState(() {
            _recruiterOpt = opt;
          });
        });
  }

  Widget _createName() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo requerido *';
        }
        return null;
      },
      style: _style,
      autofocus: false,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      cursorColor: Color.fromRGBO(0, 45, 116, 1),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          hintStyle: hintTextColorOnly,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Color.fromRGBO(0, 45, 116, 1),
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Color.fromRGBO(226, 226, 226, 1))),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          hintText: "Nombre del candidato",
          labelText: 'Nombre del candidato'),
      onChanged: (value) {
        setState(() {
          _name = value;
        });
      },
    );
  }

  Widget _createLastName() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo requerido *';
        }
        return null;
      },
      style: _style,
      autofocus: false,
      cursorColor: Color.fromRGBO(0, 45, 116, 1),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
          hintStyle: hintTextColorOnly,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Color.fromRGBO(0, 45, 116, 1),
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Color.fromRGBO(226, 226, 226, 1))),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          hintText: "Apellido del candidato",
          labelText: 'Apellido del candidato'),
      onChanged: (value) {
        setState(() {
          _lastname = value;
        });
      },
    );
  }

  Widget _createEmail() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo requerido *';
        }
        return null;
      },
      style: _style,
      cursorColor: Color.fromRGBO(0, 45, 116, 1),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      decoration: InputDecoration(
          hintStyle: hintTextColorOnly,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Color.fromRGBO(0, 45, 116, 1),
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Color.fromRGBO(226, 226, 226, 1))),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          hintText: 'Correo electrónico',
          labelText: 'Correo electrónico'),
      onChanged: (value) {
        setState(() {
          _email = value;
        });
      },
    );
  }

  Widget _englishLevelDropDown() {
    return DropdownButtonFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo requerido *';
          }
          return null;
        },
        decoration: InputDecoration(
          hintStyle: hintTextColorOnly,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Color.fromRGBO(0, 45, 116, 1),
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Color.fromRGBO(226, 226, 226, 1))),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        isExpanded: true,
        hint: Text(
          'Nivel de Inglés',
          style: _hintText,
        ),
        icon: Icon(Icons.arrow_drop_down),
        value: _selectedOption,
        items: getDropDownOptions(_englishLevel),
        onChanged: (opt) {
          setState(() {
            _selectedOption = opt;
          });
        });
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

  Widget _linkedInUrl() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo requerido *';
        }
        return null;
      },
      style: _style,
      cursorColor: Color.fromRGBO(0, 45, 116, 1),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      decoration: InputDecoration(
          hintStyle: hintTextColorOnly,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Color.fromRGBO(0, 45, 116, 1),
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Color.fromRGBO(226, 226, 226, 1))),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          hintText: "Linkedin del candidato (URL)",
          labelText: 'Linkedin del candidato (URL)'),
      onChanged: (value) {
        setState(() {
          _linkedIn = value;
        });
      },
    );
  }

  Widget _country() {
    return DropdownButtonFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo requerido *';
          }
          return null;
        },
        decoration: InputDecoration(
          hintStyle: hintTextColorOnly,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Color.fromRGBO(0, 45, 116, 1),
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Color.fromRGBO(226, 226, 226, 1))),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        isExpanded: true,
        hint: Text(
          'País de residencia',
          style: _hintText,
        ),
        icon: Icon(Icons.arrow_drop_down),
        value: _countryOpt,
        items: getDropDownOptions(_residenceCountry),
        onChanged: (opt) {
          setState(() {
            _countryOpt = opt;
          });
        });
  }

  Widget _company() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo requerido *';
        }
        return null;
      },
      style: _style,
      cursorColor: Color.fromRGBO(0, 45, 116, 1),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      decoration: InputDecoration(
        hintStyle: hintTextColorOnly,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Color.fromRGBO(0, 45, 116, 1),
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Color.fromRGBO(226, 226, 226, 1))),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: '¿Dónde trabaja actualmente?',
        labelText: '¿Dónde trabaja actualmente?',
      ),
      onChanged: (value) {
        setState(() {
          _actualCompany = value;
        });
      },
    );
  }

  Widget _createPhone() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo requerido *';
        }
        return null;
      },
      style: _style,
      cursorColor: Color.fromRGBO(0, 45, 116, 1),
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      decoration: InputDecoration(
          hintStyle: hintTextColorOnly,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Color.fromRGBO(0, 45, 116, 1),
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Color.fromRGBO(226, 226, 226, 1))),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          hintText: 'Número de Teléfono',
          labelText: 'Número de Teléfono'),
      onChanged: (value) {
        setState(() {
          _phoneNumber = value;
        });
      },
    );
  }

  Widget _createSkills() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo requerido *';
        }
        return null;
      },
      style: _style,
      maxLines: 3,
      cursorColor: Color.fromRGBO(0, 45, 116, 1),
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          hintText: "Habilidades y comentarios",
          labelText: 'Habilidades y comentarios'),
      onChanged: (value) {
        setState(() {
          _skills = value;
        });
      },
    );
  }

  Widget _jobSeat() {
    return DropdownButtonFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo requerido *';
          }
          return null;
        },
        isExpanded: true,
        decoration: InputDecoration(
          hintStyle: hintTextColorOnly,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Color.fromRGBO(0, 45, 116, 1),
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Color.fromRGBO(226, 226, 226, 1))),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        hint: Text(
          'Cargo laboral postulado',
          style: _hintText,
        ),
        icon: Icon(Icons.arrow_drop_down),
        value: _workOpt,
        items: getDropDownOptions(_workArea),
        onChanged: (opt) {
          setState(() {
            _workOpt = opt;
          });
        });
  }

  Widget _submitButton(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25.0),
      child: Container(
        width: 200.0,
        height: 46.0,
        child: RaisedButton(
          textColor: Colors.white,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              final interviewed = new Interviewed(
                  rrhhInterviewer: _recruiterOpt,
                  linkedinUrl: _linkedIn,
                  area: _workOpt,
                  company: _actualCompany,
                  firstName: _name,
                  lastName: _lastname,
                  country: _countryOpt,
                  email: _email,
                  phone: _phoneNumber,
                  englishLevel: _selectedOption,
                  skills: _skills,
                  status: 'RRHH Interview');

              DBProvider.db.newInterviewed(interviewed).then((response) {
                _greetinsAlert(context);
              });
            }
          },
          color: Color.fromRGBO(0, 45, 116, 0.9),
          child: Text(
            'AGREGAR CANDIDATO',
            style: GoogleFonts.poppins(fontSize: 14.0, color: Colors.white),
          ),
        ),
      ),
    );
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
                  '¡Listo! Se ha agregado el nuevo candidato a la lista "Entrevista de RRHH"',
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

}
