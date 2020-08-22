import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'candidate');
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(0, 45, 116, 1),
      ),
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
