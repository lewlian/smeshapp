import 'package:flutter/material.dart';
import 'package:smeshapp/eventDialog.dart';
import './EditProfilePage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:random_color/random_color.dart';
import './toggle_widget.dart';
import './profileDialog.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _view = "networks";
  int isSwitch = 0;
  TextEditingController editingController = TextEditingController();

  List<String> events = [
    "Hackathon",
    "Junction X",
    "Industry Night",
    "Career Fair",
    "Create For Good",
    "Flutter Meetup",
  ];

  List<Events> recentEvents = [
    Events("Event A", "assets/images/event_pics/bg-7.png"),
    Events("Event B", "assets/images/event_pics/bg-2.png"),
    Events("Event C", "assets/images/event_pics/bg-3.png"),
    Events("Event D", "assets/images/event_pics/bg-4.png"),
    Events("Event E", "assets/images/event_pics/bg-5.png"),
    Events("Event F", "assets/images/event_pics/bg-6.png")
  ];

  List<Contacts> contacts = [
    Contacts("Jack Ma", "Rich Man", "assets/images/contact_pics/jackma.jpg",
        "19/11/19"),
    Contacts("Elon Musk", "Crazy Man",
        "assets/images/contact_pics/elonmusk.jpg", "24/07/19"),
    Contacts("James", "Software Developer",
        "assets/images/contact_pics/asianman1.png", "24/11/19"),
    Contacts("Allison", "Frontend Designer",
        "assets/images/contact_pics/girl1.jpg", "27/04/19"),
    Contacts("Dickson", "Business", "assets/images/contact_pics/man1.jpeg",
        "11/10/19"),
    Contacts("Jane", "AI Specialist", "assets/images/contact_pics/girl3.jpg",
        "02/03/19"),
    Contacts("David", "Cloud Specialist",
        "assets/images/contact_pics/whiteman.jpeg", "13/01/19"),
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
          cornerRadius: 30,
          activeBgColor: Colors.blue[200],
          activeTextColor: Colors.black,
          inactiveBgColor: Colors.grey[400],
          inactiveTextColor: Colors.black,
          labels: ['Social', 'Biz'],
          initialLabel: isSwitch,
          onToggle: (index) {
            setState(() {
              isSwitch = index;
              print(isSwitch);
            });
          },
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

    Row buildViewToggleBar() {
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

      for (var i = 0; i < list.length; i++) {
        childs.add(
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => EventDialog());
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: AssetImage(list[i].bgImgPath), fit: BoxFit.cover),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    ),
                  ]),
              child: Text(
                recentEvents[i].eventName,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
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
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => EventDialog());
                      },
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: AssetImage(recentEvents[index].bgImgPath),
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        child: Center(
                            child: Text(events[index].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Colors.white))),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      );
    }

    Padding Contact(int index) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: <Widget>[
            ListTile(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => ProfileDialog(
                          title: contacts[index].name,
                          connectedDate: contacts[index].connectedDate,
                          description:
                              "Meaningful interactions will be logged here... ",
                          buttonText: "Close",
                          profileImagePath: contacts[index].imagePath));
                },
                leading: CircleAvatar(
                  backgroundImage: AssetImage(contacts[index].imagePath),
                  radius: 30,
                ),
                title: Text(contacts[index].name),
                subtitle: Text(contacts[index].tag)),
            Divider()
          ],
        ),
      );
    }

    Widget buildNetworks() {
      return Container(
        height: 400,
        child: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (BuildContext context, int index) {
            return Contact(index);
          },
        ),
      );
    }

    Widget buildBottomPart() {
      Widget child;
      if (_view == "networks") {
        child = buildNetworks();
      } else if (_view == "events") {
        child = buildEvents();
      }
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
            child: TextField(
              style: TextStyle(
                fontSize: 14,
              ),
              onChanged: (value) {},
              controller: editingController,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 2),
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
          child
        ],
      );
    }

    Widget buildSocialMedia() {
      List<String> iconPath;
      if (isSwitch == 0) {
        iconPath = [
          'assets/images/facebook.png',
          'assets/images/twitter.png',
          'assets/images/whatsapp.png',
          'assets/images/linkedin.png',
          'assets/images/instagram.png'
        ];
      } else {
        iconPath = [
          'assets/images/facebook_un.png',
          'assets/images/twitter_un.png',
          'assets/images/whatsapp.png',
          'assets/images/linkedin.png',
          'assets/images/instagram_un.png'
        ];
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
            child: Image.asset(iconPath[0], scale: 6),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
              child: Image.asset(iconPath[1], scale: 6)),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
              child: Image.asset(iconPath[2], scale: 6)),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
              child: Image.asset(iconPath[3], scale: 6)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
            child: Image.asset(iconPath[4], scale: 6),
          ),
        ],
      );
    }

    Padding buildProfile() {
      return Padding(
          padding: EdgeInsets.fromLTRB(8.0, 0, 8, 8),
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
                          child: Text(
                              "Hi, I teach Entrepreneurship in SUTD and I am always looking out for the next big opportunity!"),
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 4)),
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
              Padding(padding: EdgeInsets.symmetric(vertical: 4)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  buildProfileToggle(),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: buildSocialMedia())
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
        buildViewToggleBar(),
        Divider(height: 0.0),
        buildBottomPart()
      ],
    ));
  }
}

class Contacts {
  final String name;
  final String tag;
  final String imagePath;
  final String connectedDate;

  Contacts(this.name, this.tag, this.imagePath, this.connectedDate);
}

class Events {
  final String eventName;
  final String bgImgPath;

  Events(this.eventName, this.bgImgPath);
}
