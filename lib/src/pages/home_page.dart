import 'package:flutter/material.dart';
import 'package:terathon2020/src/providers/db_provider.dart';
import 'package:terathon2020/src/models/interviewed_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Interviewed> _list = [];
  int _activeChip = 1;

  @override
  void initState() {
    super.initState();
    _getListElements('RRHH Interview');
  }

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
              margin: EdgeInsets.only(top: 60.0, left: 16.0, right: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Image(
                          alignment: AlignmentDirectional.centerStart,
                          image: AssetImage('assets/images/teravisionlogo.png'),
                          height: 21.0,
                        ),
                      ),
                      Container(
                          child: Image(
                        image: AssetImage('assets/images/filter_icon.png'),
                        height: 48.0,
                      )),
                    ],
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
            Container(height: 35.0, child: _createChips(_activeChip)),
            Expanded(child: _list.length > 0 ? _creaList() : _showMessage())
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

  void _getListElements(status) async {
    _list = await DBProvider.db.applyFilters(status);
    setState(() {});
  }

  Color _getColor(double value) {
    if (value == 0.0) {
      return Color.fromRGBO(117, 117, 117, 1);
    } else if (value == 0.25) {
      return Color.fromRGBO(0, 101, 130, 1);
    } else if (value == 0.5) {
      return Color.fromRGBO(87, 146, 123, 1);
    } else if (value == 0.75) {
      return Color.fromRGBO(103, 166, 94, 1);
    } else {
      return Color.fromRGBO(119, 185, 66, 1);
    }
  }

  Widget _creaList() {
    return ListView.builder(
        itemCount: _list.length,
        itemBuilder: (BuildContext context, int index) {
          return _createCard(0.25);
        });
  }

  Widget _showMessage() {
    return Center(
      child: Text(
        '(+) Add a new candidate in the list',
        style: TextStyle(
            color: Color.fromRGBO(185, 185, 185, 1),
            fontSize: 12.0,
            fontWeight: FontWeight.w300),
      ),
    );
  }

  Widget _createChips(int active) {
    return ListView(scrollDirection: Axis.horizontal, children: [
      Container(
        margin: EdgeInsets.only(left: 16),
        child: RaisedButton(
          elevation: 0.0,
          onPressed: () {
            _activeChip = 1;
            _getListElements('RRHH Interview');
          },
          shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          color: active == 1 ?  Color.fromRGBO(0, 101, 130, 1) : Color.fromRGBO(226, 226, 226, 1),
          child: Text(
            'RRHH Interview',
            style: TextStyle(
                color: active == 1
                    ? Colors.white
                    : Color.fromRGBO(149, 149, 149, 1),
                fontSize: 13.0,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 16),
        child: RaisedButton(
          elevation: 0.0,
          onPressed: () {
              _activeChip = 2;
              _getListElements('Technical Interview');
          },
          shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          color: active == 2 ?  Color.fromRGBO(87, 146, 123, 1) : Color.fromRGBO(226, 226, 226, 1),
          child: Text(
            'Technical Interview',
            style: TextStyle(
                color: active == 2
                    ? Colors.white
                    : Color.fromRGBO(149, 149, 149, 1),
                fontSize: 13.0,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 16),
        child: RaisedButton(
          elevation: 0.0,
          onPressed: () {
            _activeChip = 3;
            _getListElements('In Proposal');
          },
          shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          color: active == 3 ?  Color.fromRGBO(103, 166, 94, 1) : Color.fromRGBO(226, 226, 226, 1),
          child: Text(
            'In Proposal',
            style: TextStyle(
                color: active == 3
                    ? Colors.white
                    : Color.fromRGBO(149, 149, 149, 1),
                fontSize: 13.0,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 16),
        child: RaisedButton(
          elevation: 0.0,
          onPressed: () {
            _activeChip = 4;
            _getListElements('Hired');
          },
          shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          color: active == 4 ?  Color.fromRGBO(119, 185, 66, 1) : Color.fromRGBO(226, 226, 226, 1),
          child: Text(
            'Hired',
            style: TextStyle(
                color: active == 4
                    ? Colors.white
                    : Color.fromRGBO(149, 149, 149, 1),
                fontSize: 13.0,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 16),
        child: RaisedButton(
          elevation: 0.0,
          onPressed: () {
            _activeChip = 5;
            _getListElements('Rejected');
          },
          shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          color: active == 5 ?  Color.fromRGBO(117, 117, 117, 1) : Color.fromRGBO(226, 226, 226, 1),
          child: Text(
            'Rejected',
            style: TextStyle(
                color: active == 5
                    ? Colors.white
                    : Color.fromRGBO(149, 149, 149, 1),
                fontSize: 13.0,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    ]);
  }
}
