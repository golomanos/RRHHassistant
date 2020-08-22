import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCandidatePage extends StatefulWidget {
  //AddCandidatePage({Key key}) : super(key: key);

  @override
  _AddCandidatePageState createState() => _AddCandidatePageState();
}

class _AddCandidatePageState extends State<AddCandidatePage> {
  String _name = '';
  String _lastname = '';
  String _email = '';
  String _date = '';
  String _selectedOption = null;
  String _countryOpt = null;
  String _linkedIn = '';
  String _actualCompany = '';
  String _phoneNumber = '';
  String _skills = '';
  String _jobPosition = '';

  final style = GoogleFonts.poppins(
      fontSize: 14.0, color: Color.fromARGB(100, 117, 117, 117));

  final header = GoogleFonts.poppins(
      fontSize: 20.0,
      color: Color.fromARGB(100, 117, 117, 117),
      fontWeight: FontWeight.w600);

  final textStyle =
      TextStyle(fontSize: 14.0, color: Color.fromRGBO(149, 149, 149, 0.5));

  TextEditingController _inputFieldDateController = new TextEditingController();

  List<String> _englishLevel = ['Básico', 'Intermedio', 'Avanzado', 'Nativo'];
  List<String> _residenceCountry = ['Venezuela', 'Colombia', 'México', 'EEUU'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Agregar candidato',
          style: header,
        ),
      ),
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
        children: [
          Column(
            children: [
              _linkedInUrl(),
              SizedBox(height: 5.0),
              _jobSeat(),
              SizedBox(height: 5.0),
              _company(),
              SizedBox(height: 5.0),
              _createName(),
              SizedBox(height: 5.0),
              _createLastName(),
              SizedBox(height: 5.0),
              _createDate(context),
              SizedBox(height: 5.0),
              _country(),
              SizedBox(height: 5.0),
              _createEmail(),
              SizedBox(height: 5.0),
              _createPhone(),
              SizedBox(height: 5.0),
              _englishLevelDropDown(),
              SizedBox(height: 5.0),
              _createSkills(),
              SizedBox(height: 5.0),
              _submitButton()
            ],
          ),
        ],
      )),
    );
  }

  Widget _createName() {
    return TextField(
      style: style,
      autofocus: false,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          hintStyle: textStyle,
          labelStyle: textStyle,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
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
      style: style,
      autofocus: false,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
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
      style: style,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          hintText: 'Email',
          labelText: 'Email'),
      onChanged: (value) {
        setState(() {
          _email = value;
        });
      },
    );
  }

  Widget _createDate(BuildContext context) {
    return TextField(
      style: style,
      enableInteractiveSelection: false,
      controller: _inputFieldDateController,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          hintText: 'Fecha de Nacimiento',
          labelText: 'Fecha de nacimiento'),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  void _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime(1980),
        firstDate: new DateTime(1970),
        lastDate: new DateTime(2024));
    if (picked != null) {
      setState(() {
        _date = picked.toString();
        _inputFieldDateController.text = _date;
      });
    }
  }

  Widget _englishLevelDropDown() {
    return Container(
      width: double.infinity,
      child: DropdownButton(
          isExpanded: true,
          hint: Text(
            'Nivel de inglés',
            style: style,
          ),
          icon: Icon(Icons.keyboard_arrow_down),
          value: _selectedOption,
          items: getDropDownOptions(_englishLevel),
          onChanged: (opt) {
            setState(() {
              _selectedOption = opt;
            });
          }),
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
      style: style,
      keyboardType: TextInputType.url,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          hintText: "URL de LinkedIn",
          labelText: 'URL de LinkedIn'),
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
      child: DropdownButton(
          isExpanded: true,
          hint: Text(
            'País de residencia',
            style: style,
          ),
          icon: Icon(Icons.keyboard_arrow_down),
          value: _countryOpt,
          items: getDropDownOptions(_residenceCountry),
          onChanged: (opt) {
            setState(() {
              _countryOpt = opt;
            });
          }),
    );
  }

  Widget _company() {
    return TextField(
      style: style,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Compañía',
        labelText: 'Compañía',
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
      style: style,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          hintText: 'Número telefónico',
          labelText: 'Teléfono'),
      onChanged: (value) {
        setState(() {
          _phoneNumber = value;
        });
      },
    );
  }

  Widget _createSkills() {
    return TextField(
      style: style,
      maxLines: 3,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          hintText: "Set de Skills del candidato",
          labelText: 'Skills'),
      onChanged: (value) {
        setState(() {
          _skills = value;
        });
      },
    );
  }

  Widget _jobSeat() {
    return TextField(
      style: style,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          hintStyle: textStyle,
          labelStyle: textStyle,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          hintText: "Cargo al que Aspira",
          labelText: 'Cargo'),
      onChanged: (value) {
        setState(() {
          _jobPosition = value;
        });
      },
    );
  }

  Widget _submitButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        width: 200.0,
        height: 46.0,
        child: RaisedButton(
          textColor: Colors.white,
          onPressed: () {},
          color: Color.fromRGBO(0, 45, 116, 0.7),
          child: Text(
            'ADD CANDIDATE',
            style: GoogleFonts.poppins(fontSize: 14.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
