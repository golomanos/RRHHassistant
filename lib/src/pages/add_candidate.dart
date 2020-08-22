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

  final style = GoogleFonts.poppins(
      fontSize: 14.0, color: Color.fromARGB(100, 117, 117, 117));

  final header = GoogleFonts.poppins(
      fontSize: 20.0,
      color: Color.fromARGB(100, 117, 117, 117),
      fontWeight: FontWeight.w500);

  final textStyle =
      TextStyle(fontSize: 14.0, color: Color.fromARGB(100, 117, 117, 117));

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
    'QA Automation'
    'UX/UI Design',
    'Human Resources',
    'Project Management'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context)
            .primaryIconTheme
            .copyWith(color: Color.fromARGB(100, 117, 117, 117)),
        backgroundColor: Colors.white,
        title: Text(
          'Add a candidate',
          style: header,
        ),
      ),
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
        children: [
          Column(
            children: [
              _createRecruiter(),
              SizedBox(height: 5.0),
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
              _country(),
              SizedBox(height: 5.0),
              _createEmail(),
              SizedBox(height: 5.0),
              _createPhone(),
              SizedBox(height: 5.0),
              _englishLevelDropDown(),
              SizedBox(height: 5.0),
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
      child: DropdownButton(
          isExpanded: true,
          hint: Text(
            'Assigned Recruiter',
            style: style,
          ),
          icon: Icon(Icons.arrow_drop_down),
          value: _recruiterOpt,
          items: getDropDownOptions(_assignedRecruiter),
          onChanged: (opt) {
            setState(() {
              _recruiterOpt = opt;
            });
          }),
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
          hintText: "Name",
          labelText: 'Name'),
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
          hintStyle: textStyle,
          labelStyle: textStyle,
          hintText: "Last Name",
          labelText: 'Last Name'),
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
          hintStyle: textStyle,
          labelStyle: textStyle,
          hintText: 'Email',
          labelText: 'Email'),
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
      child: DropdownButton(
          isExpanded: true,
          hint: Text(
            'English level',
            style: style,
          ),
          icon: Icon(Icons.arrow_drop_down),
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
          hintStyle: textStyle,
          labelStyle: textStyle,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          hintText: "LinkedIn URL",
          labelText: 'LinkedIn URL'),
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
            'Country of residence',
            style: style,
          ),
          icon: Icon(Icons.arrow_drop_down),
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
        hintStyle: textStyle,
        labelStyle: textStyle,
        hintText: 'Actual job',
        labelText: 'Actual job',
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
          hintStyle: textStyle,
          labelStyle: textStyle,
          hintText: 'Phone Number',
          labelText: 'Phone number'),
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
          hintStyle: textStyle,
          labelStyle: textStyle,
          hintText: "Skills and comments",
          labelText: 'Skills and comments'),
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
      child: DropdownButton(
          isExpanded: true,
          hint: Text(
            'Work Area',
            style: style,
          ),
          icon: Icon(Icons.arrow_drop_down),
          value: _workOpt,
          items: getDropDownOptions(_workArea),
          onChanged: (opt) {
            setState(() {
              _workOpt = opt;
            });
          }),
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
              status: 'RRHH Interview'
            );

            DBProvider.db.newInterviewed(interviewed);
            Navigator.pushNamed(context, '/');
          },
          color: Color.fromRGBO(0, 45, 116, 0.9),
          child: Text(
            'ADD CANDIDATE',
            style: GoogleFonts.poppins(fontSize: 14.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
