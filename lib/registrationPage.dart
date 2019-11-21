import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => new _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _isChecked = false;
  String _currentYearSelected;

  List<String> _gradYear = ['2019', '2020', '2021', '2022', '2023'];
  final _formKey = GlobalKey<FormState>();
  BuildContext scaffoldContext;

  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Registration',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Padding(
                padding: EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            labelText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0))),
                        keyboardType: TextInputType.emailAddress,
                        validator: (String value) {
                          Pattern pattern = r'^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$';
                          RegExp regex = new RegExp(pattern);
                          if (value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!regex.hasMatch(value)) {
                            return 'Enter valid email';
                          }
                        },
                        onSaved: (String value) {},
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                              hintText: 'Username',
                              labelText: 'Username',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter a username';
                            }
                          },
                          onSaved: (String value) {}),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      TextFormField(
                          controller: _firstNameController,
                          decoration: InputDecoration(
                              hintText: 'First Name',
                              labelText: 'First Name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                          onSaved: (String value) {}),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      TextFormField(
                          controller: _lastNameController,
                          decoration: InputDecoration(
                              hintText: 'Last Name',
                              labelText: 'Last Name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                          onSaved: (String value) {}),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter a password';
                            }
                          },
                          onSaved: (String value) {}),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            labelText: 'Confirm Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0))),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please confirm your password';
                          } else if (value != _passwordController.text) {
                            return 'Please check to make sure your  passwords match';
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      CheckboxListTile(
                        value: _isChecked,
                        onChanged: (newValue) {
                          setState(() {
                            _isChecked = newValue;
                          });
                        },
                        title: Text('I agree to the terms and condition',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 50.0),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            padding: EdgeInsets.all(12),
                            color: Theme.of(context).primaryColor,
                            child: Text('Cancel',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            onPressed: () async {
                              _formKey.currentState.save();
                              User newUser = User(
                                  email: _emailController.text,
                                  firstName: _firstNameController.text,
                                  lastName: _lastNameController.text,
                                  username: _usernameController.text,
                                  password: _passwordController.text);
                              print(newUser.toMap());
                              final response = await http.post(
                                  "http://app.smesh.me/json-user",
                                  body: newUser.toMap());
                              print(response.statusCode);
                            },
                            padding: EdgeInsets.all(12),
                            color: Theme.of(context).primaryColor,
                            child: Text('Register',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                          ),
                          RaisedButton(child: Text('Bypass'), onPressed: () {})
                        ],
                      )
                    ],
                  ),
                ));
          },
        ));
  }
}

//  Helps to define the user in a json format to send for the API

class User {
  final String email;
  final String username;
  final String password;
  final String firstName;
  final String lastName;

  User(
      {this.email,
      this.username,
      this.password,
      this.firstName,
      this.lastName});

  //Deserialize Json
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        email: json['email'],
        username: json['username'],
        password: json['password'],
        firstName: json['firstName'],
        lastName: json['lastName']);
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['email'] = email;
    map['username'] = username;
    map['password1'] = password;
    map['password2'] = password;
    map['first_name'] = firstName;
    map['last_name'] = lastName;

    return map;
  }
}
