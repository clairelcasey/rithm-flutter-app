import 'package:http/http.dart' as http;
import 'dart:convert';
String apiUrl = 'http://127.0.0.1:8000/api';

/// Get upcoming data.
/// If server response is 200:
/// - parse the JSON decoded data and return
/// Otherwise: throw error
Future<List> fetchUpcoming() async {
  final response = await http.get('$apiUrl/upcoming');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List parsedJson = jsonDecode(response.body);
    return parsedData(parsedJson);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

/// Given JSON data from /upcoming in the API:
/// - parse the data based on type of input
/// - return parsed data
/// e.g. INPUT:
///   [{
//   "exercisesession": {
//     "exercise": {
//       "id": "exercise1",
//       "title": "exerciseTitle1",
//       "description": "exersice1 description here",
//       "is_sprint": true,
//       "status": "published"
//     },
//     "cohort": {
//       "id": "r50",
//     },
//     "week_group": "",
//     "student_pairings": ""
//   },
//   "end_at": "2021-04-07T16:12:27-07:00",
//   "start_at": "2021-03-19T16:12:21-07:00",
//   "type": "exercise"
// }]
// OUTPUT:
// [{
//    'title': "exerciseTitle1",
//    'start_at': s"2021-03-19T16:12:21-07:00",
//    'end_at': "2021-04-07T16:12:27-07:00",
//    'description': "exersice1 description here",
// }]
List parsedData(List responseData) {
  List output = [];

  for (var scheduleItem in responseData) {
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
      output.add(item);

    } else {
      var item = {
        'title': scheduleItem['title'],
        'start_at': scheduleItem['start_at'],
        'end_at': scheduleItem['end_at'],
        'description': scheduleItem['description'],
      };
      output.add(item);
    }
  }
  return output;
}
