import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';


class WorldTime{
  // ignore: non_constant_identifier_names
  String location;
  String url;
  String flag;
  String time;
  bool isDaytime;

  // ignore: non_constant_identifier_names
  WorldTime({this.location, this.url, this.flag});

  Future<void> getTime() async {
    // make the request
    try {
      Response response = await get(
          'http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      // get properties from json
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      isDaytime = now.hour > 6 && now.hour < 19 ?  true : false;
      // set the time property
      time = DateFormat.jm().format(now);
    }catch(e){
      time = "could not get data";
    }
  }

  }





