import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:smeshapp/SchedulePage.dart';
import 'package:url_launcher/url_launcher.dart';
import './SchedulePage.dart';
import './Profile.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  int _selectedPage = 1;
  final _pageOptions = [SchedulePage(), ProfilePage()];
  bool _supportsNFC = false;
  bool _reading = false;
  StreamSubscription<NDEFMessage> _stream;
  String url = "";
  String _title = "";

  @override
  void initState() {
    super.initState();
    // Check if the device supports NFC reading
    NFC.isNDEFSupported.then((bool isSupported) {
      setState(() {
        _supportsNFC = isSupported;
      });
    });
    _title = "My Profile";
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)), //this right here
          child: Container(
            height: 400.0,
            width: 300.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Tap To Connect',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15.0, 0, 15, 5),
                  child: Text(
                    'Instructions:',
                    style: TextStyle(color: Colors.blue[300]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15.0, 0, 15, 0),
                  child: Text(
                    _supportsNFC
                        ? '''1. Make sure NFC is turned on for your mobile 2. Approach a S.Mesh card to connect'''
                        : 'Your device does not support NFC',
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Image.asset('./assets/images/nfc.png'),
                ),
                //Padding(padding: EdgeInsets.only(top: 50.0)),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: RaisedButton(
                      padding: const EdgeInsets.all(0.0),
                      onPressed: () {
                        _stream?.cancel();
                        setState(() {
                          _reading = false;
                          print(_reading);
                        });
                        Navigator.of(context).pop();
                      },
                      textColor: Colors.white,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFFADD8E6),
                              Color(0xFF42A5F5),
                            ],
                          ),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: const Text('Stop Scanning',
                            style: TextStyle(fontSize: 20)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
        // return AlertDialog(
        //   title: new Text("Tap a S.Mesh card"),
        //   content: Text(_supportsNFC
        //       ? "Start Scanning"
        //       : "Your device does not support NFC!"),
        //   actions: <Widget>[
        //     // usually buttons at the bottom of the dialog
        //     new FlatButton(
        //       child: new Text("Close"),
        //       onPressed: () {
        //         _stream?.cancel();
        //         setState(() {
        //           _reading = false;
        //           print(_reading);
        //         });
        //         Navigator.of(context).pop();
        //       },
        //     ),
        //   ],
        // );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'smesh',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: (Text(_title)),
        ),
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedPage,
            onTap: (int index) {
              setState(() {
                _selectedPage = index;
                switch (_selectedPage) {
                  case 0:
                    {
                      _title = "My Schedule";
                    }
                    break;
                  case 1:
                    {
                      _title = "My Profile";
                    }
                }
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today), title: Text('Schedule')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), title: Text('Profile'))
            ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              if (_reading) {
                print(_reading);
                _stream?.cancel();
                setState(() {
                  _reading = false;
                });
              } else {
                setState(() {
                  _showDialog();
                  _reading = true;
                  print(_reading);
                  // Start reading using NFC.readNDEF()
                  _stream = NFC
                      .readNDEF(
                    once: true,
                    throwOnUserCancel: false,
                  )
                      .listen((NDEFMessage message) {
                    print("read NDEF message: ${message.payload}");
                    print("${message.payload}");
                    url = message.payload;
                    _launchURL(url);
                  }, onError: (e) {
                    // Check error handling guide below
                  });
                });
              }
            }),
      ),
    );
  }
}
