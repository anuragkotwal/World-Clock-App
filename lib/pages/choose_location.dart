import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:world_time_app/servies/world_time.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';

class Chooselocation extends StatefulWidget {
  @override
  _ChooselocationState createState() => _ChooselocationState();
}

class Debouncer {
final int milliseconds;
VoidCallback action;
Timer _timer;

Debouncer({this.milliseconds});

run(VoidCallback action) {
  if (null != _timer) {
    _timer.cancel();
  }
  _timer = Timer(Duration(milliseconds: milliseconds), action);
}
}

class _ChooselocationState extends State<Chooselocation> {

  final _debouncer = Debouncer(milliseconds: 500);
  List<WorldTime> _originallocation = _locationitem()._location;
  List<WorldTime> filteredlocation = _locationitem()._location;

  void updateTime(index) async{
    WorldTime instance = filteredlocation[index];
    await instance.getTime();
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime' : instance.isDaytime,
      'date': instance.date,
    });
  }

  @override
  void initState() {
    super.initState();
      setState(() {
        filteredlocation = _originallocation;
    });
  }
  Widget build(BuildContext context) {
    //print('built function run');
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Choose Location'),
        backgroundColor: Colors.blue[800],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15.0),
              hintText: 'Search Location',
            ),
            onChanged: (text) {
            _debouncer.run(() {
              setState(() {
                filteredlocation = _originallocation.where((element) =>
                (element.location.toLowerCase().contains(text.toLowerCase()))).toList();
              });
            });
            },
          ),
          Expanded (
            child: ListView.builder(
                itemCount: filteredlocation.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          updateTime(index);
                        },
                        title: Text(filteredlocation[index].location),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage('Assets/${ filteredlocation[index].flag}'),
                        ),
                      ),
                    ),
                  );
                }
            ),
          )
        ],
    ),
    );
  }
}

class _locationitem {
  List<WorldTime> _location = [WorldTime(url: 'Asia/Kolkata', location: 'India', flag: 'india.jpg'),
    WorldTime(url: 'Europe/London', location: 'London', flag: 'london.jpg'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.jpg'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.jpg'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'africa.jpg'),
    WorldTime(url: 'Asia/Bangkok', location: 'Bangkok', flag: 'thailand.jpg'),
    WorldTime(url: 'Australia/Sydney', location: 'Sydney', flag: 'australia.jpg'),
    WorldTime(url: 'Etc/GMT+5', location: 'Colombia', flag: 'colombia.jpg'),
    WorldTime(url: 'Indian/Mauritius', location: 'Mauritius', flag: 'mauritius.jpg'),
    WorldTime(url: 'Europe/Vienna', location: 'Vienna', flag: 'vienna.jpg'),
    WorldTime(url: 'Europe/Athens', location: 'Athens', flag: 'athens.jpg'),
    WorldTime(url: 'Europe/Berlin', location: 'Berlin', flag: 'berlin.jpg'),
    WorldTime(url: 'Europe/Brussels', location: 'Brussels', flag: 'bruseels.jpg'),
    WorldTime(url: 'Europe/Prague', location: 'Prague', flag: 'prague.jpg'),
    WorldTime(url: 'Asia/Beirut', location: 'Beirut', flag: 'beirut.jpg'),
    WorldTime(url: 'Asia/Kathmandu', location: 'Kathmandu', flag: 'nepal.jpg'),
    WorldTime(url: 'Asia/Hong_Kong', location: 'Hong Kong', flag: 'hongkong.jpg'),
    WorldTime(url: 'Asia/Singapore', location: 'Singapore', flag: 'singapore.jpg'),
    WorldTime(url: 'Atlantic/South_Georgia', location: 'South Georgia', flag: 'south_georgia.jpg'),
    WorldTime(url: 'Atlantic/Bermuda', location: 'Bermuda', flag: 'bermunda.jpg'),
    WorldTime(url: 'Asia/Almaty', location: 'Almaty', flag: 'almaty.jpg'),
  ];
}