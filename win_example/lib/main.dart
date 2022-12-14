import "package:flutter/material.dart";

void main() {
  runApp(MaterialApp(
      home: MyApp(),
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.deepPurple,
        // Define the default font family.
        fontFamily: 'Helvetica',
        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      )));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Center(
                child: Card(
              color: Colors.black,
              child: Padding(
                  child: Text("Log in to continue.",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  padding: EdgeInsets.all(10.0)),
              margin: EdgeInsets.all(25.0),
            )),
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.all(20.0),
            alignment: Alignment.center));
  }
}
