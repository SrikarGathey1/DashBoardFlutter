import 'dart:async';
import 'dart:io';
import 'dart:developer';
import 'package:hive/hive.dart';
import 'package:win_example/user.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import "package:flutter/material.dart";

late Box box;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  box = await Hive.openBox<User>('users');
  box.put("venkatnaras123@gmail.com",
      User(email: "venkatnaras123@gmail.com", password: "OneTwoThree"));

  runApp(MaterialApp(
    home: MyApp(),
    routes: <String, WidgetBuilder>{
      "/patientreg": (BuildContext context) => new _NewPatientPage(),
      //add more routes here
    },
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
                            User sample = box.get(userEmail,
                                defaultValue:
                                    User(email: "email", password: "password"));
                            // log(sample.email);
                            // if (sample.email == userEmail) {
                            // log("yep");
                            // }
                            if (sample.email == "email") {
                              log("Email does not exist");
                            } else {
                              if (sample.password == userPassword) {
                                // log(sample.password);
                                Navigator.push(context, _SearchPage());
                                emailController.clear();
                                passwordController.clear();
                              } else {
                                log("Invalid password");
                              }
                            }
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
            Padding(
                padding: EdgeInsets.all(10.0),
                child: ElevatedButton(
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    child: Text("Back to Login"))),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: ElevatedButton(
                    onPressed: null, child: Text("Search Records"))),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: ElevatedButton(
                    onPressed: (() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => _NewPatientPage()));
                    }),
                    child: Text("New Patient Record"))),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: ElevatedButton(
                    onPressed: (() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => _BreathAnalysis()));
                    }),
                    child: Text("View Record")))
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
                          onPressed: (() {
                            String userEmail = emailController.text;
                            User sample = box.get(userEmail,
                                defaultValue:
                                    User(email: "email", password: "password"));
                            String userPassword = passwordController.text;
                            String userConfirm = resetController.text;
                            if (sample.email == userEmail) {
                              log("This email id already exists. Try a different one.");
                            }
                            if (userPassword == userConfirm) {
                              box.put(
                                  userEmail,
                                  User(
                                      email: userEmail,
                                      password: userPassword));
                              Navigator.pop(context);
                              emailController.clear();
                              passwordController.clear();
                              resetController.clear();
                            } else {
                              log("Passwords do not match");
                            }
                          }),
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
  var _dateController = TextEditingController();
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
                                      controller: _dateController,
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
                                        _dateController.text = DateFormat.yMd()
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
                      onPressed: (() {}),
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

class _BreathAnalysisPage extends State<_BreathAnalysis> {
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          children: [
            Text("Breath Analysis Page"),
            Padding(
                padding: EdgeInsets.all(20.0),
                child: ElevatedButton(
                    onPressed: (() {
                      Navigator.push(context, _AnalysisReportPage());
                    }),
                    child: Text("Save And Analyse"))),
            Padding(
                padding: EdgeInsets.all(20.0),
                child: ElevatedButton(
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    child: Text("Back to Search"))),
          ],
        ),
      ),
    ));
  }
}

class _AnalysisReportPage extends MaterialPageRoute {
  _AnalysisReportPage()
      : super(builder: (BuildContext context) {
          return Scaffold(
              body: Container(
            padding: EdgeInsets.all(32.0),
            child: Center(
              child: Column(
                children: [
                  Text("Analysis Report Page"),
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
          ));
        });
}
