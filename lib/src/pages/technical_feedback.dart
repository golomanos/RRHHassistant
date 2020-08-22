import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:terathon2020/src/providers/db_provider.dart';

class TechnicalFeedbackPage extends StatefulWidget {
  //TechnicalFeedbackPage({Key key}) : super(key: key);

  @override
  _TechnicalFeedbackPageState createState() => _TechnicalFeedbackPageState();
}

class _TechnicalFeedbackPageState extends State<TechnicalFeedbackPage> {
  final header = GoogleFonts.poppins(
      fontSize: 20.0,
      color: Color.fromARGB(100, 117, 117, 117),
      fontWeight: FontWeight.w500);

  final style = GoogleFonts.poppins(
      fontSize: 14.0, color: Color.fromARGB(100, 117, 117, 117));

  int _candidateId;

  List<String> _recruiters = [
    'Omar Fariñez',
    'Joaquin Molina',
    'Barbara Muñoz'
  ];
  String _assignedRecruiters;

  List<String> _candidates = [
    'Omar Fariñez',
    'Joaquin Molina',
    'Barbara Muñoz'
  ];
  String _interviewedCandidate;
  String _techFeedback = '';

  final textStyle =
      TextStyle(fontSize: 14.0, color: Color.fromARGB(100, 117, 117, 117));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: Theme.of(context)
              .primaryIconTheme
              .copyWith(color: Color.fromARGB(100, 117, 117, 117)),
          backgroundColor: Colors.white,
          title: Text(
            'Technical feedback',
            style: header,
          ),
        ),
        body: SafeArea(
            child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
          children: [
            _candidateDropdown(),
            SizedBox(
              height: 10.0,
            ),
            _assignedRecruiter(),
            SizedBox(
              height: 10.0,
            ),
            _feedbackField(),
            SizedBox(
              height: 70.0,
            ),
            _submitButton()
          ],
        )));
  }

  _candidateDropdown() {
    return Container(
      width: double.infinity,
      child: DropdownButton(
          isExpanded: true,
          hint: Text(
            'Interviwed Candidate',
            style: style,
          ),
          icon: Icon(Icons.arrow_drop_down),
          items: getDropDownOptions(_candidates),
          onChanged: (opt) {
            setState(() {
              _interviewedCandidate = opt;
            });
          }),
    );
  }

  _assignedRecruiter() {
    return Container(
        width: double.infinity,
        child: DropdownButton(
            isExpanded: true,
            hint: Text(
              'Assigned Recruiter',
              style: style,
            ),
            icon: Icon(Icons.arrow_drop_down),
            value: _assignedRecruiters,
            items: getDropDownOptions(_recruiters),
            onChanged: (opt) {
              setState(() {
                _assignedRecruiters = opt;
              });
            }));
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
      style: style,
      maxLines: 15,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          hintStyle: textStyle,
          labelStyle: textStyle,
          hintText: "Skills and comments",
          labelText: 'Skills and comments'),
      onChanged: (value) {
        setState(() {
          _techFeedback = value;
        });
      },
    );
  }

  _submitButton() {
    return ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: Container(
            width: 200.0,
            height: 46.0,
            child: RaisedButton(
              textColor: Colors.white,
              onPressed: () {
                DBProvider.db
                    .addInterviewerFeedback(_techFeedback, _candidateId);
                Navigator.pushNamed(context, '/');
              },
              color: Color.fromRGBO(0, 45, 116, 0.9),
              child: Text(
                'SEND TECHNICAL FEEDBACK',
                style: GoogleFonts.poppins(fontSize: 14.0, color: Colors.white),
              ),
            )));
  }
}
