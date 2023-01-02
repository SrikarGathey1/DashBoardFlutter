import 'dart:async';
import 'dart:io';
import 'dart:developer';

import 'package:win_example/user.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import "package:flutter/material.dart";

late Box box;
late Box patientBox;

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
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
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
                      child: Text("Doctor T",
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
                            controller: emailController,
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
                            obscureText: true,
                            controller: passwordController,
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
                            String userEmail = emailController.text;
                            String userPassword = passwordController.text;
                            // log(userEmail);
                            // log(userPassword);

                            // log(sample.email);
                            // if (sample.email == userEmail) {
                            // log("yep");
                            // }

                            // log(sample.password);
                            Navigator.push(context, _SearchPage());
                            emailController.clear();
                            passwordController.clear();
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
            child: ListView(
              children: [
                Center(
                  child: Column(
                    children: [
                      Text("Search Page",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              fontFamily: "Oswald",
                              color: Colors.blue[600])),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: SizedBox(
                            width: 500,
                            height: 100,
                            child: TextField(
                                decoration: InputDecoration(
                              hintText:
                                  "Search Patient Records by Name, Patient ID or Date of Birth",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              prefixIcon: Icon(Icons.search),
                            ))),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(0),
                              child: Text(
                                "Search Results",
                                style: TextStyle(
                                    fontSize: 30, color: Colors.blue[400]),
                              ),
                            )
                          ]),
                      Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Container(
                            alignment: Alignment.center,
                            width: 800,
                            height: 350,
                            child: Column(
                              children: [],
                            )),
                      ),
                      Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: ElevatedButton(
                                      onPressed: (() {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => MyApp()));
                                      }),
                                      child: Text("Back to Login"))),
                              Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: ElevatedButton(
                                      onPressed: null,
                                      child: Text("Search Records"))),
                              Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: ElevatedButton(
                                      onPressed: (() {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    _NewPatientPage()));
                                      }),
                                      child: Text("New Patient Record"))),
                              Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: ElevatedButton(
                                      onPressed: (() {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    _BreathAnalysis()));
                                      }),
                                      child: Text("View Record")))
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            )));
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
                            obscureText: true,
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
                            obscureText: true,
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
                          onPressed: (() {}),
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

class _NewPatientPage extends StatefulWidget {
  @override
  _NewPatientPageDis createState() => _NewPatientPageDis();
}

class _NewPatientPageDis extends State<_NewPatientPage> {
  bool value = false;
  var firstCon = TextEditingController();
  var middleCon = TextEditingController();
  var lastCon = TextEditingController();
  var dateController = TextEditingController();
  var genderCon = TextEditingController();
  var phoneCon = TextEditingController();
  var uidaiCon = TextEditingController();
  var heightCon = TextEditingController();
  var weightCon = TextEditingController();
  var emailCon = TextEditingController();
  var standard = 47.5;
  String? gender;
  String dropdown = "Female";
  var items = ["Female", "Male", "Non - Binary"];
  Widget build(BuildContext context) {
    String _selectedGender = "male";
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("New Patient Registration Page",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            fontFamily: "Pacifico",
                            color: Colors.blue[600]))),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "Fill the following form based on the prompts given.",
                  style: TextStyle(fontSize: 15.0),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Padding(
                          padding:
                              EdgeInsets.only(top: standard, bottom: standard),
                          child: Text("First Name"))
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Padding(
                          padding:
                              EdgeInsets.only(top: standard, bottom: standard),
                          child: Text("Middle Name"))
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Padding(
                          padding:
                              EdgeInsets.only(top: standard, bottom: standard),
                          child: Text("Last Name"))
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Padding(
                          padding:
                              EdgeInsets.only(top: standard, bottom: standard),
                          child: Text("Date Of Birth"))
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Padding(
                          padding:
                              EdgeInsets.only(top: standard, bottom: standard),
                          child: Text("Gender")),
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Padding(
                          padding:
                              EdgeInsets.only(top: standard, bottom: standard),
                          child: Text("Phone Number")),
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Padding(
                          padding:
                              EdgeInsets.only(top: standard, bottom: standard),
                          child: Text("UIDAI Number"))
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Padding(
                          padding:
                              EdgeInsets.only(top: standard, bottom: standard),
                          child: Text("Height"))
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Padding(
                          padding:
                              EdgeInsets.only(top: standard, bottom: standard),
                          child: Text("Weight"))
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Padding(
                          padding:
                              EdgeInsets.only(top: standard, bottom: standard),
                          child: Text("Email Address"))
                    ]),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(30.0),
                            child: SizedBox(
                              width: 500,
                              child: TextFormField(
                                controller: firstCon,
                                decoration: InputDecoration(
                                  hintText: "Patient's First Name",
                                  suffixIcon: Icon(Icons.person),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(30.0),
                            child: SizedBox(
                              width: 500,
                              child: TextFormField(
                                controller: middleCon,
                                decoration: InputDecoration(
                                  hintText: "Patient's Middle Name",
                                  suffixIcon: Icon(Icons.person),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(30.0),
                            child: SizedBox(
                              width: 500,
                              child: TextFormField(
                                controller: lastCon,
                                decoration: InputDecoration(
                                  hintText: "Patient's Last Name",
                                  suffixIcon: Icon(Icons.person),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                              padding: EdgeInsets.all(30.0),
                              child: SizedBox(
                                  width: 500,
                                  child: TextField(
                                      controller: dateController,
                                      decoration: const InputDecoration(
                                          icon: Icon(Icons.calendar_today),
                                          labelText: "Enter Date of Birth"),
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1965),
                                                lastDate: DateTime(2023));
                                        dateController.text = DateFormat.yMd()
                                            .format(pickedDate!);
                                      })))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(30.0),
                            child: Container(
                              width: 500,
                              child: DropdownButton(
                                value: dropdown,
                                underline: SizedBox(),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdown = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(30.0),
                            child: SizedBox(
                              width: 500,
                              child: TextFormField(
                                controller: phoneCon,
                                decoration: InputDecoration(
                                  hintText: "Patient's Contact Number",
                                  suffixIcon: Icon(Icons.phone),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(30.0),
                            child: SizedBox(
                              width: 500,
                              child: TextFormField(
                                controller: uidaiCon,
                                decoration: InputDecoration(
                                  hintText: "Patient's Adhaar Number",
                                  suffixIcon: Icon(Icons.perm_identity),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(30.0),
                            child: SizedBox(
                              width: 500,
                              child: TextFormField(
                                controller: heightCon,
                                decoration: InputDecoration(
                                  hintText:
                                      "Patient's Height in Cms(1 foot = 30.48 cm, 1 inch = 2.54 cm",
                                  suffixIcon: Icon(Icons.height),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(30.0),
                            child: SizedBox(
                              width: 500,
                              child: TextFormField(
                                controller: weightCon,
                                decoration: InputDecoration(
                                  hintText:
                                      "Patient's Weight in Kgs. 1 pound = 0.454 Kg.",
                                  suffixIcon: Icon(Icons.person_add_alt_sharp),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 30.0, bottom: 30.0, left: 85.0),
                            child: SizedBox(
                              width: 500,
                              child: TextFormField(
                                controller: emailCon,
                                decoration: InputDecoration(
                                  hintText: "Email Address",
                                  suffixIcon: Icon(Icons.email_sharp),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
                            child: TextButton(
                              onPressed: null,
                              child: Text('Verify Email',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline)),
                            ),
                          )
                        ],
                      ),
                    ]),
              )
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Checkbox(
                checkColor: Colors.blueAccent,
                value: this.value,
                onChanged: (value) {
                  setState(() {
                    this.value = value!;
                  });
                },
              ),
            ),
            Padding(
                padding: EdgeInsets.all(30.0),
                child: Text(
                  "I authorise CATS to analyze and store the data based on the recorded sample.",
                  style: TextStyle(color: Colors.grey),
                ))
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 300,
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: ElevatedButton(
                      onPressed: (() {
                        Navigator.pop(context);
                        firstCon.clear();
                        middleCon.clear();
                        lastCon.clear();
                        dateController.clear();
                        genderCon.clear();
                        phoneCon.clear();
                        uidaiCon.clear();
                        heightCon.clear();
                        weightCon.clear();
                        emailCon.clear();
                      }),
                      child: Text("Create Record"),
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0)))),
                    ),
                  )),
              SizedBox(
                  width: 300,
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: ElevatedButton(
                      onPressed: (() {
                        Navigator.pop(context);
                      }),
                      child: Text("Back To Search"),
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0)))),
                    ),
                  )),
            ],
          )
        ],
      ),
    ));
  }
}

class _BreathAnalysis extends StatefulWidget {
  @override
  _BreathAnalysisPage createState() => _BreathAnalysisPage();
}

class _BreathAnalysisPage extends State<_BreathAnalysis>
    with TickerProviderStateMixin {
  String second = "10";
  var seconds = ["10", "20", "30"];
  String dropdown = "DR-T-ALPHA01";
  var machines = ["DR-T-ALPHA01", "DR-T-BETA01"];

  late AnimationController controller;

  double progress = 1.0;
  bool isPlaying = false;

  String get countText {
    Duration count = controller.duration! * controller.value;
    return '${count.inSeconds}';
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    controller.addListener(() {
      if (controller.isAnimating) {
        setState(() {
          progress = controller.value;
        });
      } else {
        setState(() {
          progress = 1.0;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Container(
          padding: EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              children: [
                Text("Breath Analysis Page",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        fontFamily: "Oswald",
                        color: Colors.blue[600])),
                Container(
                  width: 500,
                  margin: EdgeInsets.all(30.0),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 40.0, bottom: 40.0, left: 20.0, right: 20.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Patient ID: 111122223333",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.blue.shade400),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: 10.0,
                                      bottom: 10.0,
                                      left: 20.0,
                                      right: 20.0),
                                  child: Text("Srikar" + " " + "Gade",
                                      style: TextStyle(fontSize: 30))),
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: 10.0,
                                      bottom: 10.0,
                                      left: 20.0,
                                      right: 20.0),
                                  child: Text("17/04/2000"))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: 10.0,
                                      bottom: 10.0,
                                      left: 20.0,
                                      right: 20.0),
                                  child: Text(
                                    "Male",
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: 10.0,
                                      bottom: 10.0,
                                      left: 20.0,
                                      right: 20.0),
                                  child: Text(
                                    "Height: 190 cm.",
                                  )),
                              Padding(
                                  padding:
                                      EdgeInsets.only(left: 20.0, right: 20.0),
                                  child: Text(
                                    "Weight: 75 Kg.",
                                  )),
                            ],
                          ),
                        ]),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 300,
                          height: 300,
                          child: CircularProgressIndicator(
                            value: progress,
                            strokeWidth: 6,
                          ),
                        ),
                        AnimatedBuilder(
                            animation: controller,
                            builder: (context, child) => Text(
                                  countText,
                                  style: TextStyle(fontSize: 60),
                                ))
                      ],
                    )),
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(20.0),
                    padding: EdgeInsets.only(top: 45.0),
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 15.0, bottom: 5.0, left: 15.0, right: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                alignment: Alignment.center,
                                child: SizedBox(
                                    width: 200,
                                    child: Text("Select DrT Device:"))),
                            SizedBox(
                              width: 200,
                              child: DropdownButton(
                                value: dropdown,
                                underline: SizedBox(),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: machines.map((String machines) {
                                  return DropdownMenuItem(
                                    value: machines,
                                    child: Text(machines),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdown = newValue!;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (controller.isAnimating) {
                                    controller.stop();
                                    setState(() {
                                      isPlaying = false;
                                    });
                                  } else {
                                    controller.reverse(
                                        from: controller.value == 0
                                            ? 1.0
                                            : controller.value);
                                    setState(() {
                                      isPlaying = true;
                                    });
                                  }
                                },
                                child: Text("Set Device"),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text("Duration(Secs):"),
                            ),
                            SizedBox(
                              width: 200,
                              child: DropdownButton(
                                value: second,
                                underline: SizedBox(),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: seconds.map((String seconds) {
                                  return DropdownMenuItem(
                                    value: seconds,
                                    child: Text(seconds),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    second = newValue!;
                                    if (controller.isAnimating == false) {
                                      if (newValue == "10") {
                                        controller.duration =
                                            Duration(seconds: 10);
                                      } else {
                                        if (newValue == "20") {
                                          controller.duration =
                                              Duration(seconds: 20);
                                        } else {
                                          controller.duration =
                                              Duration(seconds: 30);
                                        }
                                      }
                                    }
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                onPressed: (() {
                                  controller.reset();
                                  setState(() {
                                    isPlaying = false;
                                  });
                                }),
                                child: Text("Reset Device"),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                  onPressed: (() {}), child: Text("Normal")),
                            ),
                            SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                  onPressed: (() {}), child: Text("Medium")),
                            ),
                            SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                  onPressed: (() {}), child: Text("Heavy")),
                            )
                          ],
                        ),
                      )
                    ])),
                Padding(
                  padding: EdgeInsets.only(top: 60.0, bottom: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 200,
                          height: 80,
                          child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: ElevatedButton(
                                  onPressed: (() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => _AnalysisReport()));
                                  }),
                                  child: Text("Save And Analyse"),
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      18.0))))))),
                      SizedBox(
                          width: 200,
                          height: 80,
                          child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: ElevatedButton(
                                  onPressed: (() {
                                    Navigator.pop(context);
                                  }),
                                  child: Text("Back to Search"),
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      18.0))))))),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}

class _AnalysisReport extends StatefulWidget {
  @override
  _AnalysisReportPage createState() => _AnalysisReportPage();
}

class _AnalysisReportPage extends State<_AnalysisReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(32.0),
            child: ListView(
              children: [
                Center(
                  child: Column(
                    children: [
                      Container(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 30.0, top: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Analysis Report Page",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                          fontFamily: "Oswald",
                                          color: Colors.blue[600]))
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("Srikar" + " " + "Gade"),
                                  Text("17/04/2000"),
                                  Text("111122223333")
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("Weight:" + " " + "75 Kg"),
                                  Text("Height:" + " " + "190 cms"),
                                  Text("Gender:" + " " + "Male")
                                ],
                              ),
                            )
                          ])),
                      Padding(
                          padding: EdgeInsets.all(20.0),
                          child: SfCartesianChart(
                            margin: EdgeInsets.all(0),
                            borderWidth: 0,
                            borderColor: Colors.transparent,
                            primaryXAxis: NumericAxis(
                                minimum: 0, maximum: 10, interval: 1),
                            primaryYAxis: NumericAxis(
                                minimum: -3, maximum: 3, interval: 1),
                          )),
                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(
                              top: 40.0, bottom: 5.0, left: 10.0, right: 10.0),
                          margin: EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(children: [
                                Row(children: [
                                  Text("50 cycles/min",
                                      style: TextStyle(fontSize: 25))
                                ]),
                                Row(children: [
                                  Text(
                                    "Respiration Rate",
                                    style: TextStyle(color: Colors.grey[400]),
                                  )
                                ]),
                              ]),
                              Column(children: [
                                Row(children: [
                                  Text("50 m/sec",
                                      style: TextStyle(fontSize: 25))
                                ]),
                                Row(children: [
                                  Text("Mean Inspiration Velocity",
                                      style: TextStyle(color: Colors.grey[400]))
                                ]),
                              ]),
                              Column(children: [
                                Row(children: [
                                  Text("50 m/sec",
                                      style: TextStyle(fontSize: 25))
                                ]),
                                Row(children: [
                                  Text("Mean Expiration Velocity",
                                      style: TextStyle(color: Colors.grey[400]))
                                ]),
                              ])
                            ],
                          )),
                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(
                              top: 5.0, bottom: 10.0, left: 10.0, right: 10.0),
                          margin: EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(children: [
                                Row(children: [
                                  Text("50 Liters/sec",
                                      style: TextStyle(fontSize: 25))
                                ]),
                                Row(children: [
                                  Text(
                                    "Mean Inspiration Volume",
                                    style: TextStyle(color: Colors.grey[400]),
                                  )
                                ]),
                              ]),
                              Column(children: [
                                Row(children: [
                                  Text("50 Liters/sec",
                                      style: TextStyle(fontSize: 25))
                                ]),
                                Row(children: [
                                  Text("Mean Expiration Volume",
                                      style: TextStyle(color: Colors.grey[400]))
                                ]),
                              ]),
                              Column(children: [
                                Row(children: [
                                  Text("50 Liters/sec",
                                      style: TextStyle(fontSize: 25))
                                ]),
                                Row(children: [
                                  Text("Mean Tidal Volume",
                                      style: TextStyle(color: Colors.grey[400]))
                                ]),
                              ])
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.all(20.0),
                          child: ElevatedButton(
                              onPressed: (() {
                                Navigator.pop(context);
                              }),
                              child: Text("Back to Analyser"))),
                    ],
                  ),
                ),
              ],
            )));
  }
}
