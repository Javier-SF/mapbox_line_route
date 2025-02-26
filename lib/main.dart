import 'package:flutter/material.dart';

void main() => runApp(MyApp());


///Esta creado para creacion de ruta consumiendo las api de mapbox y token publico es algo sencillo,
///Este proyecto solo es una un ejemplo no esta totalmente afinado...
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}
