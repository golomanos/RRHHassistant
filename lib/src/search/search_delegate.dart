import 'package:flutter/material.dart';
import 'package:terathon2020/src/providers/db_provider.dart';
import 'package:terathon2020/src/models/interviewed_model.dart';

class DataSearch extends SearchDelegate {
  String selection = '';

  DataSearch() : super( searchFieldLabel: 'Buscar...', searchFieldStyle: TextStyle(color: Color.fromRGBO(149, 149, 149, 1), fontSize: 16.0, fontWeight: FontWeight.w500));

  @override
  List<Widget> buildActions(Object context) {
    // Acciones en el searchbar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    //Crea los resultados que vamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Son las sugerencias cuando la persona escribe
    if (query.isEmpty) {
      return _showError();
    }

    return FutureBuilder(
      future: DBProvider.db.search(query),
      builder:
          (BuildContext context, AsyncSnapshot<List<Interviewed>> snapshot) {
        if (snapshot.hasData) {
          final elements = snapshot.data;

          return ListView(
              children: elements.map((element) {
            return _createCard(element, context);
          }).toList());
        } else {
          return _showError();
        }
      },
    );
  }

  Widget _showError() {
    return Center(
      child: Text(
        'Sin resultados',
        style: TextStyle(
            color: Color.fromRGBO(185, 185, 185, 1),
            fontSize: 12.0,
            fontWeight: FontWeight.w300),
      ),
    );
  }

  Widget _createCard(Interviewed element, BuildContext context) {
    double value = _getValue(element);
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
      },
    );
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

  double _getValue(Interviewed element) {
    double value = 0.0;
    switch (element.status) {
      case 'RRHH Interview':
        value = 0.25;
        break;
      case 'Technical Interview':
        value = 0.50;
        break;
      case 'RRHH review':
        value = 0.75;
        break;
      case 'Hired':
        value = 1.0;
        break;
      default:
        value = 0.0;
    }
    return value;
  }
}
