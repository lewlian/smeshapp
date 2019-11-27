import 'package:calendarro/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:calendarro/calendarro.dart';
import './Profile.dart';

class SchedulePage extends StatefulWidget {
  SchedulePage({Key key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime _selectedDate = DateTime.now();

  List<Events> scheduleEvents = [
    Events("Event A", "assets/images/event_pics/bg-7.png"),
    Events("Event B", "assets/images/event_pics/bg-2.png"),
    Events("Event C", "assets/images/event_pics/bg-3.png"),
    Events("Event D", "assets/images/event_pics/bg-4.png"),
    Events("Event E", "assets/images/event_pics/bg-5.png"),
    Events("Event F", "assets/images/event_pics/bg-6.png")
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(30),
            child: Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Calendarro(
                    startDate: DateUtils.getFirstDayOfCurrentMonth(),
                    endDate: DateUtils.getLastDayOfCurrentMonth(),
                    displayMode: DisplayMode.MONTHS,
                    onTap: (date) {
                      print(date);
                      setState(() {
                        _selectedDate = date;
                      });
                    }),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
                "${_selectedDate.year.toString()}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: scheduleEvents.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: AssetImage(scheduleEvents[index].bgImgPath),
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      child: Center(
                          child: Text(
                              scheduleEvents[index].eventName.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Colors.white))),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
