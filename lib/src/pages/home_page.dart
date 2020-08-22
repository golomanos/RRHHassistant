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
      ),
      appBar: AppBar(
          title: Text(
        'Nuevo Candidato',
        textAlign: TextAlign.center,
      )),
      body: Container(
        child: Column(
          children: <Widget>[
            Text('Pagina Principal'),
          ],
        ),
      ),
    );
  }
}
