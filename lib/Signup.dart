import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:convert';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Dashboard.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String gender = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _radioValue = 3; // no choice

  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _contactNo = TextEditingController();

  String error = '';
  bool emailexist = false;
  bool isLoading = false;

  bool checkValidation() {
    if (_name.text != "" &&
        _email.text != "" &&
        _password.text != "" &&
        _contactNo.text != "" &&
        gender != '') {
      if (int.parse(_contactNo.text).isNaN) {
        error = "contact no must be numbers.";
        return false;
      } else {
        return true;
      }
    } else {
      error = 'All fields required';
      return false;
    }
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          gender = '';
          print(gender);
          break;
        case 1:
          gender = 'Male';
          print(gender);
          break;
        case 2:
          gender = 'Female';
          print(gender);
          break;
      }
    });
  }

 

  Dio _dio = new Dio();

  Future<String> crateProfile() async {
    setState(() {
      isLoading = true;
    });
    FormData formData = new FormData.fromMap({
      "name": _name.text,
      "email": _email.text,
      "password": _password.text,
      "contact_no": _contactNo.text,
      "gender": gender,
      "date": formattedDate,
    });

    try {
      var response = await _dio.post(
        "https://procery.ml/user/createprofile.php",
        data: formData,
        onSendProgress: (int sent, int total) {
          print(sent / total);
        },
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.data);

        print(responseBody['status']);
        return responseBody['status'];
      } else {
        print('no response');
        return 'not updated';
      }
    } catch (e) {
      print(e);
      return 'not updated';
    }
  }

  Future<String> saveEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', _email.text);

    if (prefs.getString('email') != null) {
      return prefs.getString('email');
    } else {
      return 'no email';
    }
  }

  String formattedDate = '';
  @override
  void initState() {
    DateTime now = DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(now);
    print(formatted);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: isLoading == false
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  /*   Center(
                      child: Image.asset(
                    'logo',
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.1,
                  )), */
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Signup Here',
                    style: TextStyle(fontSize: 26),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                 
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.1,
                        right: MediaQuery.of(context).size.width * 0.1),
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: _name,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        hintStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              width: 2,
                              style: BorderStyle.solid,
                              color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              width: 2,
                              style: BorderStyle.solid,
                              color: Colors.blue),
                        ),
                        filled: true,
                        contentPadding: EdgeInsets.all(16),
                        fillColor: Color(0xfff2f5f3),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.1,
                        right: MediaQuery.of(context).size.width * 0.1),
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: _email,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Email Id',
                        hintStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              width: 2,
                              style: BorderStyle.solid,
                              color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              width: 2,
                              style: BorderStyle.solid,
                              color: Colors.blue),
                        ),
                        filled: true,
                        contentPadding: EdgeInsets.all(16),
                        fillColor: Color(0xfff2f5f3),
                      ),
                      onChanged: (_) {
                        setState(() {
                          emailexist = false;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  emailexist == true
                      ? Center(
                          child: Text(
                            'Email already exists, Try signin with this email or use another',
                            style: TextStyle(color: Colors.red, fontSize: 10),
                          ),
                        )
                      : Center(),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.1,
                        right: MediaQuery.of(context).size.width * 0.1),
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: _password,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              width: 2,
                              style: BorderStyle.solid,
                              color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              width: 2,
                              style: BorderStyle.solid,
                              color: Colors.blue),
                        ),
                        filled: true,
                        contentPadding: EdgeInsets.all(16),
                        fillColor: Color(0xfff2f5f3),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.1,
                        right: MediaQuery.of(context).size.width * 0.1),
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: _contactNo,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Contact No.',
                        hintStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              width: 2,
                              style: BorderStyle.solid,
                              color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              width: 2,
                              style: BorderStyle.solid,
                              color: Colors.blue),
                        ),
                        filled: true,
                        contentPadding: EdgeInsets.all(16),
                        fillColor: Color(0xfff2f5f3),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Radio(
                        value: 1,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChange,
                      ),
                      new Text(
                        'Male',
                        style: new TextStyle(fontSize: 16.0),
                      ),
                      new Radio(
                        value: 2,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChange,
                      ),
                      new Text(
                        'Female',
                        style: new TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Material(
                        child: InkWell(
                          onTap: () {
                            if (checkValidation() == false) {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  'All fields required.',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );

                              _scaffoldKey.currentState.showSnackBar(snackBar);

                              print(error);
                            } else {
                              crateProfile().then((res) {
                                if (res == 'updated') {
                                  print('yes');
                                  setState(() {
                                    //   isLoading = false;
                                  });
                                  saveEmail().then((email) {
                                    print(email);
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                Dashboard()));
                                  });
                                } else if (res == 'exist') {
                                  setState(() {
                                    emailexist = true;
                                    isLoading = false;
                                  });
                                } else {
                                  print('error');
                                  setState(() {
                                    isLoading = false;
                                  });
                                  final snackBar = SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      'Some Error Occured.',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );

                                  _scaffoldKey.currentState
                                      .showSnackBar(snackBar);
                                }
                              });
                            }
                          },
                          child: Card(
                            elevation: 8,
                            shape: StadiumBorder(
                              side: BorderSide(
                                color: Colors.green,
                                width: 2.0,
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(color: Colors.green),
                                textScaleFactor: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            )
          : Center(
              child: AwesomeLoader(
              loaderType: AwesomeLoader.AwesomeLoader4,
              color: Colors.green,
            )),
    );
  }
}
