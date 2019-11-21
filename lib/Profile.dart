import 'package:flutter/material.dart';
import './EditProfilePage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:random_color/random_color.dart';
import './toggle_widget.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _view = "networks";
  bool isSwitch = true;

  void changeToggle(value) {
    setState(() {
      isSwitch = value;
    });
  }

  List<String> events = [
    "Hackathon",
    "Junction X",
    "Industry Night",
    "Career Fair",
    "Create For Good",
    "Flutter Meetup",
    "DBS Hax",
  ];

  List<Events> recentEvents = [
    Events("Event A", "test"),
    Events("Event B", "test"),
    Events("Event C", "test"),
    Events("Event D", "test"),
    Events("Event E", "test"),
    Events("Event F", "test")
  ];

  List<Contacts> contacts = [
    Contacts("James", "Software Developer"),
    Contacts("Allison", "Frontend Designer"),
    Contacts("Dickson", "Business"),
    Contacts("Jane", "AI Specialist"),
    Contacts("David", "Cloud Specialist"),
    Contacts("Emerson", "Public Speaker"),
    Contacts("Jack Ma", "Rich Man"),
    Contacts("Elon Musk", "Crazy Man"),
  ];

  @override
  Widget build(BuildContext context) {
    Column buildStatColumn(String label, int number) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            number.toString(),
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          ),
          Container(
              margin: const EdgeInsets.only(top: 4.0),
              child: Text(
                label,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400),
              ))
        ],
      );
    }

    editProfile() {
      EditProfilePage editPage = EditProfilePage();

      Navigator.of(context)
          .push(MaterialPageRoute<bool>(builder: (BuildContext context) {
        return Center(
          child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                ),
                title: Text('Edit Profile',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                backgroundColor: Colors.white,
                actions: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.check,
                        color: Colors.blueAccent,
                      ),
                      onPressed: () {
                        Navigator.maybePop(context);
                      })
                ],
              ),
              body: ListView(
                children: <Widget>[
                  Container(
                    child: editPage,
                  ),
                ],
              )),
        );
      }));
    }

    Widget buildProfileToggle() {
      return Container(
        height: 30,
        child: ToggleWidget(
          activeBgColor: Colors.white,
          activeTextColor: Colors.black,
          inactiveBgColor: Colors.grey[400],
          inactiveTextColor: Colors.black,
          labels: ['Social', 'Biz'],
          initialLabel: 1,
          onToggle: (index) {},
        ),
      );
    }

    Container buildFollowButton(
        {String text,
        Color backgroundcolor,
        Color textColor,
        Color borderColor,
        Function function}) {
      return Container(
        padding: EdgeInsets.only(top: 2.0),
        child: Column(
          children: <Widget>[
            FlatButton(
                onPressed: function,
                child: Container(
                  decoration: BoxDecoration(
                      color: backgroundcolor,
                      border: Border.all(color: borderColor),
                      borderRadius: BorderRadius.circular(5.0)),
                  alignment: Alignment.center,
                  child: Text(text,
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.bold)),
                  width: 80,
                  height: 27.0,
                )),
          ],
        ),
      );
    }

    Container buildProfileFollowButton() {
      // viewing your own profile - should show edit button
      return buildFollowButton(
        text: "Edit",
        backgroundcolor: Colors.white,
        textColor: Colors.black,
        borderColor: Colors.grey,
        function: editProfile,
      );
    }

    Row buildImageViewButtonBar() {
      Color isActiveButtonColor(String viewName) {
        if (_view == viewName) {
          return Colors.blueAccent;
        } else {
          return Colors.black26;
        }
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.contacts, color: isActiveButtonColor("networks")),
            onPressed: () {
              setState(() {
                _view = "networks";
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.event, color: isActiveButtonColor("events")),
            onPressed: () {
              setState(() {
                _view = "events";
              });
            },
          ),
        ],
      );
    }

    List<Widget> getEventsList(List<Events> list) {
      List<Widget> childs = [];
      RandomColor r = RandomColor();

      for (var i = 0; i < list.length; i++) {
        childs.add(
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(color: r.randomColor(), boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
              ),
            ]),
            child: Text(
              recentEvents[i].eventName,
              style: TextStyle(
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
      return childs;
    }

    Container buildEvents() {
      RandomColor r = RandomColor();
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Recent Events",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            CarouselSlider(
                enlargeCenterPage: true,
                initialPage: 0,
                height: 100,
                items: getEventsList(recentEvents)),
            Container(
              height: 350,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: events.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      height: 100,
                      child: Card(
                          color: r.randomColor(),
                          child: Center(
                            child: Text(events[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 24)),
                          )));
                },
              ),
            )
          ],
        ),
      );
    }

    Padding Contact(int index, RandomColor r) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
            leading: CircleAvatar(
                backgroundColor: r.randomColor(),
                radius: 35,
                child: Text('${contacts[index].name[0]}')),
            title: Text(contacts[index].name),
            subtitle: Text(contacts[index].tag)),
      );
    }

    Widget buildNetworks() {
      RandomColor _randomColor = RandomColor();
      return Container(
        height: 400,
        child: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (BuildContext context, int index) {
            return Contact(index, _randomColor);
          },
        ),
      );
    }

    Widget buildBottomPart() {
      if (_view == "networks") {
        return buildNetworks();
      } else if (_view == "events") {
        return buildEvents();
      }
    }

    Padding buildProfile() {
      return Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: CircleAvatar(
                          radius: 40.0,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(
                              'https://epd.sutd.edu.sg/files/epdfaculty-luo-jianxi.jpg',
                              scale: 1),
                        ),
                      ),
                      buildProfileFollowButton(),
                    ],
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(top: 15.0, left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Jian Xi",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  "Entrepreneur/Investor",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            )),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(top: 1.0, left: 15),
                          child: Text("Hi I like to teach Entrepreneurship!"),
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                        Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              buildStatColumn("Networks", 123),
                              buildStatColumn("Events", 222),
                            ]),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  buildProfileToggle(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 4),
                          child: Image.asset('assets/images/facebook.png',
                              scale: 6),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 4),
                            child: Image.asset('assets/images/twitter.png',
                                scale: 6)),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 4),
                            child: Image.asset('assets/images/whatsapp.png',
                                scale: 6)),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 4),
                            child: Image.asset('assets/images/linkedin.png',
                                scale: 6)),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 4),
                          child: Image.asset('assets/images/instagram.png',
                              scale: 6),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ));
    }

    // =================== ACTUAL BUILD IS HERE =================//
    return Scaffold(
        body: ListView(
      children: <Widget>[
        buildProfile(),
        Divider(),
        buildImageViewButtonBar(),
        Divider(height: 0.0),
        buildBottomPart()
      ],
    ));
  }
}

class Contacts {
  final String name;
  final String tag;

  Contacts(this.name, this.tag);
}

class Events {
  final String eventName;
  final String bgImgPath;

  Events(this.eventName, this.bgImgPath);
}
