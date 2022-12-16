import 'dart:async';
import 'package:path/path.dart';
import "package:flutter/material.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    home: MyApp(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.blueAccent,
      fontFamily: 'Oswald',
    ),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
              width: 600,
              height: 550,
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(10.0),
              child: Card(
                margin: EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    Center(
                        child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text("Doctor -  T",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              fontFamily: "Oswald",
                              color: Colors.blueAccent)),
                    )),
                    Center(
                        child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text("Log in to continue.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          )),
                    )),
                    Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Container(
                          margin: EdgeInsets.only(left: 25.0, right: 25.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Username",
                              suffixIcon: Icon(Icons.email),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2)),
                            ),
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Container(
                          margin: EdgeInsets.only(left: 25.0, right: 25.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Password",
                              suffixIcon: Icon(Icons.password_rounded),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2)),
                            ),
                          ),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.only(left: 25.0, right: 25.0),
                            child: TextButton(
                              onPressed: (() {
                                Navigator.push(context, _ResetPasswordPage());
                              }),
                              child: Text('Reset Password',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline)),
                            ))),
                    Padding(
                        padding: EdgeInsets.all(25.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, _SearchPage());
                          },
                          child: Text("Log In"),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0)))),
                        )),
                    Row(children: <Widget>[
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Divider()),
                      ),
                      Text("OR"),
                      Expanded(
                          child: new Container(
                              margin: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Divider()))
                    ]),
                    Padding(
                        padding: EdgeInsets.all(
                            10.0), // "Don't have an account? Sign Up!"
                        child: TextButton(
                          onPressed: (() {
                            Navigator.push(context, _RegisterPage());
                          }),
                          child: Text("Don't have an account? Sign Up!",
                              style: TextStyle(
                                  decoration: TextDecoration.underline)),
                        )),
                  ],
                ),
              ))),
    );
  }
}

class _SearchPage extends MaterialPageRoute {
  _SearchPage()
      : super(builder: (BuildContext context) {
          return _SearchPageWidget();
        });
}

class _SearchPageWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          children: [
            Text("Search Page. Login Successful."),
            ElevatedButton(
                onPressed: (() {
                  Navigator.pop(context);
                }),
                child: Text("Back to Login")),
            ElevatedButton(
                onPressed: null, child: Text("Records from Database"))
          ],
        ),
      ),
    ));
  }
}

class _RegisterPage extends MaterialPageRoute {
  _RegisterPage()
      : super(builder: (BuildContext context) {
          return _RegisterPageWidget();
        });
}

class _RegisterPageWidget extends StatelessWidget {
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final resetController = new TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
              width: 600,
              height: 600,
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(10.0),
              child: Card(
                margin: EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    Center(
                        child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text("Doctor -  T",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              fontFamily: "Oswald",
                              color: Colors.blueAccent)),
                    )),
                    Center(
                        child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text("Register for a Doctor T account.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          )),
                    )),
                    Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Container(
                          margin: EdgeInsets.only(left: 25.0, right: 25.0),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: "Email",
                              suffixIcon: Icon(Icons.email),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2)),
                            ),
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Container(
                          margin: EdgeInsets.only(left: 25.0, right: 25.0),
                          child: TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              hintText: "Create a password",
                              suffixIcon: Icon(Icons.password_rounded),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2)),
                            ),
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Container(
                          margin: EdgeInsets.only(left: 25.0, right: 25.0),
                          child: TextFormField(
                            controller: resetController,
                            decoration: InputDecoration(
                              hintText: "Confirm Password",
                              suffixIcon: Icon(Icons.password_rounded),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2)),
                            ),
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.all(25.0),
                        child: ElevatedButton(
                          onPressed: null,
                          child: Text("Register"),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0)))),
                        )),
                    Row(children: <Widget>[
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 25.0, right: 25.0),
                            child: Divider()),
                      ),
                      Text("OR"),
                      Expanded(
                          child: new Container(
                              margin: const EdgeInsets.only(
                                  left: 25.0, right: 25.0),
                              child: Divider())),
                    ]),
                    Padding(
                        padding: EdgeInsets.all(
                            10.0), // "Don't have an account? Sign Up!"
                        child: TextButton(
                          onPressed: (() {
                            Navigator.pop(context);
                          }),
                          child: Text("Already have an account? Sign Up.",
                              style: TextStyle(
                                  decoration: TextDecoration.underline)),
                        )),
                  ],
                ),
              ))),
    );
  }
}

class _ResetPasswordPage extends MaterialPageRoute {
  _ResetPasswordPage()
      : super(builder: (BuildContext context) {
          return Scaffold(
              body: Container(
            padding: EdgeInsets.all(32.0),
            child: Center(
              child: Column(
                children: [
                  Text("Reset Password Page"),
                  ElevatedButton(
                      onPressed: (() {
                        Navigator.pop(context);
                      }),
                      child: Text("Back to Login"))
                ],
              ),
            ),
          ));
        });
}

class UserData {
  final String email;
  final String password;

  UserData({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      'password': password,
    };
  }
}
