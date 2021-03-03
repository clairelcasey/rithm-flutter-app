import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List> fetchUpcoming() async {
  final response = await http.get('http://127.0.0.1:8000/api/upcoming');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print('inside fetchUpcoming');
    List parsedJson = jsonDecode(response.body);
    return parsedData(parsedJson);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

List parsedData(List responseData) {
  List output;
  print('inside parseData');

  for (var scheduleItem in responseData) {
    print('parsedData scheduleItem $scheduleItem');
    String type = scheduleItem['type'];

    if (type == "exercise") {
      var item = {
        'title': scheduleItem['exercisesession']['exercise']['title'],
        'start_at': scheduleItem['start_at'],
        'end_at': scheduleItem['end_at'],
        'description': scheduleItem['exercisesession']['exercise']
            ['description'],
      };
      output.add(item);
    } else if (type == 'lecture') {
      var item = {
        'title': scheduleItem[type]['title'],
        'start_at': scheduleItem['start_at'],
        'end_at': scheduleItem['end_at'],
        'description': scheduleItem[type]['description'],
      };
      print('item in lecture $item');
      output.add(item);

      print('lecture $scheduleItem');
    } else {
      var item = {
        'title': scheduleItem['title'],
        'start_at': scheduleItem['start_at'],
        'end_at': scheduleItem['end_at'],
        'description': scheduleItem['description'],
      };
      print('event $scheduleItem');
      output.add(item);
    }
  }
  print('formatted data $output');
  return output;
}
