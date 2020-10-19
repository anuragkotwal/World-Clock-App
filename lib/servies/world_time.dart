import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location;
  String time;
  String flag;
  String url;
  String date;
  bool isDaytime;

  WorldTime({this.location,this.flag,this.url});

  Future<void> getTime() async {
    try {
      Response response = await get(
          'http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      print(datetime);
      date = datetime.substring(0,10);
      String offset = data['utc_offset'];
      String offsetHours = offset.substring(0, 3);
      String offsetMinutes = offset.substring(4);
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offsetHours), minutes: int.parse(offsetMinutes)));
      isDaytime = now.hour >6  && now.hour <20  ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e){
      print('Caught error: $e');
    }
  }
}
