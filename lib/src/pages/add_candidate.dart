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
          child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
        children: [
          Column(
            children: [
              _createRecruiter(),
              SizedBox(height: 40.0),
              _linkedInUrl(),
              SizedBox(height: 20.0),
              _jobSeat(),
              SizedBox(height: 20.0),
              _company(),
              SizedBox(height: 40.0),
              _createName(),
              SizedBox(height: 20.0),
              _createLastName(),
              SizedBox(height: 20.0),
              _country(),
              SizedBox(height: 40.0),
              _createEmail(),
              SizedBox(height: 20.0),
              _createPhone(),
              SizedBox(height: 20.0),
              _englishLevelDropDown(),
              SizedBox(height: 40.0),
              _createSkills(),
              SizedBox(height: 20.0),
              _submitButton()
            ],
          ),
        ],
      )),
    );
  }

  _createRecruiter() {
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
              'Reclutador asignado',
              style: _hintText,
            ),
            value: _recruiterOpt,
            items: getDropDownOptions(_assignedRecruiter),
            onChanged: (opt) {
              setState(() {
                _recruiterOpt = opt;
              });
            }),
      ),
    );
  }

  Widget _createName() {
    return TextField(
      style: _style,
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
          hintText: "Nombre",
          labelText: 'Nombre'),
      onChanged: (value) {
        setState(() {
          _name = value;
        });
      },
    );
  }

  Widget _createLastName() {
    return TextField(
      style: _style,
      autofocus: false,
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
          hintText: "Apellido",
          labelText: 'Apellido'),
      onChanged: (value) {
        setState(() {
          _lastname = value;
        });
      },
    );
  }

  Widget _createEmail() {
    return TextField(
      style: _style,
      cursorColor: Color.fromRGBO(0, 45, 116, 1),
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

  Widget _englishLevelDropDown() {
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

  Widget _linkedInUrl() {
    return TextField(
      style: _style,
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
          hintText: "URL de Linkedin",
          labelText: 'URL de Linkedin'),
      onChanged: (value) {
        setState(() {
          _linkedIn = value;
        });
      },
    );
  }

  Widget _country() {
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
            }),
      ),
    );
  }

  Widget _company() {
    return TextField(
      style: _style,
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
        hintText: 'Trabajo actual',
        labelText: 'Trabajo actual',
      ),
      onChanged: (value) {
        setState(() {
          _actualCompany = value;
        });
      },
    );
  }

  Widget _createPhone() {
    return TextField(
      style: _style,
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

  Widget _createSkills() {
    return TextField(
      style: _style,
      maxLines: 3,
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

  Widget _jobSeat() {
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
              'Área de trabajo',
              style: _hintText,
            ),
            icon: Icon(Icons.arrow_drop_down),
            value: _workOpt,
            items: getDropDownOptions(_workArea),
            onChanged: (opt) {
              setState(() {
                _workOpt = opt;
              });
            }),
      ),
    );
  }

  Widget _submitButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25.0),
      child: Container(
        width: 200.0,
        height: 46.0,
        child: RaisedButton(
          textColor: Colors.white,
          onPressed: () {
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

            DBProvider.db.newInterviewed(interviewed);
            Navigator.pushNamed(context, '/');
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
}
