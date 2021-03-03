import 'package:http/http.dart' as http;
import 'dart:convert';

/// Get upcoming data.
/// If server response is 200:
/// - return parsed data
/// Otherwise: throw error
Future<List> fetchStaffMembers() async {
  final response = await http.get('http://127.0.0.1:8000/api/staff');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var parsedJson = jsonDecode(response.body);
    return parsedJson['results'];
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
