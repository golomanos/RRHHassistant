import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'candidate');
          },
          child: Icon(Icons.add),
          backgroundColor: Color.fromRGBO(0, 45, 116, 1),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 60.0, left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: AssetImage('assets/images/teravisionlogo.png'),
                    height: 21.0,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    'Welcome to your',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(117, 117, 117, 1)),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'RECRUITMENT ASSISTANT',
                    style: TextStyle(
                        fontSize: 18.0,
                        height: 1.6,
                        fontWeight: FontWeight.w300,
                        color: Color.fromRGBO(117, 117, 117, 1)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Container(
              margin: EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                          style: TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.w500),
                          cursorColor: Color.fromRGBO(0, 45, 116, 1),
                          decoration: InputDecoration(
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    width: 0.0,
                                    color: Color.fromRGBO(244, 244, 244, 1))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    width: 0.0,
                                    color: Color.fromRGBO(244, 244, 244, 1))),
                            fillColor: Color.fromRGBO(244, 244, 244, 1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: 'Search...',
                          ),
                          onChanged: (value) {})),
                  Container(
                      margin: EdgeInsets.only(left: 20.0),
                      child: Image(
                        image: AssetImage('assets/images/filter_icon.png'),
                        height: 54.0,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
                child: ListView(
              children: [
                _createCard(0.25),
                _createCard(0.5),
                _createCard(0.75),
                _createCard(1.0),
                _createCard(0.25),
                _createCard(0.5),
                _createCard(0.75),
                _createCard(1.0),
                _createCard(0.25),
                _createCard(0.5),
                _createCard(0.75),
                _createCard(1.0),
              ],
            ))
          ],
        ));
  }

  Widget _createCard(double value) {
    return Card(
      margin: EdgeInsets.only(right: 16.0, left: 16.0, top: 8.0, bottom: 8.0),
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Barbara Muñoz',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(117, 117, 117, 1)),
            ),
            SizedBox(height: 5.0),
            Text('UX/UI Designer . Colombia',
                style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(149, 149, 149, 1))),
            SizedBox(height: 20.0),
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                child: LinearProgressIndicator(
                  value: value,
                  backgroundColor: Color.fromRGBO(226, 226, 226, 1),
                  minHeight: 6.0,
                  valueColor: AlwaysStoppedAnimation<Color>(_getColor(value)),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Image(
                    image: AssetImage('assets/images/claudia.png'),
                    height: 25.0),
                Container(
                  margin: EdgeInsets.only(left: 5.0),
                  child: Text('Claudia dos Santos',
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(149, 149, 149, 1))),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Color _getColor(double value) {
    if (value == 0.25) {
      return Color.fromRGBO(0, 101, 130, 1);
    } else if (value == 0.5) {
      return Color.fromRGBO(87, 146, 123, 1);
    } else if (value == 0.75) {
      return Color.fromRGBO(103, 166, 94, 1);
    } else {
      return Color.fromRGBO(119, 185, 66, 1);
    }
  }
}
