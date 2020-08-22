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
  String _countryOption = 'Venezuela';
  String _linkedIn = '';
  String _actualCompany = '';
  String _phoneNumber = '';
  String _skills = '';

  TextEditingController _inputFieldDateController = new TextEditingController();

  List<String> _englishLevel = ['Básico', 'Intermedio', 'Avanzado', 'Nativo'];
  List<String> _residenceCountry = ['Venezuela', 'Colombia', 'México', 'EEUU'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar candidato'),
      ),
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
        children: [
          Column(
            children: [
              _createName(),
              SizedBox(height: 5.0),
              _createLastName(),
              SizedBox(height: 5.0),
              _createEmail(),
              SizedBox(height: 5.0),
              _createDate(context),
              SizedBox(height: 5.0),
              _englishLevelDropDown(),
              SizedBox(height: 5.0),
              _linkedInUrl(),
              SizedBox(height: 5.0),
              _country(),
              SizedBox(height: 5.0),
              _company(),
              SizedBox(height: 5.0),
              _createPhone(),
              SizedBox(height: 5.0),
              _createSkills(),
            ],
          ),
        ],
      )),
    );
  }

  Widget _createName() {
    return TextField(
      autofocus: false,
      keyboardType: TextInputType.name,
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
      autofocus: false,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.name,
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
            items: getDropDownOptions(_englishLevel),
            onChanged: (opt) {
              setState(() {
                _selectedOption = opt;
              });
            }),
      ],
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
      keyboardType: TextInputType.url,
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

  Widget _country() {
    return Row(
      children: <Widget>[
        Text('País de residencia:'),
        SizedBox(width: 30),
        DropdownButton(
            icon: Icon(Icons.keyboard_arrow_down),
            value: _countryOption,
            items: getDropDownOptions(_residenceCountry),
            onChanged: (opt) {
              setState(() {
                _countryOption = opt;
              });
            }),
      ],
    );
  }

  _company() {
    return TextField(
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

  _createPhone() {
    return TextField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Número telefónico',
        labelText: 'Teléfono',
        suffixIcon: Icon(Icons.phone),
      ),
      onChanged: (value) {
        setState(() {
          _phoneNumber = value;
        });
      },
    );
  }

  _createSkills() {
    return TextField(
      maxLines: 5,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: "Set de Skills del candidato",
        labelText: 'Skills',
        icon: Icon(Icons.view_list),
      ),
      onChanged: (value) {
        setState(() {
          _skills = value;
        });
      },
    );
  }
}
