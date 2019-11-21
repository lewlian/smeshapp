import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './registrationPage.dart';
import './main.dart';
import './mainPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isChecked = false;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final email = TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      validator: (String value) {
        Pattern pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regex = new RegExp(pattern);
        if (value.isEmpty) {
          return 'Please enter your email';
        } else if (!regex.hasMatch(value)) {
          return 'Enter valid email';
        }
      },
    );

    final password = TextFormField(
      controller: _passwordController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            Login newLogin = Login(
                email: _emailController.text,
                password: _passwordController.text);
            if (_isChecked) {
              saveLoginPreference(
                      _emailController.text, _passwordController.text)
                  .then((bool committed) {
                print("save is successful");
              });
            }
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainPage()));
          }
        },
        padding: EdgeInsets.all(12),
        color: Theme.of(context).primaryColor,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    final signupLabel = FlatButton(
      child: Text(
        'New user? Sign up here.',
        style: TextStyle(color: Colors.blue[300]),
      ),
      onPressed: () {
        Route route =
            MaterialPageRoute(builder: (context) => RegistrationPage());
        Navigator.push(context, route);
      },
    );

    final checkBox = new CheckboxListTile(
        title: new Text('Stay logged in.'),
        value: _isChecked,
        onChanged: (bool value) {
          setState(() {
            _isChecked = value;
          });
        });

    return Scaffold(
        key: _scaffoldstate,
        backgroundColor: Colors.white,
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 48.0),
                    email,
                    SizedBox(height: 8.0),
                    password,
                  ],
                ),
              ),
              checkBox,
              loginButton,
              forgotLabel,
              signupLabel,
            ],
          ),
        ));
  }
}

class Login {
  final String email;
  final String password;

  Login({this.email, this.password});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(email: json['email'], password: json['password']);
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['email'] = email;
    map['password'] = password;
    return map;
  }
}

Future<bool> saveLoginPreference(String email, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("password", password);
  prefs.setString("email", email);
  prefs.setBool('stayLogin', true);
  return prefs.commit();
}

Future<bool> saveUserToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("token", token);
  return prefs.commit();
}
