import 'package:flutter/material.dart';
import 'package:terathon2020/src/providers/db_provider.dart';
import 'package:terathon2020/src/models/interviewed_model.dart';
import 'package:terathon2020/src/search/search_delegate.dart';

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
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: false,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Image(
            alignment: AlignmentDirectional.centerStart,
            image: AssetImage('assets/images/teravisionlogo.png'),
            height: 21.0,
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Color.fromRGBO(0, 45, 116, 1),
              ),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
            )
          ],
        ),
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
              margin: EdgeInsets.only(top: 30.0, left: 16.0, right: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bienvenido a tu',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(117, 117, 117, 1)),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'ASISTENTE DE RECLUTAMIENTO',
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
            SizedBox(
              height: 20.0,
            ),
            Expanded(child: _list.length > 0 ? _creaList() : _showMessage())
          ],
        ));
  }

  Widget _createCard(double value, int index) {
    final element = _list[index];
    return GestureDetector(
      child: Card(
        margin: EdgeInsets.only(right: 16.0, left: 16.0, top: 8.0, bottom: 8.0),
        elevation: 5.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${element.firstName} ${element.lastName}',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(117, 117, 117, 1)),
              ),
              SizedBox(height: 5.0),
              Text('${element.area} . ${element.country}',
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
                  _getInterviewerImage(element.rrhhInterviewer),
                  Container(
                    margin: EdgeInsets.only(left: 5.0),
                    child: Text('${element.rrhhInterviewer}',
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
      ),
      onTap: () {
        if(element.status == 'RRHH Interview') {
          Navigator.pushNamed(context, 'rrhhinterview', arguments: element);
        } else if ( element.status == 'Technical Interview') {
          Navigator.pushNamed(context, 'techfeedback', arguments: element);
        } else {
          Navigator.pushNamed(context, 'rrhhreview', arguments: element);
        }
      } 
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
          double value = 0.0;
          switch (_activeChip) {
            case 1:
              value = 0.25;
              break;
            case 2:
              value = 0.50;
              break;
            case 3:
              value = 0.75;
              break;
            case 4:
              value = 1.0;
              break;
            default:
              value = 0.0;
          }
          return _createCard(value, index);
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          color: active == 1
              ? Color.fromRGBO(0, 101, 130, 1)
              : Color.fromRGBO(226, 226, 226, 1),
          child: Text(
            'Entrevista de RRHH',
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          color: active == 2
              ? Color.fromRGBO(87, 146, 123, 1)
              : Color.fromRGBO(226, 226, 226, 1),
          child: Text(
            'Entrevista Técnica',
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
            _getListElements('RRHH review');
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          color: active == 3
              ? Color.fromRGBO(103, 166, 94, 1)
              : Color.fromRGBO(226, 226, 226, 1),
          child: Text(
            'Revisión de RRHH',
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          color: active == 4
              ? Color.fromRGBO(119, 185, 66, 1)
              : Color.fromRGBO(226, 226, 226, 1),
          child: Text(
            'Contratado',
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          color: active == 5
              ? Color.fromRGBO(117, 117, 117, 1)
              : Color.fromRGBO(226, 226, 226, 1),
          child: Text(
            'Rechazado',
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

  Widget _getInterviewerImage(String rrhhInterviewer) {
    AssetImage image;
    if (rrhhInterviewer == 'Claudia Dos Santos') {
      image = AssetImage('assets/images/claudia.png');
    } else if (rrhhInterviewer == 'Yessnehidy Contreras') {
      image = AssetImage('assets/images/yessnehidy.png');
    } else {
      image = AssetImage('assets/images/claudia.png');
    }
    return Image(image: image, height: 25.0);
  }
}
