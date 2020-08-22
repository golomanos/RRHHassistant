import 'package:flutter/material.dart';

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
  String _selectedOption = 'Básico';
  String _linkedIn = '';
  TextEditingController _inputFieldDateController = new TextEditingController();

  List<String> _englishLevel = ['Básico', 'Intermedio', 'Avanzado', 'Nativo'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
        children: [
          Column(
            children: [
              _createName(),
              SizedBox(height: 10.0),
              _createLastName(),
              SizedBox(height: 10.0),
              _createEmail(),
              SizedBox(height: 10.0),
              _createDate(context),
              SizedBox(height: 10.0),
              _englishLevelDropDown(),
              SizedBox(height: 10.0),
              _linkedInUrl(),
            ],
          ),
        ],
      )),
    );
  }

  Widget _createName() {
    return TextField(
      autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          hintText: "Nombre",
          labelText: 'Nombre',
          icon: Icon(Icons.account_circle)),
      onChanged: (value) {
        setState(() {
          _name = value;
        });
      },
    );
  }

  Widget _createLastName() {
    return TextField(
      autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          hintText: "Apellido",
          labelText: 'Apellido',
          icon: Icon(Icons.account_circle)),
      onChanged: (value) {
        setState(() {
          _lastname = value;
        });
      },
    );
  }

  Widget _createEmail() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          hintText: 'Email',
          labelText: 'Email',
          suffixIcon: Icon(Icons.alternate_email),
          icon: Icon(Icons.email)),
      onChanged: (value) {
        setState(() {
          _email = value;
        });
      },
    );
  }

  Widget _createDate(BuildContext context) {
    return TextField(
      enableInteractiveSelection: false,
      controller: _inputFieldDateController,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          hintText: 'Fecha de Nacimiento',
          labelText: 'Fecha de nacimiento',
          icon: Icon(Icons.calendar_today)),
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
    return Row(
      children: <Widget>[
        Text('Nivel de inglés:'),
        SizedBox(width: 30),
        DropdownButton(
            icon: Icon(Icons.keyboard_arrow_down),
            value: _selectedOption,
            items: getDropDownOptions(),
            onChanged: (opt) {
              setState(() {
                _selectedOption = opt;
              });
            }),
      ],
    );
  }

  List<DropdownMenuItem<String>> getDropDownOptions() {
    List<DropdownMenuItem<String>> itemlist = new List();
    _englishLevel.forEach((level) {
      itemlist.add(DropdownMenuItem(
        child: Text(level),
        value: level,
      ));
    });
    return itemlist;
  }

  Widget _linkedInUrl() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: "URL de LinkedIn",
        labelText: 'URL de LinkedIn',
        icon: Icon(Icons.work),
      ),
      onChanged: (value) {
        setState(() {
          _linkedIn = value;
        });
      },
    );
  }
}
