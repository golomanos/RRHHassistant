import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:terathon2020/src/models/interviewed_model.dart';
import 'package:terathon2020/src/providers/db_provider.dart';

class EditCandidatePage extends StatefulWidget {
  //EditCandidatePage({Key key}) : super(key: key);

  @override
  _EditCandidatePageState createState() => _EditCandidatePageState();
}

class _EditCandidatePageState extends State<EditCandidatePage> {
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

  //TextEditingController _inputFieldDateController = new TextEditingController();

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

  final _formKey = GlobalKey<FormState>();

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
          'Editar un candidato',
          style: header,
        ),
      ),
      body: Container(
          child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
        children: [
          Column(
            children: [
              _createRecruiter(element),
              SizedBox(height: 40.0),
              _linkedInUrl(element),
              SizedBox(height: 20.0),
              _jobSeat(element),
              SizedBox(height: 20.0),
              _company(element),
              SizedBox(height: 40.0),
              _createName(element),
              SizedBox(height: 20.0),
              _createLastName(element),
              SizedBox(height: 20.0),
              _country(element),
              SizedBox(height: 40.0),
              _createEmail(element),
              SizedBox(height: 20.0),
              _createPhone(element),
              SizedBox(height: 20.0),
              _englishLevelDropDown(element),
              SizedBox(height: 40.0),
              _createSkills(element),
              SizedBox(height: 20.0),
              _submitButton(element)
            ],
          ),
        ],
      )),
    );
  }

  _createRecruiter(Interviewed element) {
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
        value: _recruiterOpt != null ? _recruiterOpt : element.rrhhInterviewer,
        items: getDropDownOptions(_assignedRecruiter),
        onChanged: (opt) {
          setState(() {
            _recruiterOpt = opt;
          });
        });
  }

  Widget _linkedInUrl(Interviewed element) {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo requerido *';
        }
        return null;
      },
      initialValue: element.linkedinUrl,
      style: _style,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      cursorColor: Color.fromRGBO(0, 45, 116, 1),
      keyboardType: TextInputType.url,
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
          hintText: "Linkedin del candidato (URL)",
          labelText: 'Linkedin del candidato (URL)'),
      onChanged: (value) {
        setState(() {
          _linkedIn = value;
        });
      },
    );
  }

  Widget _jobSeat(Interviewed element) {
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
        hint: Text(
          'Cargo laboral postulado',
          style: _hintText,
        ),
        value: _workOpt != null ? _workOpt : element.area,
        items: getDropDownOptions(_workArea),
        onChanged: (opt) {
          setState(() {
            _workOpt = opt;
          });
        });
  }

  Widget _company(Interviewed element) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo requerido *';
        }
        return null;
      },
      initialValue: element.company,
      style: _style,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      cursorColor: Color.fromRGBO(0, 45, 116, 1),
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

  Widget _createName(Interviewed element) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo requerido *';
        }
        return null;
      },
      initialValue: element.firstName,
      style: _style,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      autofocus: false,
      keyboardType: TextInputType.name,
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
        hintText: "Nombre del candidato",
        labelText: 'Nombre del candidato',
      ),
      onChanged: (value) {
        _name = value;
      },
    );
  }

  Widget _createLastName(Interviewed element) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo requerido *';
        }
        return null;
      },
      initialValue: element.lastName,
      style: _style,
      autofocus: false,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      cursorColor: Color.fromRGBO(0, 45, 116, 1),
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
          hintText: "Apellido del candidato",
          labelText: 'Apellido del candidato'),
      onChanged: (value) {
        setState(() {
          _lastname = value;
        });
      },
    );
  }

  Widget _country(Interviewed element) {
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
        value: _countryOpt != null ? _countryOpt : element.country,
        items: getDropDownOptions(_residenceCountry),
        onChanged: (opt) {
          setState(() {
            _countryOpt = opt;
          });
        });
  }

  Widget _createEmail(Interviewed element) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo requerido *';
        }
        return null;
      },
      initialValue: element.email,
      style: _style,
      cursorColor: Color.fromRGBO(0, 45, 116, 1),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      keyboardType: TextInputType.emailAddress,
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
          hintText: 'Correo electrónico',
          labelText: 'Correo electrónico'),
      onChanged: (value) {
        setState(() {
          _email = value;
        });
      },
    );
  }

  Widget _createPhone(Interviewed element) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo requerido *';
        }
        return null;
      },
      initialValue: element.phone,
      style: _style,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      cursorColor: Color.fromRGBO(0, 45, 116, 1),
      keyboardType: TextInputType.phone,
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
          hintText: 'Número de Teléfono',
          labelText: 'Número de Teléfono'),
      onChanged: (value) {
        setState(() {
          _phoneNumber = value;
        });
      },
    );
  }

  Widget _englishLevelDropDown(Interviewed element) {
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
        value: _selectedOption != null ? _selectedOption : element.englishLevel,
        items: getDropDownOptions(_englishLevel),
        onChanged: (opt) {
          setState(() {
            _selectedOption = opt;
          });
        });
  }

  Widget _createSkills(Interviewed element) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo requerido *';
        }
        return null;
      },
      initialValue: element.skills,
      style: _style,
      maxLines: 3,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
      cursorColor: Color.fromRGBO(0, 45, 116, 1),
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
          hintText: "Habilidades y comentarios",
          labelText: 'Habilidades y comentarios'),
      onChanged: (value) {
        setState(() {
          _skills = value;
        });
      },
    );
  }

  Widget _submitButton(Interviewed element) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25.0),
      child: Container(
        width: 200.0,
        height: 46.0,
        child: RaisedButton(
          textColor: Colors.white,
          onPressed: () {
            final interviewed = new Interviewed(
                id: element.id,
                rrhhInterviewer: _recruiterOpt != null
                    ? _recruiterOpt
                    : element.rrhhInterviewer,
                linkedinUrl: _linkedIn == "" ? element.linkedinUrl : _linkedIn,
                area: _workOpt != null ? _workOpt : element.area,
                company:
                    _actualCompany == "" ? element.company : _actualCompany,
                firstName: _name == "" ? element.firstName : _name,
                lastName: _lastname == "" ? element.lastName : _lastname,
                country: _countryOpt != null ? _countryOpt : element.country,
                email: _email == "" ? element.email : _email,
                phone: _phoneNumber == "" ? element.phone : _phoneNumber,
                englishLevel: _selectedOption != null
                    ? _selectedOption
                    : element.englishLevel,
                skills: _skills == "" ? element.skills : _skills,
                status: 'RRHH Interview');

            DBProvider.db.updateInterviewed(element.id, interviewed);
            _greetinsAlert(context);
            //Navigator.pushNamed(context, '/');
          },
          color: Color.fromRGBO(0, 45, 116, 0.9),
          child: Text(
            'GUARDAR',
            style: GoogleFonts.poppins(fontSize: 14.0, color: Colors.white),
          ),
        ),
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
                  'Se han guardado los cambios',
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
